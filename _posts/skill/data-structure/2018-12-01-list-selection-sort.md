---
layout: post
title: "C++ 数据结构 (三) 列表 (4) 选择排序"
date: 2018-12-01 14:27
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

## 实例

![1.png](/assets/img/in-post/skill/data-structure/post-list-selection-sort/1.png)

## 实现: selectionSort()

```cpp
// 对列表中起始于位置 p 的连续 n 个元素做选择排序，valid(p) &amp;&amp; rank(p) + n <= size
template <typename T>
void List<T>::selectionSort(Posi(T) p, int n) {
  Posi(T) head = p -> pred; Posi(T) tail = p; // 待排序区间 (head, tail)
  for (int i = 0; i < n; i++) tail = tail -> succ; // head/tail 可能是头/尾哨兵
  while (1 < n) { // 反复从 (非平凡的) 待排序区间内找出最大者，并移至有序区间前端
    insertBefore(tail, remove(selectMax(head -> succ, n)));
    tail = tail -> pred; n--; // 待排序区间、有序区间的范围，均同步更新
  }
}
```

![2.png](/assets/img/in-post/skill/data-structure/post-list-selection-sort/2.png)

## 实现: selectMax()

```cpp
template <typename T> // 从起始于位置 p 的 n 个元素中选出最大者，1 < n
Posi(T) List<T>::selectMax(Posi(T) p, int n) { // O(n)
  Posi(T) max = p; // 最大者暂定为 p
  for (Posi(T) cur = p; 1 < n; n--) // 后续节点逐一与 max 比较
    if (!lt((cur = cur -> succ) -> data, max -> data)) // 若 >= max
      max = cur; // 则更新最大元素位置记录
  return max; // 返回最大节点位置
}
```

![3.png](/assets/img/in-post/skill/data-structure/post-list-selection-sort/3.png)

## 性能

共迭代 n 次，在第 k 次迭代中

`selectMax()` 为 $ \Theta (n - k) $

`remove()` 和 `insertBefore()` 均为 $ O(1) $

故总体复杂度应为 $ \Theta (n^2) $

尽管如此，元素**移动**操作远远少于起泡排序

也就是说，$ \Theta (n^2) $ 主要来自于元素**比较**操作
