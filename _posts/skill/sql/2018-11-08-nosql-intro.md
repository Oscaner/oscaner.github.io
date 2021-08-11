---
layout: post
title: "NoSQL 入门及概述"
date: 2018-11-08 23:44
author: "Oscaner"
header-img: "img/post-bg-alitrip.jpg"
multilingual: false
mathjax: false
no-catalog: false
categories:
  - skill
  - sql
  - nosql
tags:
  - Skill
  - SQL
  - NoSQL
---

## 入门概述

### 是什么

`NoSQL = Not Only SQL`, 意为“不仅仅是SQL”, 泛指 **非关系型数据库**。

随着互联网 `WEB2.0` 网站的兴起, 传统的关系型数据库在应付 `WEB2.0` 网站, 特别是超大规模和高并发的 SNS 类型的 `WEB2.0` 纯动态网站已经显得力不从心, 暴露了很多难以克服的问题, 而非关系型的数据库则由于其本身的特点得到了非常迅速的发展。

`NoSQL` 数据库的产生就是为了解决大规模数据集合、多重数据种类带来的挑战, 尤其是大数据应用难题, 包括超大规模数据的存储。

这些类型的数据存储不需要固定的模式, 无需多余操作就可以横向扩展。

### 能干嘛

1. 易扩展

    `NoSQL` 数据库种类繁多, 但是一个共同的特点就是去掉了关系型数据库的关系型特性。

    数据之间无关系, 这样就非常容易扩展。也无形之中, 在架构的层面上带来了可扩展的能力。

2. 大数据量高性能

    `NoSQL` 数据库都具有非常高的读写性能, 尤其在大数据量下, 同样表现优秀。

    这得益于它的无关系性, 数据库的结构简单。

    一般 `MySQL` 使用 `Query Cache`, 每次表的更新 `Cache` 就失效, 是一种大粒度的 `Cache`。

    在针对 `WEB2.0` 的交互频繁的应用, `Cache` 性能不高, 甚至可能造成数据库负担。

    而 `NoSQL` 的 `Cache` 是记录级的, 是一种细粒度的 `Cache`, 所以 `NoSQL` 在这个层面上来说就要性能高很多了。

3. 多样灵活的数据模型

    `NoSQL` 无需事先为要存储的数据建立字段, 随时可以存储自定义的数据格式。

    而在关系型数据库里, 增删字段是一件非常麻烦的事情。如果是非常大数据量的表, 增加字段简直就是噩梦。

4. 传统 `RDBMS` VS `NoSQL`

    - `RDBMS`: 关系数据库管理系统
        - 高度组织化、结构化数据
        - 结构化查询语言(SQL)
        - 数据和关系都存储在单独的表中
        - 数据操纵语言, 数据定义语言
        - 严格的一致性
        - 基础事务

    - `NoSQL`: 非关系数据库
        - 代表着不仅仅是 SQL
        - 没有声明性查询语言
        - 没有预定义的模式
        - 键值对存储, 列存储, 文档存储, 图形数据库
        - 最终一致性, 而非 `ACID(数据库事务执行的四个基本要素)` 属性
        - 非结构化和不可预知的数据
        - CAP 定理
            NoSQL 数据库的基石, `Consistency(一致性)`、 `Availability(可用性)`、`Partition tolerance(分区容错性)`
        - 高性能、高可用性和可伸缩性

### 去哪下

1. Redis

    [《Redis 安装》](http://www.runoob.com/redis/redis-install.html){:target="_blank"}{:rel="nofollow"}

2. Memcache

    [《Linux Memcached 安装》](http://www.runoob.com/memcached/memcached-install.html){:target="_blank"}{:rel="nofollow"}

    [《Windows 下安装 Memcached》](http://www.runoob.com/memcached/window-install-memcached.html){:target="_blank"}{:rel="nofollow"}

3. MongoDB

    [《Windows 平台安装 MongoDB》](http://www.runoob.com/mongodb/mongodb-window-install.html){:target="_blank"}{:rel="nofollow"}

    [《Linux 平台安装 MongoDB》](http://www.runoob.com/mongodb/mongodb-linux-install.html){:target="_blank"}{:rel="nofollow"}

    [《Mac OSX 平台安装 MongoDB》](http://www.runoob.com/mongodb/mongodb-osx-install.html){:target="_blank"}{:rel="nofollow"}

### 怎么玩

1. key + value(键值对)
2. cache(缓存)
3. persistence(持久化)

### 3V + 3高

- 大数据时代的 3V
    - 海量 `Volume(体积)`
    - 多样 `Variety(品种)`
    - 实时 `Velocity(速度)`
- 互联网需求的 3高
    - 高并发
    - 高可扩
    - 高性能

## NoSQL 经典应用

当下的应用基本是 `SQL` 和 `NoSQL` 一起使用。

### 阿里巴巴中文站

#### 架构发展历程

1. 演变过程

    ![1.png](/img/in-post/skill/sql/post-nosql-intro/1.png)

2. 第四代网站架构

    - 性能和海量数据问题
        - 大规模的 Memcached 集群、高性能应用服务器升级、KV、CDN 等一定程度解决了网站的性能问题。
        - 数据切分和分布式存储解决了网站海量数据的问题。
    - 安全问题
        - 镜像站解决了网站的灾备问题。
        - 网站框架的安全特性升级透明的过滤了常见的网站安全漏洞。

    但到了 2010 年底, 阿里巴巴却不得不开始实施第五代网站架构改造。

3. 第五代网站架构使命

    - 敏捷
        - 业务快速增长, 每天都要上线大量的小需求。
        - 应用系统日益膨胀, 耦合恶化, 架构越来越复杂, 会带来更高的开发成本。如何保持业务开发敏捷性？
    - 开放
        - Facebook 和 AppStore 带来的启示, 如何提升网站的开放性, 吸引第三方开发者加入到网站的共建中来？
    - 体验
        - 网站的并发压力快速增长, 用户却对体验提出了更高的要求。

#### 多数据源多数据类型的存储问题

![2.png](/img/in-post/skill/sql/post-nosql-intro/2.png)

#### 商品基本信息

名称、价格、出厂日期、生产厂商等。

利用关系型数据库, `MySQL/Oracle`(淘宝内部用的 MySQL 是经过内核修改的)。

淘宝在去 `IOE` 化(即拿掉 `Oracle`), 为什么去 `IOE` ？


> 2008年, 王坚加盟阿里巴巴成为集团首席架构师, 即现在的首席技术官。这位前微软亚洲研究院常务副院长被马云定位为: 将帮助阿里巴巴集团建立世界级的技术团队, 并负责集团技术架构以及基础技术平台搭建。
>
> 在加入阿里后, 带着技术基因和学者风范的王坚就在阿里巴巴集团提出了被称为 “去IOE”(在 IT 建设过程中, 去除 IBM小型机、Oracle 数据库及 EMC 存储设备)的想法, 并开始把云计算的本质, 植入阿里 IT 基因。
>
> 王坚这样概括 “去IOE” 运动和阿里云之间的关系:  “去IOE” 彻底改变了阿里集团 IT 架构的基础, 是阿里拥抱云计算, 产出计算服务的基础。 “去IOE” 的本质是分布化, 让随处可以买到的 Commodity PC 架构成为可能, 使云计算能够落地的首要条件。

#### 商品描述、详情、评价信息(多文字类)

多文字信息描述类, 会造成 `IO` 读写性能变差, 采用文档数据库 `MongoDB`。

#### 商品的图片

商品图片展示类, 采用分布式的文件系统。

1. 淘宝自己的 `TFS`
2. `Google` 的 `GFS`
3. `Hadoop` 的 `HDFS`

#### 商品的关键字

搜索引擎 `ISearch`, 淘宝内用。

#### 商品的波段性的热点高频信息

采用内存数据库, `Tair`、`Redis`、`Memcached`。

#### 商品交易、价格计算、积分累计

采用外部系统、第三方支付接口, 支付宝。

## 总结

### 难点

- 数据类型的多样性
- 数据源的多样性和变化重构
- 数据源改造而数据服务平台不需要大面积重构

### 解决办法

`EAI` 和统一数据平台服务层 `UDSL`

在网站应用集群和底层数据源之间, 构建一层代理, 统一数据层。

统一数据层的特性:

- 模型数据映射
    - 实现业务模型各属性与底层不同类型数据源的模型数据映射
    - 目前支持关系型数据库, `ISearch`, `Redis`, `MongoDB`
- 统一的查询和更新 API
    - 提供了基于业务模型的统一的查询和更新的 API, 简化网站应用跨不同数据源的开发模式
- 性能优化策略
    - 字段延迟加载, 按需返回设置
    - 基于热点缓存平台的二级缓存
    - 异步并行的查询数据: 异步并行加载模型中来自不同数据源的字段
    - 并发保护: 拒绝访问频率过高的主机 IP 或 IP 段
    - 过滤高危的查询: 例如会导致数据库崩溃的全表扫描

![3.png](/img/in-post/skill/sql/post-nosql-intro/3.png)

#### 映射

![4.png](/img/in-post/skill/sql/post-nosql-intro/4.png)

#### API

![5.png](/img/in-post/skill/sql/post-nosql-intro/5.png)

#### 热点缓存

![6.png](/img/in-post/skill/sql/post-nosql-intro/6.png)
