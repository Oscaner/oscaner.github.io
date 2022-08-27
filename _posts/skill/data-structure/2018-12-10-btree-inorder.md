---
layout: post
title: "C++ 数据结构 (五) 二叉树 (6) 中序遍历"
date: 2018-12-10 15:46
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

## 递归

```cpp
template <typename T, typename VST>
void traverse(BinNodePosi(T) x, VST &visit) {
  if (!x) return;
  traverse(x -> lChild, visit);
  visit(x -> data);
  traverse(x -> rChild, visit);
} // T(n) = T(a) + O(1) + T(n-a-1) = O(n)
```

![1.png](/assets/img/in-post/skill/data-structure/post-btree-inorder/1.png)

## 迭代

### 观察

![2.png](/assets/img/in-post/skill/data-structure/post-btree-inorder/2.png)

### 思路

从根出发沿左分支下行, 直到最深的节点 —— 它就是全局首先被访问者

![3.png](/assets/img/in-post/skill/data-structure/post-btree-inorder/3.png)

### 算法

```cpp
template <typename T>
static void goAlongLeftBranch(BinNodePosi(T) x, Stack <BinNodePosi(T)> &S) {
  while (x) { S.push(x); x = x -> lChild; } // 反复地入栈, 沿左分支深入
}

template <typename T, typename V>
void travIn_I1(BinNodePosi(T) x, V &visit) {
  Stack <BinNodePosi(T)> S; // 辅助栈
  while (true) { // 反复地
    goAlongLeftBranch(x, S); // 从当前节点出发, 逐批入栈
    if (S.empty()) break; // 直至所有节点处理完毕
    x = S.pop();      // x 的左子树或为空, 或已遍历 (等效于空), 故可以
    visit(x -> data); // 立即访问之
    x = x -> rChild;  // 再转向其右子树 (可能为空, 留意处理手法)
  }
}
```

### 实例

![4.png](/assets/img/in-post/skill/data-structure/post-btree-inorder/4.png)
