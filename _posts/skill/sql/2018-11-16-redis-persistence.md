---
layout: post
title: "Redis 持久化"
date: 2018-11-16 21:36
author: "Oscaner"
header-img: "img/post-bg-alitrip.jpg"
multilingual: false
mathjax: false
no-catalog: false
categories:
  - skill
  - nosql
  - redis
tags:
  - Skill
  - NoSQL
  - Redis
---

## RDB (Redis DataBase)

### 是什么

在指定的时间间隔内, 将内存中的数据集快照写入磁盘, 恢复时将快照文件直接读到内存。

Redis 会单独创建 ([Fork](#fork)) 一个子进程来进行持久化, 会先将数据写入到一个临时文件中, 待持久化过程都结束的时候, 再用这个临时文件替换上次持久化好的文件。

整个过程中, 主进程是不进行任何 IO 操作的, 这就确保了极高的性能。

如果需要进行大规模数据的恢复, 且对于数据恢复的完整性不是非常敏感, 那 RDB 方式要比 AOF 方式更加的高效。

RDB 的缺点是最后一次持久化后的数据可能丢失。

### Fork

Fork 的作用是复制一个与当前进程一样的进程

新进程的所有数据 (变量、环境变量、程序计数器等) 数值都和原进程一致, 但是是一个全新的进程, 并作为原进程的子进程

### RDB 存储文件

默认保存的是 `dump.rdb` 文件

### 配置文件

![1.png](/assets/img/in-post/skill/sql/post-redis-persistence/1.png)

1. save

    看下面的 [#如何触发RDB快照](#如何触发-rdb-快照)

2. stop-writes-on-bgsave-error

    当快照 save 错误的时候, 停止内存写入操作

    如果配置为 no, 表示你不在乎数据不一致, 或者有其他的手段发现和控制 save 错误

3. rdbcompression

    对存储到磁盘中的快照, 可以设置是否进行压缩存储

    如果是的话, Redis 会采用 LZF 算法进行压缩

    如果不想消耗 CPU 进行压缩的话, 可以设置为关闭此功能

4. rdbchecksum

    在存储快照后, 还可以让 Redis 使用 CRC64 算法来进行数据校验, 但是这样做会增加大约 10% 的性能消耗, 如果希望获取到最大的性能提升, 可以关闭此功能

5. dbfilename

    RDB 存储文件名

6. dir

    RDB 存储文件路径

### 如何触发 RDB 快照

RDB 是整个内存压缩过的 Snapshot RDB 的数据结构, 可以配置复合的快照触发条件

指定在多长时间内, 有多少次更新操作, 就将数据同步到数据文件, 可以多个条件配合

- `save [seconds] [changes]`
- Redis 默认配置文件中提供了三个条件:
    - `save 900 1`: 900秒 (15分钟) 内有 1 个更改
    - `save 300 10`: 300秒 (5分钟) 内有 10 个更改
    - `save 60 10000`: 60秒 (1分钟) 内有10000个更改

如果想禁用 RDB 持久化策略, 只要不设置任何 save 指令, 或者给 save 传入一个空字符串参数即可

- `save ""`

【注】

1. redis-cli 命令 `save` 和 `bgsave`

    - `save`: save 时只管保存, 其他不管, 导致全部阻塞
    - `bgsave`: Redis 会在后台异步进行快照操作, 快照同时还可以响应客户端请求
    - `lastsave`: 可以通过 `lastsave` 命令获取最后一次成功执行快照的时间

2. 执行 flushall 命令也会产生 dump.rdb 文件, 但里面没有数据, 无意义

3. 生成 dump.rdb 文件后, 尽量做一个备份, 备份到其他的服务器里, 以防万一

### 如何恢复

1. 正常恢复

    将备份文件 (dump.rdb) 移动到 redis 启动目录下并启动服务即可

2. 异常恢复

    文件修复: 进入 src 文件夹, 使用 `redis-check-dump --fix dump.rdb`, 之后正常恢复

### 如何停止

动态停止所有 RDB 备份策略的方法: redis-cli 命令 `config set save ""`

### 优势

1. RDB 是一个非常紧凑的文件, 适合大规模的数据恢复

2. RDB 在保存文件时, 父进程唯一需要做的就是 Fork 出一个子进程, 接下来的工作全部由子进程来做, 父进程不需要再做其他 IO 操作, 所以 RDB 持久化方式可以最大化 Redis 的性能

3. 与 AOF 相比, 在恢复大数据集的时候, RDB 策略会更快一些

### 劣势

1. 由于在一定间隔时间做一次备份, 如果 Redis 意外 shutdown 的话, 就会丢失最后一次快照后的所有修改, 数据丢失风险大

2. Fork 的时候, 内存中的数据被克隆了一份, 大致 2 倍的膨胀性需要慎重考虑

3. RDB 需要经常 Fork 子进程来保存数据集到硬盘上, 当数据集比较大的时候, Fork 的过程是非常耗时间的, 可能会导致 Redis 在一些毫秒级业务中不能响应客户端请求

## AOF (Append Only File)

### 是什么

以日志的形式来记录每个写操作, 将 Redis 执行过的所有写指令记录下来 (读操作不记录)

只允许追加文件但不可以改写文件, Redis 启动之初会读取该文件重新构建数据

换言之, Redis 重启的话就根据日志文件的内容将写指令从前到后执行一次以完成数据的恢复工作

### AOF 存储文件

默认保存的是 `appendonly.aof` 文件

### 配置文件

![2.png](/assets/img/in-post/skill/sql/post-redis-persistence/2.png)

1. appendonly

2. appendfilename

3. appendfsync: 指定更新日志条件

    - no: 完全依赖 OS 的写入, 一般为 30 秒左右一次, 性能最好但是持久化最没有保证, 不被推荐。
    - always: 每次收到写命令就立即强制写入磁盘, 是最有保证的完全的持久化, 但速度也是最慢的, 一般不推荐使用。
    - everysec: 每秒钟强制写入磁盘一次, 在性能和持久化方面做了很好的折中, 是受推荐的方式。

4. no-appendfsync-on-rewrite: 重写时是否可以运用 appendfsync, 默认为 no 即可, 保证数据安全性

5. auto-aof-rewrite-min-size: 设置重写的基准值, 默认 64M

6. auto-aof-rewrite-percentage: 设置重写的基准值, 默认 100 (百分比)

### AOF 启动

修改 `appendonly no` 为 `appendonly yes`

### AOF 恢复

1. 正常恢复

    与 RDB 恢复类似, 并且在 RDB 和 AOF 共存的情况下, 优先加载 AOF 备份文件

2. 异常恢复

    文件修复: 进入 src 文件夹, 使用 `redis-check-aof --fix appendonly.aof`, 自动将 AOF 文件中不符合语法规范的语句删除, 之后正常恢复

### Rewrite

1. 是什么

    由于 AOF 采用文件追加方式, 文件会越来越大。为避免出现此种情况, 新增了重写机制

    当 AOF 文件的大小超过所设定的阈值时, Redis 就会启动 AOF 文件的内容压缩, 只保留可以恢复数据的最小指令集

    也可以使用 redis-cli 命令: `bgrewriteaof`

2. 重写原理

    AOF 文件持续增长而过大时, 会 Fork 出一条新进程来将文件重写 (也是先写临时文件最后再 rename) , 遍历新进程的内存中数据, 每条记录一条 set 语句

    重写 AOF 文件的操作, 并没有读取旧的 AOF 文件, 而是将整个内存中的数据库内容用命令的方式重写了一个新的 AOF 文件, 这点与 RDB 快照有点类似

3. 触发机制

    Redis 会记录上次重写时的 AOF 大小, 默认配置是当 AOF 文件大小是上次 Rewrite 后大小的一倍, 且文件大于 64M 时触发

### 优势

1. 每修改同步: `appendfsync always`, 同步持久化, 每次发生数据变更会被记录到磁盘, 性能较差但数据完整性较好

2. 每秒同步: `appendfsync everysec`, 异步操作, 每秒记录, 如果一秒内宕机有可能数据丢失

3. 依赖 OS 同步: `appendfsync no`, 完全依赖 OS 的写入, 一般为 30 秒左右一次, 性能最好但是持久化最没有保证

4. AOF 文件是一个只进行追加的日志文件, Redis 可以在 AOF 文件体积过大时, 自动在后台对 AOF 进行重写

5. AOF 文件有序地保存了对数据库执行地所有写入操作, 这些写入操作以 Redis 协议的格式保存, 因此 AOF 文件的内容非常容易被人读懂, 对文件进行分析也很轻松

### 劣势

1. 对于相同数据集的数据, AOF 文件体积要远大于 RDB 文件, 恢复速度慢于 RDB

2. AOF 运行效率要慢于 RDB, 每秒同步策略效率较好, 依赖 OS 同步效率和 RDB 相同

## 总结

1. RDB 持久化策略能够在指定的时间间隔内对数据进行快照存储

2. AOF 持久化策略记录每次对数据库的写入操作, 当数据库重启的时候会重新执行这些命令来恢复原始的数据。

    AOF 命令以 Redis 协议追加保存每次写入操作到文件末尾。

    Redis 还能对 AOF 文件进行后台重写, 使得 AOF 文件的体积不至于过大。

3. 只做缓存: 如果你只希望你的数据在服务器运行的时候存在, 也可以不使用任何持久化方式

4. 同时开启两种持久化策略

    在这种情况下, 当 Redis 重启的时候会优先载入 AOF 文件来恢复原始的数据, 因为在通常情况下 AOF 文件保存的数据集要被 RDB 文件保存的数据集要完整

    建议同时开启两种持久化策略, 因为 RDB 更适合用于备份数据库 (AOF 在不断变化不好备份) 快速重启, 而且不会有 AOF 可能潜在的 BUG, 留着作为一个万一的手段

5. 性能建议

    因为 RDB 文件只用做后备用途, 建议只在 slave 上持久化 RDB 文件, 而且只要 15min 备份一次就够了, 只保留 `save 900 1` 这条规则

    如果启用了 AOF, 好处是在最恶劣情况下也只会丢失不超过两秒数据, 启动脚本较简单, 只加载 AOF 文件就可以了。代价是持续的 IO, 以及 AOF Rewrite 的最后, 将 Rewrite 过程中产生的新数据写到新文件造成的阻塞几乎是不可避免地。只要硬盘许可, 应该尽量减少 AOF Rewrite 的频率, AOF 重写的基础大小默认为 64M, 实际生产环境可以设置 5G 以上, 默认超过原大小 100% 时重写可以改到适当的数值。

    如果关闭了 AOF, 仅靠 master-slave replication 实现高可用性也可以。能省掉一大笔 IO, 也减少了 Rewrite 时带来的系统波动。代价是如果 master/slave 同时 shutdown, 会丢失十几分钟的数据, 启动脚本也要比较两个 master/slave 中的 RDB 文件, 载入较新的那个, 新浪微博就是选用了这种架构。
