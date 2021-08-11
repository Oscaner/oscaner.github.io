---
layout: post
title: "C++ 数据结构 (五) 二叉树 (7) 层次遍历"
date: 2018-12-11 16:26
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

## 实现

```cpp
template <typename T, typename VST>
void BinNode<T>::travLevel(VST &visit) { // 二叉树层次遍历
  Queue<BinNodePosi(T)> Q; // 引入辅助队列
  Q.enqueue(this); // 根节点入队
  while (!Queue.empty()) { // 队列变空之前，反复迭代
    BinNodePosi(T) x = Q.dequeue(); // 取出队首节点，并随即
    visit(x -> data);               // 访问之
    if (HasLChild(*x)) Q.enqueue(x -> lChild); // 左孩子入队
    if (HasRChild(*x)) Q.enqueue(x -> rChild); // 右孩子入队
  }
}
```

## 实例

![1.png](/img/in-post/skill/data-structure/post-btree-postorder/1.png)
