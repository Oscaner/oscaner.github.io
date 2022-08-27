---
layout: post
title: "Redis 消息发布订阅"
date: 2018-11-18 19:42
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

【注】消息中间件一般使用：Rabbit MQ 或 Kafka, Redis 通常只作为数据库和缓存, Redis 的消息发布订阅仅作了解即可

## 是什么

进程间的一种消息通信模式：发送者 (pub) 发送消息, 订阅者 (sub) 接收消息

![1.png](/assets/img/in-post/skill/sql/post-redis-subscribe/1.png)

## 命令

<a href="http://www.runoob.com/redis/redis-pub-sub.html">http://www.runoob.com/redis/redis-pub-sub.html</a>

## 案例

先订阅后发布才能收到消息

1. 可以一次性订阅多个 `subscribe c1 c2 c3`, 或者通配符订阅多个 `psubscribe new*`

2. 消息发布 `publish c2 hello-redis`、`publish new1 redis2015`

![2.png](/assets/img/in-post/skill/sql/post-redis-subscribe/2.png)

![3.png](/assets/img/in-post/skill/sql/post-redis-subscribe/3.png)
