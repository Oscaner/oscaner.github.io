---
layout: post
title: "C++ 数据结构 (五) 二叉树 (5) 先序遍历"
date: 2018-12-10 13:44
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

## 遍历规则

按照**某种次序**访问树中各节点，每个节点被访问**恰好一次**

$ T = V \cup L \cup R $

遍历结果 ~ 遍历过程 ~ 遍历次序 ~ 遍历策略

| 先序 | 中序 | 后序 | 层次 (广度) |
| :--: | :--: | :--: | :--: |
| **V** \| L \| R | L \| **V** \| R | L \| R \| **V** | 自上而下，先左后右 |

![1.png](/img/in-post/skill/data-structure/post-btree-preorder/1.png)

## 递归

```cpp
template <typename T, typename VST>
void traverse(BinNodePosi(T) x, VST &visit) {
  if (!x) return;
  visit(x -> data);
  traverse(x -> lChild, visit);
  traverse(x -> rChild, visit);
} // T(n) = O(1) + T(a) + T(n-a-1) = O(n)
```

![2.png](/img/in-post/skill/data-structure/post-btree-preorder/2.png)

## 迭代1

### 算法

```cpp
template <typename T, typename VST>
void travPre_I1(BinNodePosi(T) x, VST &visit) {
  Stack <BinNodePosi(T)> S; // 辅助栈
  if (x) S.push(x); // 根节点入栈
  while (!S.empty()) { // 栈变空之前反复循环
    x = S.pop(); visit(x -> data); // 弹出并访问当前节点
    if (HasRChild(*x)) S.push(x -> rChild); // 右孩子先入后出
    if (HasLChild(*x)) S.push(x -> lChild); // 左孩子后入先出
  }
}
```

### 实例

![3.png](/img/in-post/skill/data-structure/post-btree-preorder/3.png)

## 迭代2

### 思路

![4.png](/img/in-post/skill/data-structure/post-btree-preorder/4.png)

### 构思

![5.png](/img/in-post/skill/data-structure/post-btree-preorder/5.png)

### 算法

```cpp
template <typename T, typename VST> // 分摊 O(1)
static void visitAlongLeftBranch(BinNodePosi(T) x, VST &visit, Stack <BinNodePosi(T)> &S) {
  while (x) { // 反复地
    visit(x -> data); // 访问当前节点
    S.push(x -> rChild); // 右孩子 (右子树) 入栈 (将来逆序出栈)
    x = x -> lChild; // 沿左侧链下行
  }
}

template <typename T, typename VST>
void travPre_I2(BinNodePosi(T) x, VST &visit) {
  Stack <BinNodePosi(T)> S; // 辅助栈
  while (true) { // 以 (右) 子树为单位，逐批访问节点
    visitAlongLeftBranch(x, visit, S); // 访问子树 x 的左侧链，右子树入栈缓冲
    if (S.empty()) break; // 栈空即退出
    x = S.pop(); // 弹出下一子树的根
  } // #pop = #push = #visit = O(n) = 分摊 O(1)
}
```

### 实例

![6.png](/img/in-post/skill/data-structure/post-btree-preorder/6.png)
