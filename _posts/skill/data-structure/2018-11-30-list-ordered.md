---
layout: post
title: "C++ 数据结构 (三) 列表 (3) 有序列表"
date: 2018-11-30 16:17
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

## 唯一化

```cpp
template <typename T>
int List<T>::uniquify() { // 成批剔除重复元素
  if (_size < 2) return 0; // 平凡列表自然无重复
  int oldSize = _size; // 记录原规模
  ListNodePosi(T) p = first(); ListNodePosi(T) q; // p 为各区段起点，q 为其后继
  while (trailer != (q = p -> succ)) // 反复考查紧邻的节点对(p, q)
    if (p -> data != q -> data) p = q; // 若互异，则转向下一区段
    else remove(q); // 否则 (雷同) ，删除后者
  return oldSize - _size; // 规模变化量，即被删除元素总数
} // 只需遍历整个列表一趟，O(n)
```

## 查找

```cpp
template <typename T> // 在有序列表内节点 p 的 n 个 (真) 前驱中，找到不大于 e 的最后者
Posi(T) List<T>::search(T const &amp;e, int n, Posi(T) p) const {
  while (0 <= n--) // 对于 p 的最近的 n 个前驱，从右向左
    if (((p = p -> pred) -> data) <= e) break; // 逐个比较
  return p; // 直至命中、数值越界或范围越界后，返回查找终止的位置
} // 最好 O(1)，最坏 O(n)；等概率时平均 O(n)，正比于区间宽度
```
