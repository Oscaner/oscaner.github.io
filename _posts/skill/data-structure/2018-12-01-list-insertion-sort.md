---
layout: post
title: "C++ 数据结构 (三) 列表 (5) 插入排序"
date: 2018-12-01 16:43
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

## 构思

![1.png](/assets/img/in-post/skill/data-structure/post-list-insertion-sort/1.png)

始终将序列看成两部分:

| Sorted | Unsorted |
| `L[0, r)` | `L[r, n)` |

【初始化】 `|S| = r = 0`, 空序列无所谓有序

【迭代】关注并处理 `e = L[r]`, 在 `S` 中确定 **适当位置** 插入 `e`, 得到有序的 `L[0, r]`

【不变性】随着 `r` 的递增, `L[0, r)` 始终有序, 直到 `r = n`, `L` 即整体有序

## 实例

![2.png](/assets/img/in-post/skill/data-structure/post-list-insertion-sort/2.png)

## 实现

```cpp
// 对列表中起始于位置 p 的连续 n 个元素做插入排序, valid(p) && rank(p) + n <= size
template <typename T>
void List<T>::insertionSort(Posi(T) p, int n) {
  for (int r = 0; r < n; r++) { // 逐一引入各节点, 由 S(r) 得到 S(r+1)
    insertAfter(search(p -> data, r, p), p -> data); // 查找 + 插入
    p = p -> succ; remove(p -> pred); // 转向下一节点
  } // n 次迭代, 每次 O(r + 1)
} // 仅使用 O(1) 辅助空间, 属于就地算法
```

## 性能分析

最好情况: 完全 (或几乎) 有序。每次迭代, 只需 `1` 次比较, `0` 次交换, 累计 $ O(n) $ 时间

最坏情况: 完全 (或几乎) 无序。每次迭代, 需 $ O(k) $ 次比较, `1` 次交换, 累计 $ O(n^2) $ 时间

## 平均性能

![3.png](/assets/img/in-post/skill/data-structure/post-list-insertion-sort/3.png)

假定: 各元素的取值遵守均匀、独立分布

于是: 平均要做多少次元素比较？

考查: `L[r]` 刚插入完成的那一时刻 (穿越？)

试问: 此时的有序前缀 `L[0, r]` 中, 哪个元素是此前的 `L[r]`？

观察: 其中 `r + 1` 个元素 **均有可能**, 且概率均等于 `1/(r + 1)`

因此, 在刚完成的这次迭代中, 为引入 `S[r]` 所花费时间的数学期望为

$ \frac{r + (r - 1) + \cdots + 3 + 2 + 1 + 0}{r + 1} + 1 = \frac{r}{2} + 1 $

于是, 总体时间的数学期望 $ = \frac{0 + 1 + \cdots + (n - 1)}{2} + 1 = O(n^2) $
