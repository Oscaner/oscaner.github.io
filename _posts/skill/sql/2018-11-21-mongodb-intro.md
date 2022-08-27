---
layout: post
title: "MongoDB 介绍"
date: 2018-11-21 18:31
author: "Oscaner"
header-img: "assets/img/post-bg-alitrip.jpg"
multilingual: false
mathjax: false
no-catalog: false
categories:
  - skill
  - nosql
  - mongodb
tags:
  - Skill
  - NoSQL
  - MongoDB
---

MongoDB 数据库是一种 NoSQL 数据库。

NoSQL 数据库并不是这几年才有的, 从数据库的初期发展就已经存在 NoSQL 数据库。

数据库之中支持的 SQL 语句是由 IBM 开发出来的, 并且最早就应用在了 Oracle 数据库。

SQL 语句的使用并不麻烦, 就是几个简单的单词: SELECT、FROM、WHERE、GROUP BY、HAVING、ORDER BY。

但是在这个时候, 有人开始反感于编写 SQL 操作。

于是有一些人就开始提出一个理论 —— 不要去使用 SQL, 于是最早的 NoSQL 概念产生了。

可是后来的发展产生了一点变化, 在 90 年代到 2010 年之间, 世界上最流行的数据库依然是关系型数据库, 并且围绕着关系型数据库开发出了大量的程序应用。

后来又随着移动技术 (云计算、大数据) 的发展, 很多公司并不愿意去使用大型的厂商数据库 —— Oracle、DB2, 因为这些公司已经习惯于使用 MySQL 数据库。

这些公司发现在大数据以及云计算的环境下, 数据存储收到了很大的挑战, 于是就重新开始了 NoSQL 数据库的开发。

但是, 经过长期的开发发现, NoSQL 数据库依然不可能离开传统的关系型数据库。

实际上, 在现实的开发中一直存在一种神奇的问题:

- 数据表 -> JDBC 读取 -> POJO (VO、PO) -> 控制层转化为 JSON 数据 -> 客户端

可是这样的转换实在是太麻烦了, 最好的做法是, 直接有一个数据库就存放有要显示的 JSON 数据, 这样就省略了所有需要进行转换的过程。

所以在实际的开发之中, 往往除了关系型数据库之外还要提供一个 NoSQL 数据库。

其中 NoSQL 数据库负责数据的读取, 因为直接保存的就是 JSON (前提: MongoDB 中的数据是排列好的组合数据)

例如: 现在要求显示出每个雇员的编号、姓名、职位、部门名称、部门位置、工资等级。

显然关系型数据库中一定要存放大量的冗余数据, 不合理。

而有了 NoSQL 数据库, 可以直接在业务层将数据交给 NoSQL 数据库保存, 按照指定的结构进行存储。

在 MongoDB 数据库之中, 与 Oracle 数据库有如下的概念对应:

| No. | 关系型数据库 | NoSQL 数据库 |
| :--: | :-- | :-- |
| 1 | 数据库 | 数据库 (类似于 MySQL) |
| 2 | 表 | 集合 |
| 3 | 行 | 文档 |
| 4 | 列 | 成员 |
| 5 | 主键 | Object ID (自动维护) |

在整个行业之中, MongoDB 数据库是发展最好的一个 NoSQL 数据库。

因为它与 Node.js 捆绑在了一起, 也就是如果你要从事 Node.js 的开发, 那么一定要使用 MongoDB, 而 Node.js (基于 JavaScript)  在国内最成功的应用 —— taobao。

MongoDB 之所以能够更好的发展也取决于: 面向集合的存储过程、模式自由 (无模式) 、方便进行数据的存储和扩充、支持索引、支持短暂数据保留、具备完整的数据库状态监控、基于 BSON 应用。
