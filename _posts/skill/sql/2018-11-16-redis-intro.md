---
layout: post
title: "Redis 介绍"
date: 2018-11-16 15:18
author: "Oscaner"
header-img: "assets/img/post-bg-alitrip.jpg"
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

Redis: **Re**mote **Di**ctionary **S**erver (远程字典服务器)

Redis 是一个高性能的 key/value 分布式内存数据库, 基于内存运行并支持持久化的 NoSQL 数据库, 是当前最热门的 NoSQL 数据库之一, 也被人们称为数据结构服务器

Redis 与其他 key-value 缓存产品有以下三个特点:

1. Redis 支持数据的持久化, 可以将内存中的数据保持在磁盘中, 重启的时候可以再次加载使用
2. Redis 不仅支持简单的 key-value 类型的数据, 同时还提供 list、set、zset、hash 等数据结构的存储
3. Redis 支持数据的备份, 即 master-slave 模式的数据备份

## 能干嘛

1. 内存存储和持久化: Redis 支持异步将内存中的数据写到硬盘上, 同时不影响继续服务
2. 取最新 N 个数据的操作, 如: 可以将最新的 10 条评论的 ID 放在 Redis 的 List 队列集合里
3. 模拟类似于 HttpSession 这种需要设定过期时间的功能
4. 发布、订阅消息系统
5. 定时器、计数器

## 怎么装

### Windows

[《Redis 安装》](http://www.runoob.com/redis/redis-install.html){:target="blank"}

### Linux/Ubuntu

[Redis Download](https://redis.io/download#from-the-official-ubuntu-ppa){:target="blank"}

### Mac

```shell
> brew install redis
```

## 怎么玩

1. 数据类型、基本操作和配置
2. 持久化和复制, RDB/AOF
3. 事务的控制
4. 主从复制
5. 缓存功能, 计数器, 点击次数, 共享session, 限速 (String)
6. 秒杀系统, 消息队列, 取最新N个数据 (List)
7. 分数排名, PV热门, 时间排序新闻 (ZSet)
8. ...

## 数据类型

### 五大数据类型

#### String (字符串)

string 是 redis 里最基本的类型, 可以理解成与 memcached 一模一样的类型, key => value

以二进制形式存储, 可以包含任何数据, 包括图片或者序列化的对象

一个 redis 中字符串 value 最多可以是 521M

应用场景: 常规 kv 数据读取

#### Hash (哈希, 类似 java 里的 map)

redis hash 是一个键值对集合, string 类型的 field 和 value 的映射表, hash 特别适合用于存储对象

应用场景: 类似于表记录的存储, 存储关系型数据库的数据, 方便读取和横向扩展, 提高用户响应及交互

#### List (列表)

redis list 是简单的字符串列表, 按照插入顺序排序

你可以添加一个元素到列表的头部 (左侧)或者尾部 (右侧), 它的底层实际是个链表

应用场景: 实现队列操作, 批量消息发送、邮件发送, 判断用户是第几个访问站点 (因为push返回的是index), 最新N个新闻列表

#### Set (集合)

redis set 是 string 类型的无序集合, 它是通过 hash table 实现的, 相同数据仅存一份, 具有去重的功能

数学集合: 差集、交集、并集

应用场景: 奖池随机抽取用户, 数据去重, 两组数据查异、取同、合并等

#### Zset (sorted set: 有序集合)

redis zset 和 set 一样也是 string 类型元素的集合, 且不允许重复的成员

不同的是, 每个元素都会关联一个 double 类型的分数

redis 正是通过分数来为集合中的成员进行从小到大的排序

zset 的成员是唯一的, 但分数 (score)却可以重复

应用场景: 分数排名, PV热门, 时间排序新闻

### 命令文档

[http://www.runoob.com/redis/redis-tutorial.html](http://www.runoob.com/redis/redis-tutorial.html){:target="_blank"}{:rel="nofollow"}
