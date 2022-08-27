---
layout: post
title: "互联网时代下的 MySQL 架构演变之旅"
date: 2018-11-16 14:19
author: "Oscaner"
header-img: "assets/img/post-bg-alitrip.jpg"
multilingual: false
mathjax: false
no-catalog: false
categories:
  - skill
  - sql
  - nosql
  - mysql
  - memcached
tags:
  - Skill
  - SQL
  - NoSQL
  - MySQL
  - Memcached
---

## 单机 MySQL 的美好年代

在 90 年代, 一个网站的访问量不是很大, 用单个数据库完全可以轻松应付

在那个时候, 更多的都是静态网页, 动态交互类型的网站不多

![1.png](/assets/img/in-post/skill/sql/post-evolution-of-mysql-arch/1.png)

从上述架构中, 我们很容易看到数据存储的瓶颈：

1. 当数据量的总大小一台机器放不下时

2. 当数据的索引（B+ Tree）一台机器的内存放不下时

3. 当访问量（读写混合）一个实例不能承受时

当遇到了上述的 1 or 3 个瓶颈的时候, 架构开始进化 ...

## Memcached 缓存 + MySQL + 垂直拆分

后来, 随着访问量的上升, 几乎大部分使用 MySQL 架构的网站在数据库上都开始出现了性能问题

WEB 程序不再仅仅专注在功能上, 同时也在追求性能

程序猿们开始大量的使用缓存技术来缓解数据库的压力, 优化数据库的结构和索引

开始比较流行的是通过文件缓存来缓解数据库压力

但是当访问量继续增大的时候, 多台 WEB 机器通过文件缓存不能共享, 大量的小文件也带来了比较高的 IO 压力

在这个时候, Memcached 就自然的成为了一个非常时尚的技术产品

![2.png](/assets/img/in-post/skill/sql/post-evolution-of-mysql-arch/2.png)

## MySQL 主从复制 + 读写分离

由于数据库的写入压力增加, Memcached 只能缓解数据库的读取压力

读写集中在一个数据库上让数据库不堪重负, 大部分网站开始使用主从复制技术来达到读写分离, 以提高读写性能和读库的可扩展性

MySQL 的 master-slave 模式成为这个时候的网站标配

![3.png](/assets/img/in-post/skill/sql/post-evolution-of-mysql-arch/3.png)

## 分表分库 + 水平拆分 + MySQL 集群

在 Memcached 的高速缓存, MySQL 的主从复制、读写分离的基础之上, 这时 MySQL 主库的写压力开始出现瓶颈

而数据量的持续猛增, 由于 MyISAM 使用表锁, 在高并发下会出现严重的锁问题, 大量的高并发使得 MySQL 开始使用 InnoDB 存储引擎来替代 MyISAM

（什么是 MyISAM、InnoDB 存储引擎 ？ <a href="https://blog.csdn.net/perfectsorrow/article/details/80150672">《MySQL存储引擎中的MyISAM和InnoDB区别详解》</a>）

同时, 开始流行使用分表分库来缓解写压力和数据增长的扩展问题。

这个时候, 分表分库成为了一门热门技术, 是面试的热门问题, 也是业界讨论的热门技术问题。

也就在这个时候, MySQL 推出了还不太稳定的表分区, 这也给技术实力一般的公司带来了希望。

（什么是表分区 ？ <a href="https://www.cnblogs.com/mliudong/p/3625522.html">《MySQL表的四种分区类型》</a>）

虽然 MySQL 推出了 MySQL Cluster 集群, 但性能也不能很好满足互联网的要求, 只是在高可靠性上提供了非常大的保证

![4.png](/assets/img/in-post/skill/sql/post-evolution-of-mysql-arch/4.png)

## MySQL 的扩展性瓶颈

MySQL 数据库也经常存储一些大文本字段, 导致数据库表非常大, 在做数据库恢复的时候也会相当慢, 不容易快速恢复数据库

比如：1000万 4KB 大小的文本就接近 40GB 的大小, 如果能把这些数据从 MySQL 省去, MySQL 将变得非常小

关系数据库虽然很强大, 但是它并不能很好的应付所有的应用场景

MySQL 的扩展性差（需要复杂的技术来实现）, 大数据下 IO 压力大, 表结构更改困难, 正是当前使用 MySQL 的开发人员面临的问题

## 今天是什么样子

![5.png](/assets/img/in-post/skill/sql/post-evolution-of-mysql-arch/5.png)

## NoSQL 的发展

今天我们可以通过第三方平台（如：Google, Facebook等）可以很容易的访问和抓取数据。

用户的个人信息, 社交网络, 地理位置, 用户生成的数据和用户操作日志已经成倍的增加。

我们如果要对这些用户数据进行挖掘, 那 SQL 数据库已经不适合这些应用了

NoSQL 数据库的发展却能很好的处理这些大的数据

NoSQL = Not Only SQL, 非关系型数据库

【完】
