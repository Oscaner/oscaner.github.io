---
layout: post
title: "Redis 事务"
date: 2018-11-17 18:29
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

可以一次执行多个命令, 本质是一组命令的集合

一个事务中的所有命令都会序列化, 按顺序串行化执行, 不会被其他命令插入, 不允许加塞

## 能干嘛

一个队列中, 一次性、顺序性、排他性的执行一系列命令

## 怎么玩

### 常用命令

1. `discard`

    取消事务, 放弃执行事务块内的所有命令

2. `exec`

    执行所有事务块内的命令

3. `multi`

    标记一个事务块的开始

4. `watch key [key ...]`

    监控一个 (或多个) key, 如果在事务执行之前这个 (或这些) key 被其他命令所改动, 那么事务将被中断

5. `unwatch`

    取消 watch 命令对所有 key 的监控

### 正常执行

![1.png](/assets/img/in-post/skill/sql/post-redis-transaction/1.png)

### 放弃事务

![2.png](/assets/img/in-post/skill/sql/post-redis-transaction/2.png)

### 全体连坐

一错全错, 全体连坐

![3.png](/assets/img/in-post/skill/sql/post-redis-transaction/3.png)

### 冤头债主

【注】与全体连坐的区别

1. 全体连坐是在加入事务的时候就已经报错, 是无效入队, 指令上的错误, 因此全体失效。

2. 冤头债主是入队正常, 仅执行出错, 属于数据结构上的错误, 而非指令上的错误。

![4.png](/assets/img/in-post/skill/sql/post-redis-transaction/4.png)


### watch 监控

1. 悲观锁/乐观锁/CAS (Check And Set)

    悲观锁: 每次在拿数据的时候都会上锁, 这样别人想拿这个数据就会 block, 直到它拿到锁。传统的关系型数据库里边就用到了很多这种锁机制, 比如行锁、表锁、读锁、写锁等, 都是在操作之前先上锁。数据一致性有保障, 但不适合高并发

    乐观锁: 每次去拿数据的时候都不会上锁, 但是在更新的时候会判断一下在此期间别人有没有去更新过这个数据, 使用版本号等机制。乐观锁适用于多读的应用类型, 这样可以提高吞吐量

    乐观锁策略: 提交版本必须大于记录当前版本才能执行更新

2. 初始化信用卡可用余额和欠额

    ![5.png](/assets/img/in-post/skill/sql/post-redis-transaction/5.png)

3. 无加塞篡改, 先 watch 再 multi, 保证两笔金额变动在同一个事务内

    ![6.png](/assets/img/in-post/skill/sql/post-redis-transaction/6.png)

4. 有篡改, 先 watch 再 set, 导致监控前后数据不一致, 事务执行中断返回 nil

    原因请看 [#常用命令](#常用命令)

    ![7.png](/assets/img/in-post/skill/sql/post-redis-transaction/7.png)

5. 有篡改, 则放弃监控 unwatch 再 watch, 再执行 multi

    ![8.png](/assets/img/in-post/skill/sql/post-redis-transaction/8.png)


6. 一旦执行 exec, 之前加的监控锁将都会被取消

    1. watch 指令类似于乐观锁, 事务提交前, 如果 key 的值已被别的客户端改变, 比如某个 list 已被别的客户端 push/pop 过了, 整个事务队列都不会被执行

    2. 通过 watch 命令在事务执行之前监控多个 keys, 倘若在 watch 之后有任何 key 的值发生了改变, exec 命令执行的事务都将被放弃, 同时返回 nil 应答以通知调用者事务执行失败

## 三阶段

### 开启

以 `MULTI` 开始一个事务

### 入队

将多个命令入队到事务中, 接到这些命令并不会立即执行, 而是放到等待执行的事务队列中

### 执行

以 `EXEC` 命令触发事务

## 三特性

1. 单独的隔离操作: 事务中的所有命令都会序列化, 按顺序执行。事务在执行的过程中, 不会被其他客户端发送来的命令请求所打断

2. 没有隔离级别的概念: 队列中的命令没有提交之前都不会实际的被执行, 也就不存在 **事务内的查询要看到事务里的更新, 在事务外查询不能看到** 这个让人头疼的问题

3. 不保证原子性、部分支持事务: Redis 同一个事务中如果有一条命令执行失败, 其后的命令仍然会被执行, 没有回滚
