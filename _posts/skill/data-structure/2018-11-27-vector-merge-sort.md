---
layout: post
title: "C++ 数据结构 (二) 向量 (8) 归并排序"
date: 2018-11-27 16:24
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

## 归并排序

### 原理

分治策略

序列一分为二 $ O(1) $

子序列递归排序 $ 2 * T(\frac{n}{2}) $

合并有序子序列 $ O(n) $

![1.png](/img/in-post/skill/data-structure/post-vector-merge-sort/1.png)

若真能如此，归并排序的运行时间应该是 $ O(n * \log n) $

### 实现

```cpp
template <typename T>
void Vector<T>::mergeSort(Rank lo, Rank hi) { // [lo, hi)
  if (hi - lo < 2) return; // 单元素区间自然有序，否则 ...
  int mi = (lo + hi) >> 1; // 以中点为界
  mergeSort(lo, mi);       // 对前半段排序
  mergeSort(mi, hi);       // 对后半段排序
  merge(lo, mi, hi);       // 二路归并
}
```

![2.png](/img/in-post/skill/data-structure/post-vector-merge-sort/2.png)

## 二路归并

### 原理

two way merge: 将两个有序序列合并为一个有序序列, `S[lo, hi) = S[lo, mi) + S[mi, hi)`

![3.png](/img/in-post/skill/data-structure/post-vector-merge-sort/3.png)

### 基本实现

```cpp
template <typename T>
void Vector<T>::merge(Rank lo, Rank mi, Rank hi) {
  T *A = _elem + lo; // 合并后的向量 A[0, hi - lo) = _elem[lo, hi)

  int lb = mi - lo; T *B = new T[lb];  // 前子向量 B[0, lb) = _elem[lo, mi)
  for (Rank i = 0; i < lb; B[i] = A[i++]); // 复制前子向量B

  int lc = hi - mi; T *C = _elem + mi; // 后子向量 C[0, lc) = _elem[mi, hi)
  for (Rank i = 0, j = 0, k = 0; (j < lb) || (k < lc); ) {
    if ((j < lb) &amp;&amp; (lc <= k || (B[j] <= C[k]))) A[i++] = B[j++]; // C[k]已无或不小
    if ((k < lc) &amp;&amp; (lb <= j || (C[k] < B[j]))) A[i++] = C[k++]; // B[j]已无或更大
  } // 该循环实现紧凑，但就效率而言，不如拆分处理
  delete [] B; // 释放临时空间 B
}
```

![4.png](/img/in-post/skill/data-structure/post-vector-merge-sort/4.png)

### 正确性

![5.png](/img/in-post/skill/data-structure/post-vector-merge-sort/5.png)

## 性能分析

算法的运行时间主要消耗于 `for` 循环，共有两个控制变量

初始: j = 0, k = 0

最终: j = lb, k = lc

亦即: j + k = lb + lc = hi - lo = n

观察: 每经过一次迭代，j 和 k 中至少有一个会加一 (j + k 也至少加一)

故知: `merge()` 总体迭代 $ O(n) $ 次，累计只需线性时间

这一结论与排序算法的 $ \Omega (n * \log n) $ 下界并不矛盾 —— 毕竟这里的 B 和 C 均已各自有序

注意: 待归并子序列不必等长

亦即: 允许 $ lb \neq lc, mi \neq \frac{lo + hi}{2} $

实际上，这一算法及结论也适用于另一类序列 —— 列表 (下一章)
