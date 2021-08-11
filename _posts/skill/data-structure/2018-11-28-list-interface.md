---
layout: post
title: "C++ 数据结构 (三) 列表 (1) 接口与实现"
date: 2018-11-28 15:22
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

## 从静态到动态

- 根据是否修改数据结构, 所有操作大致分为两类方式：

    1. 静态：仅读取, 数据结构的内容及组成**一般**不变, 如 `get`、`search`

    2. 动态：需写入, 数据结构的局部或整体将改变, 如 `insert`、`remove`

- 与操作方式相对应的, 数据元素的存储与组织方式也分为两种：

    1. 静态

        - 数据空间整体创建或销毁
        - 数据元素的**物理存储次序**与其**逻辑次序**严格一致
        - 可支持高效的**静态**操作
        - 比如向量, 元素的物理地址与其逻辑次序线性对应

    2. 动态

        - 为各数据元素动态分配和回收物理空间
        - 逻辑上相邻的元素记录彼此的物理地址, 在逻辑上形成一个整体
        - 可支持高效的动态操作

## 从向量到列表

列表 (list) 是采用动态储存策略的典型结构

其中的元素称作节点 (node)

各节点通过指针或引用彼此联接, 在**逻辑**上构成一个线性序列

$ L = \lbrace a_0, a_1, \cdots , a_{n-1} \rbrace $

向量节点彼此互称前驱 (predecessor) 或后继 (successor)

前驱或后继若存在, 则必然唯一

没有前驱/后继的**唯一**节点称作**首** (first/front) /**末** (last/rear) 节点

![1.png](/img/in-post/skill/data-structure/post-list-interface/1.png)

## 从秩到位置

向量支持循秩访问 (call-by-rank) 的方式

根据数据元素的秩, 可在 $ O(1) $ 时间内直接确定其物理地址

V[i] 的物理地址 = V + i * s, s 为单个单元占用的空间量

既然同属线性序列, 列表固然也可通过秩来定位节点：从头/尾端出发, 沿后继/前驱引用 ...

然而, 此时的循秩访问成本过高, 已不合时宜

因此, 应改用**循位置访问** (call-by-position) 的方式

亦即, 应转而利用节点之间的相互引用, 找到特定的节点

![2.png](/img/in-post/skill/data-structure/post-list-interface/2.png)

## 列表节点：ADT 接口

作为列表的基本元素, 列表节点首先需要独立的"封装"实现

为此, 可设置并约定若干基本的操作接口

| 操作 | 功能 |
| --: | :-- |
| pred() | 当前节点前驱节点的位置 |
| succ() | 当前节点后继节点的位置 |
| data() | 当前节点所存数据对象  |
| insertAsPred(e) | 插入前驱节点, 存入被引用对象 e, 返回新节点位置 |
| insertAsSucc(e) | 插入后继节点, 存入被引用对象 e, 返回新节点位置 |

## 列表节点：ListNode模板类

```cpp
#define Posi(T) ListNode<T>* // 列表节点位置 (ISO C++.0x, template alias)

template <typename T> // 简洁起见, 完全开放而不再过度封装
struct ListNode { .. 列表节点模板类 (以双向链表形式实现)
  T data; // 数值
  Posi(T) pred; // 前驱
  Posi(T) succ; // 后继
  ListNode() {} // 针对 header 和 trailer 的构造
  ListNode(T e, Posi(T) p = NULL, Posi(T) s = NULL)
    : data(e), pred(p), succ(s) {} // 默认构造器
  Posi(T) insertAsPred(T const &amp;e); // 前插入
  Posi(T) insertAsSucc(T const &amp;e); // 后插入
}
```

![3.png](/img/in-post/skill/data-structure/post-list-interface/3.png)

## 列表：ADT 接口

| 操作接口 | 功能 | 适用对象 |
| :--: | :--: | :--: |
| size() | 报告列表当前的规模 (节点总数) | 列表 |
| first(), last() | 返回首、末节点的位置 | 列表 |
| insertAsFirst(e), insertAsLast(e) | 将 e 当作首、末节点插入 | 列表 |
| insertBefore(p, e), insertAfter(p, e) | 将 e 当作节点 p 的直接前驱、后继插入 | 列表 |
| remove(p) | 删除位置 p 处的节点, 返回其引用 | 列表 |
| disordered() | 判断所有节点是否已按非降序排列 | 列表 |
| sort() | 调整各节点的位置, 使之按非降序排列 | 列表 |
| find(e) | 查找目标元素 e, 失败时返回 NULL | 列表 |
| search(e) | 查找 e, 返回不大于 e 且秩最大的节点 | 有序列表 |
| deduplicate(), uniquify() | 剔除重复节点 | 列表/有序列表 |
| traverse() | 遍历列表 | 列表 |

## 列表：List模板类

```cpp
#include "listNode.h" // 引入列表节点类

template <typename T> class List { // 列表模板类
  private:
    int _size; // 规模
    Posi(T) header; Posi(T) trailer; // 头、尾哨兵
  protected:
    /* ... 内部函数 */
  public:
    /* ... 构造函数、析构函数、只读接口、可写接口、遍历接口 */
};
```

![4.png](/img/in-post/skill/data-structure/post-list-interface/4.png)

等效的, **头、首、末、尾**节点的秩可分别理解为`-1、0、n-1、n`

## 构造

```cpp
template <typename T>
void List<T>::init() { // 初始化, 创建列表对象时统一调用
  header = new ListNode<T>; // 创建头哨兵节点
  trailer = new ListNode<T>; // 创建尾哨兵节点
  header -> succ = trailer; header -> pred = NULL; // 互联
  trailer -> pred = head; trailer -> succ = NULL; // 互联
  _size = 0; // 记录规模
}
```

![5.png](/img/in-post/skill/data-structure/post-list-interface/5.png)
