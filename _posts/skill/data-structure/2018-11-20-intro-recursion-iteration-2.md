---
layout: post
title: "C++ 数据结构 (一) 绪论 (5) 迭代与递归 (2)"
date: 2018-11-20 15:17
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

## 数组倒置

### 问题描述

任给数组 `A[0, n)`, 将其前后颠倒

统一接口: `void reverse(int *A, int lo, int hi);`

### 递归版

```cpp
void reverse(int *A, int lo, int hi) {
  if (lo < hi) { // 问题规模的奇偶性不变, 需要两个递归基
    swap(A[lo], A[hi]);
    reverse(A, lo + 1, hi - 1);
  }
}
```

![1.png](/assets/img/in-post/skill/data-structure/post-intro-recursion-iteration-2/1.png)

### 迭代原始版

```cpp
void reverse(int *A, int lo, int hi) {
  next:
  if (lo < hi) {
    swap(A[lo], A[hi]);
    lo++;
    hi--;
    goto next;
  }
}
```

### 迭代精简版

```cpp
void reverse(int *A, int lo, int hi) {
  while (lo < hi) swap(A[lo++], A[hi--]);
}
```

## 分而治之

为求解一个大规模的问题, 可以:

1. 将其划分为若干 (通常两个) 子问题, 规模大体相当

2. 分别求解子问题

3. 由子问题的解, 得到原问题的解

![2.png](/assets/img/in-post/skill/data-structure/post-intro-recursion-iteration-2/2.png)

## 数组求和: 二分递归

```cpp
/**
 * 对 A[lo, hi] 内元素求和
 * 入口形式为 sum(A, 0, n - 1)
 */
sum(int A[], int lo, int hi) {
  if (lo == hi) return A[lo];
  int mi = (lo + hi) &gt;&gt; 1; // 等价于 (lo + hi) / 2
  return sum(A, lo, mi) + sum(A, mi + 1, hi);
}
```

![3.png](/assets/img/in-post/skill/data-structure/post-intro-recursion-iteration-2/3.png)

## 递归跟踪分析

$$
\begin{aligned}
T(n) &= 各层递归实例所需时间之和 \\
     &= O(1) * (2^0 + 2^1 + 2^2 + \cdots + 2^{\log n}) \\
     &= O(1) * (2^{\log n + 1} - 1) \\
     &= O(n)
\end{aligned}
$$

![4.png](/assets/img/in-post/skill/data-structure/post-intro-recursion-iteration-2/4.png)

## 递推方程

从递推的角度看, 为求解 `sum(A, lo, hi)`, 需

1. 递归求解 `sum(A, lo, mi)` 和 `sum(A, mi + 1, hi)`

    `2 * T(n/2)`

2. 进而将子问题的解累加

    `O(1)`

3. 递归基: sum(A, lo, lo)

    `O(1)`

4. 递推方程:

    $$
    \begin{cases}
      T(n) = 2 * T( \frac{n}{2} ) + O(1)
      \\
      T(1) = O(1)
    \end{cases}
    =>
    T(n) = (c_1 + c_2)n - c_1 = O(n)
    $$
