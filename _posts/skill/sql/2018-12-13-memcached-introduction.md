---
layout: post
title: "Memcached 的介绍及使用"
date: 2018-12-13 19:23
author: "Oscaner"
header-img: "assets/img/post-bg-alitrip.jpg"
multilingual: false
mathjax: false
no-catalog: false
categories:
  - skill
  - sql
  - memcached
tags:
  - Skill
  - SQL
  - Memcached
---

## 基础命令

### 增删改查

> 增

```shell
> add key flag expire length
# key：给值起一个独特的名字
# flag：标志，要求为一个正整数
# expire：有效期
# length：数据长度
```

- Flag 的意义

Memcached 的基本文本协议要求数据以字符串形式存储。

这意味着，当你需要存入的数据为数组、对象等非字符串类型时，需要先将数据进行序列化。

但是，当其他人取数据进行反序列化后，他并不知道数据原本的类型，进行判断又显得累赘增加劳动力。

这时候，Flag 就有了用武之地。

比如规定：0表示字符串，1表示数组，2表示对象，以及其他等等类型。

- Expire 的意义

设置缓存的有效期，有 3 种格式：

1. 设置秒数，从设定开始第 N 秒后失效
2. 时间戳，到指定的时间戳后失效
3. 设为 0，不自动失效。注意，是不自动失效，而不是永久有效。Memcached 在编译时有设定最长有效期，设为 0 但超过最长有效期后，仍会失效。

- Length

length 设置有多长，值也必须有多长，不然会报 `CLIENT_ERROR bad data chunk` 错误

> 删

```shell
> delete key [time]
```

`time` 为可选参数，单位为秒。意为被删除的 key，在 N 秒内不能再使用，目的是让网站上的页面缓存也代谢完毕

> 改

```shell
> replace key flag expire length # 替换键值
```

参数与 `add` 命令一致

> 查

```shell
> get key
```

### 有改无增

```shell
> set key flag expire length
```

### 自增自减

```shell
> incr key number # 键值自增 number
> decr key number # 键值自减 number
```

自增自减是以 32 位无符号来进行加减操作的，故不存在负值。

自减至最小为 `0`，自增最大至 `2^32 - 1`

> 应用场景

1. 秒杀功能

一个人下单，需要牵涉数据库读取、写入订单、更改库存及事务要求。对于关系型数据库而言，压力是巨大的。

可以利用 Memcached 的 incr 功能，在内存存储 count 计数，每抢成功一次就 incr 加一。这样，每人抢单主要在内存操作，响应速度快。

当 count 在设定范围内，比如库存仅 1000 台，那么当 count &lt;= 1000 时，每抢成功一次便给成功者发一个订单号，并前往订单页进行后续操作。

这样既保证了秒杀的即时性，又减小了关系型数据库的读写压力。

### 统计

```shell
> stats # 将 Memcached 当前的运行信息统计出来
```

### 清空缓存

```shell
> flush_all
```

## 内存分配机制

### MALLOC 内存碎片

内存碎片：空闲，但无法被利用的内存空间

产生原因：在多次申请及释放内存的过程中，内存碎片化，形成零碎空间，无法利用

### Slab Allocation 分配机制

Slab Allocation 的基本原理是将分配的内存分割成各种尺寸的块（chunk）， 并把尺寸相同的块分成组（chunk的集合），每个chunk集合被称为 slab。

![slab_allocation.png](/assets/img/in-post/skill/sql/post-memcached-introduction/slab_allocation.png)

### Slab Allocation 缓存原理

Memcached 根据收到的数据大小，选择最适合数据大小的 slab。

并且 Memcached 中保存着 slab 内空闲 chunk 的列表，根据该列表选择 chunk，然后将数据缓存于其中。

![slab_classes.png](/assets/img/in-post/skill/sql/post-memcached-introduction/slab_classes.png)

### Slab Allocation 缺点

如上图，注定那剩余 `112 bytes - 100 bytes = 12 bytes` 将会浪费

并且，如果有 `100 bytes` 的数据要存，但是 `122 bytes` chunk 的 slab 已经存满，

此时 Memcached 并不会去寻找更大的 slab 进行存储，而是将 `122 bytes` slab 中的旧数据剔除

chunks 为固定大小，造成浪费这个问题不能克服，只能缓解

缓解方法：对于特定的网站，可以长期的统计网站内缓存数据，按自己网站的特点，设置 chunk 大小

### 生长因子

生长因子指的是相邻 slab 的 chunk 大小比例，默认为 1.25 倍。

一般而言，可以观察缓存数据大小的变化规律，设置合理的生长因子

## 过期数据删除机制

当某个值过期后，实际上并没有从内存删除。

当某个新数据去占用它的位置时，检测到已失效，将其当作空 `chunk` 来占用。

或者当由用户去 `get` 它时，检测到已失效，返回空值并删除它。

这个过期机制称为 __*惰性失效（Lazy Expiration）*__ ，也称之为 __*惰性删除*__

如果 `chunk` 都满了，但又有新数据需要加入，这时 Memcached 会使用 __*LRU 删除机制*__

操作系统的内存管理，常用 `FIFO LRU` 删除

FIFO：First In First Out

LRU：Least Recently Used（最近最少使用）

LRU 删除机制原理：当某个单元被请求时，维护一个计数器，通过计数器来判断最近谁最少被使用，然后将其剔除。

## 参数限制

key的长度：250 bytes（二进制协议支持 65536 个字节）

value的长度：1M

内存限制：32位下最大设置到 2G

## 经典问题或现象

### 缓存雪崩现象

由于某个节点失效，缓存命中率下降，

从而导致大量请求到达后端数据库，后端数据库不堪重负发生崩溃，

进而引发整体系统崩溃，最终发生灾难。

另一种情况就是，所有缓存的失效时间都在同一个点，

若正好在失效时间段内有大量请求，此时后端数据库既要重新缓存又要处理请求，

同样造成数据库压力过大，进而宕机，发生灾难。

#### 解决方案

1. 缓存数据的生命周期设置在一定范围内随机，或错开时间段失效。

2. 若缓存数据库为分布式部署，可以将热点数据均匀分布在不同缓存数据库中，防止整体失效。

3. 设置热点数据永远不过期。

### 缓存无底洞现象

该问题最早由 Facebook 的工作人员提出。

Facebook 在 2010 年左右，Memcached节点就已经达到了 3000 个，存储了数千G的缓存。

然而他们发现一个问题，Memcached 节点连接频繁，导致效率下降。

于是增加 Memcached 节点，但是添加以后效率问题仍然存在，没有好转。

新加的 Memcached 服务器就好像进入了一个无底洞，毫无效果，这种现象就称之为 __*缓存无底洞现象*__。

这是因为根据一致性哈希算法，缓存数据均匀分布在各 Memcached 缓存节点，

但是如用户个人信息，若被打散存放在各个缓存节点，那每次取某个用户信息就要请求多个节点，导致节点连接频繁，

而增加 Memcached 节点有可能会使得用户信息被分得更散，获取数据需要连接的节点更多。

显然，增加节点并没有降低 Memcached 的连接数，甚至有可能适得其反，这就造成了一个进退两难的局面，就像一个无底洞。

#### 解决方案

将同一组数据的 key 设置相同前缀。

如用户 `id` 为 `10`，`name` 为 `lisi`，'age' 为 `22`，

则可以设计 `user_10_name = lisi`，`user_10_age = 22`，

相同前缀情况下经过一致性哈希算法，可以尽可能的使某组用户信息存储在同一缓存节点上，避免 Memcached 连接频繁。

### 数据永久被踢现象

网上经常有使用者反馈 Memcached 数据设置为永久有效，但数据依旧丢失

这种情况的主要原因是 Memcached 的 [__*惰性删除机制*__](#过期数据删除机制) 和 [__*LRU 删除机制*__](#过期数据删除机制)。

#### 解决方案

将永久数据和非永久数据分开存放，防止永久数据被非永久数据剔除。
