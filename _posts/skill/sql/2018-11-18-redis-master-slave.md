---
layout: post
title: "Redis 主从复制"
date: 2018-11-18 22:13
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

## 是什么

Redis 的复制, 也就是我们常说的主从复制读写分离, 主机数据更新后根据配置和策略, 自动同步到备机的 Master/Slave 机制, Master 以写为主, Slave 以读为主

## 能干嘛

1. 读写分离

2. 容灾恢复

## 怎么玩

### 配从不配主

配置从库, 不配主库

### 从库配置

```shell
> slaveof [Master IP] [Master port]
```

每次与 Master 断开连接后, 都需要重新连接, 除非在 redis.conf 中进行配置

### 修改配置文件细节操作

```shell
> cp /opt/redis-4.0.11/redis.conf /backup_conf/redis_6379.conf
> vim /backup_conf/redis_6379.conf
# ------------------------------------------
# daemonize
daemonize yes
# pid 文件路径
pidfile /var/run/redis_6379.pid
# 端口
port 6379
# log 文件名
logfile "redis_6379.log"
# dump.rdb 文件名
dbfilename dump_6379.rdb
```

```shell
> cp /opt/redis-4.0.11/redis.conf /backup_conf/redis_6380.conf
> vim /backup_conf/redis_6380.conf
# ------------------------------------------
# daemonize
daemonize yes
# pid 文件路径
pidfile /var/run/redis_6380.pid
# 端口
port 6379
# log 文件名
logfile "redis_6380.log"
# dump.rdb 文件名
dbfilename dump_6380.rdb
```

```shell
> cp /opt/redis-4.0.11/redis.conf /backup_conf/redis_6381.conf
> vim /backup_conf/redis_6381.conf
# ------------------------------------------
# daemonize
daemonize yes
# pid 文件路径
pidfile /var/run/redis_6381.pid
# 端口
port 6379
# log 文件名
logfile "redis_6381.log"
# dump.rdb 文件名
dbfilename dump_6381.rdb
```

### 常用三招

#### 一主二仆: 中心化

1. Init 初始化

    ![1.png](/img/in-post/skill/sql/post-redis-master-slave/1.png)

    ![2.png](/img/in-post/skill/sql/post-redis-master-slave/2.png)

2. 一个 Master 两个 Slave

    ![3.png](/img/in-post/skill/sql/post-redis-master-slave/3.png)

    ![4.png](/img/in-post/skill/sql/post-redis-master-slave/4.png)

3. 日志查看

    ![10.png](/img/in-post/skill/sql/post-redis-master-slave/10.png)

4. 主从问题演示

    - 读写分离: Master can read and write, Slave only read

        ![5.png](/img/in-post/skill/sql/post-redis-master-slave/5.png)

    - 主机故障: Master shutdown, Slave waitting

        ![6.png](/img/in-post/skill/sql/post-redis-master-slave/6.png)

    - 主机恢复: Master recover, Slave auto relink

        ![7.png](/img/in-post/skill/sql/post-redis-master-slave/7.png)

    - 从机故障: Slave shutdown and then recover, but it become a master

        ![8.png](/img/in-post/skill/sql/post-redis-master-slave/8.png)

    - 每次与 Master 断开连接后, 都需要重新连接, 除非在 redis.conf 中进行配置

        ![9.png](/img/in-post/skill/sql/post-redis-master-slave/9.png)

#### 薪火相传: 去中心化

上一个 Slave 可以是下一个 Slave 的 Master, Slave 同样可以接收其他 Slave 的连接和同步请求, 这样就可以有效的减轻 Master 的写压力

中途变更转向: 会清除之前的数据, 重新建立拷贝最新的

![11.png](/img/in-post/skill/sql/post-redis-master-slave/11.png)

![12.png](/img/in-post/skill/sql/post-redis-master-slave/12.png)

#### 反客为主

Master shutdown, 两个 Slave 中选择一个成为 Master

`slaveof no one`: 使当前数据库停止与其他数据库的同步, 转成主数据库

![13.png](/img/in-post/skill/sql/post-redis-master-slave/13.png)

## 复制原理

1. Slave 启动成功连接到 Master 后会发送一个 sync 命令

2. Master 接到命令启动后台的存盘进程, 同时收集所有接收到的用于修改数据集的命令

3. 在后台进程执行完毕之后, Master 将传送整个数据文件到 Slave, 以完成一次完全同步

4. 全量复制: 而 Slave 服务在接收到数据库文件数据后, 将其存盘并加载到内存中

5. 增量复制: Master 继续将新的所有收集到的修改命令依次传给 Slave, 完成同步

6. 但是, 只要是重新连接 Master, 第一次完全同步 (全量复制) 将被自动执行

## 哨兵模式 (Sentinel)

### 是什么

反客为主的自动版, 能够后台监控 Master 是否故障, 如果故障了根据投票数自动将从库转换为主库

### 怎么玩

1. 调整结构: 一主二仆

2. 自定义目录下新建 `sentinel.conf` 文件, 名字绝对不能错 `touch /backup_conf/sentinel.conf`

3. 配置哨兵, 填写内容

    `sentinel monitor [被监控数据库名字] 127.0.0.1 6379 1`

    上面最后一个数字 1, 表示 Master shutdown 后, Slave 投票看让谁接替成为 Master, 得票多者成为 Master

    ![14.png](/img/in-post/skill/sql/post-redis-master-slave/14.png)

4. 启动哨兵

    `redis-sentinel /backup_conf/sentinel.conf`

    ![15.png](/img/in-post/skill/sql/post-redis-master-slave/15.png)

5. 正常主从演示

    ![16.png](/img/in-post/skill/sql/post-redis-master-slave/16.png)

6. Master shutdown

7. 投票新选

8. 重新主从, 继续开工

    ![17.png](/img/in-post/skill/sql/post-redis-master-slave/17.png)

9. Q&A: 如果之前的 Master 重启回来, 是否会造成双 Master 冲突？

    不会造成冲突, 并且之前的 Master 会变成新 Master 的 Slave (老领导变小弟)

    ![18.png](/img/in-post/skill/sql/post-redis-master-slave/18.png)

### 最后

一组 sentinel 能同时监控多个 Master

## 复制的缺点: 复制延迟

由于所有的写操作都是优先 Master, 然后同步更新到 Slave 上

因此从 Master 同步到 Slave 上会有一定的延迟

如果在高并发情况下, 延迟问题会更加严重, Slave 数量的增加也会使这个问题更加严重
