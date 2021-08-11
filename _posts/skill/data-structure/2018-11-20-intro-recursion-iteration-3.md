---
layout: post
title: "C++ 数据结构 (一) 绪论 (5) 迭代与递归 (3)"
date: 2018-11-20 16:03
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

## Find Two Max

### 问题描述

从数组区间 `A[lo, hi)` 中找出最大的两个整数 `A[x1]` 和 `A[x2]`, 且 `A[x1] ≥ A[x2]`

元素比较的次数要求尽可能少

### 迭代法一

```cpp
void max2(int A[], int lo, int hi, int &x1, int &x2) // 1 < n = hi - lo
{
  for (x1 = lo, int i = lo + 1; i < hi; i++) {       // 扫描 A[lo, hi), 找出 A[x1]
    if (A[x1] < A[i]) x1 = i;                        // hi - lo - 1 = n - 1
  }
  for (x2 = lo, int i = lo + 1; i < x1; i++) {       // 扫描 A[lo, x1)
    if (A[x2] < A[i]) x2 = i;                        // xi - lo - 1
  }
  for (int i = x1 + 1; i < hi; i++) {                // 再扫描 A(x1, hi), 找出 A[x2]
    if (A[x2] < A[i]) x2 = i;                        // hi - x1 - 1
  }
}
```

![1.png](/img/in-post/skill/data-structure/post-intro-recursion-iteration-3/1.png)

无论如何, 比较次数总是 $ T(n) = hi - lo - 1 + xi - lo - 1 + hi - x1 - 1 = \Theta (2n - 3) $

### 迭代法二

```cpp
void max2(int A[], int lo, int hi, int &x1, int &x2) // 1 < n = hi - lo
{
  if (A[x1 = lo] < A[x2 = lo + 1]) swap(x1, x2);     // 1
  for (int i = lo + 2; i < hi; i++) {                // hi - lo - 2 = n - 2
    if (A[x2] < A[i]) {
      if (A[x1] < A[x2 = i]) swap(x1, x2);
    }
  }
}
```

![2.png](/img/in-post/skill/data-structure/post-intro-recursion-iteration-3/2.png)

最好情况：$ 1 + (n - 2) * 1 = n - 1 $

最坏情况：$ 1 + (n - 2) * 2 = 2n - 3 $

### 递归 + 分治

```cpp
void max2(int A[], int lo, int hi, int &x1, int &x2) {
  if (lo + 2 == hi) {
    if (A[x1 = lo] < A[x2 = lo + 1]) swap(x1, x2); return;
  } // T(2) = 1

  if (lo + 3 == hi) {
    if (A[x1 = lo] < A[x2 = lo + 1]) swap(x1, x2);
    if (A[x2] < A[lo + 2]) x2 = lo + 2;
    if (A[x1] < A[x2]) swap(x1, x2);
    return;
  } // T(3) <= 3

  int mi = (lo + hi) / 2;

  int x1L, x2L; max2(A, lo, mi, x1L, x2L); // T(n/2)

  int x1R, x2R; max2(A, mi, hi, x1R, x2R); // T(n/2)

  if (A[x1L] > A[x1R]) {
    x1 = x1L;
    x2 = (A[x2L] > A[x1R]) ? x2L : x1R;
  } else {
    x1 = x1R;
    x2 = (A[x2R] > A[x1L]) ? x2R : x1L;
  } // 1 + 1 = 2

} // T(n) = 2 * T(n/2) + 2 <= 5n/3 - 2
```

![5.png](/img/in-post/skill/data-structure/post-intro-recursion-iteration-3/5.png)
