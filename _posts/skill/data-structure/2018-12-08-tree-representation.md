---
layout: post
title: "C++ 数据结构 (五) 二叉树 (2) 树的表示"
date: 2018-12-08 15:16
author: "Oscaner"
header-img: "img/post-bg-alitrip.jpg"
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

## 接口

| 节点 | 功能 |
| :-- | :-- |
| root() | 根节点 |
| parent() | 父节点 |
| firstChild() | 长子 |
| nextSibling() | 兄弟 |
| insert(i, e) | 将 e 作为第 i 个孩子插入 |
| remove(i) | 删除第 i 个孩子 (及其后代) |
| traverse() | 遍历 |

## 父节点表示法

观察: 除根外，任一节点**有且仅有**一个父节点

构思: 将节点组织为序列，各节点分别记录 (data为本身信息，parent为父节点的秩或位置)

空间性能: $ O(n) $

时间性能:

- parent(): $ O(1) $
- root(): $ O(n) $ or $ O(1) $
- firstChild(): $ O(n) $
- nextSibling(): $ O(n) $

![1.png](/assets/img/in-post/skill/data-structure/post-tree-representation/1.png)

## 孩子节点表示法

![2.png](/assets/img/in-post/skill/data-structure/post-tree-representation/2.png)

## 父亲孩子表示法

![3.png](/assets/img/in-post/skill/data-structure/post-tree-representation/3.png)

## 长子兄弟表示法

每个节点均设两个引用

- 纵: firstChild()
- 横: nextSibling()

![4.png](/assets/img/in-post/skill/data-structure/post-tree-representation/4.png)
