---
layout: post
title: "C++ 数据结构 (五) 二叉树 (3) 二叉树概述"
date: 2018-12-08 16:01
author: "Oscaner"
header-img: "assets/img/post-bg-alitrip.jpg"
multilingual: false
mathjax: true
no-catalog: false
categories:
  - skill
  - clang
  - c++
  - data structure
tags:
  - Skill
  - Clang
  - C++
  - Data Structure
---

## 二叉树

节点度数 **不超过2** 的树称作二叉树 (binary tree)

同一节点的孩子和子树，均以**左、右**区分

`lChild() ~ lSubtree()`

`rChild() ~ rSubtree()`

隐含有序

![1.png](/assets/img/in-post/skill/data-structure/post-btree-intro/1.png)

## 基数

深度为 $ k $ 的节点，至多 $ 2^k $ 个

含 $ n $ 个节点、高度为 $ h $ 的二叉树中，$ h < n < 2^(h+1)$

当 $ n = h + 1 $ 时，二叉树退化为一条单链

当 $ n = 2^(h+1) - 1 $ 时，即所谓**满二叉树** (full binary tree)

![2.png](/assets/img/in-post/skill/data-structure/post-btree-intro/2.png)

## 真二叉树

所谓真二叉树，就是节点的出度只能为 `2` 或 `0` 的二叉树

![3.png](/assets/img/in-post/skill/data-structure/post-btree-intro/3.png)

## 用二叉树描述多叉树

二叉树是多叉树的特例，但在**有根且有序**时，其描述能力却足以覆盖后者

多叉树均可转化并表示为二叉树 —— 回忆**长子兄弟表示法**

![4.png](/assets/img/in-post/skill/data-structure/post-btree-intro/4.png)
