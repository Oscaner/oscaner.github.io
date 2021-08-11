---
layout: post
title: "C++ 数据结构 (一) 绪论 (5) 迭代与递归 (1)"
date: 2018-11-19 16:24
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

> To iterate is human, to recurse, divine.
>
> 迭代乃人工, 递归方神通

## 数组求和: 迭代

### 问题

计算任意 n 个整数之和

### 实现

逐一取出每个元素, 累加之

```cpp
int sum(int A[], int n) {
  int sum = 0; // O(1)
  for (int i = 0; i < n; i++) sum += A[i]; // O(n)
  return sum;  // O(1)
}
```

### 分析

无论 `A[]` 内容如何, 都有:

$ T(n) = 1 + n * 1 + 1 = n + 2 = O(n) = \Omega (n) = \Theta (n) $

## 减而治之

为求解一个大规模的问题, 可以:

1. 将其划分为两个子问题: 其一 **平凡**, 另一规模 **缩减**

2. 分别求解子问题

3. 由子问题的解, 得到原问题的解

![1.png](/img/in-post/skill/data-structure/post-intro-recursion-iteration-1/1.png)

## 数组求和: 线性递归

```cpp
sum (int A[], int n) {
  return (n < 1) ? 0 : sum(A, n - 1) + A[n - 1];
}
```

## 递归跟踪分析

1、检查每个 **递归实例**

2、累计所需时间 (调用语句本身, 计入对应的子实例)

3、其总和即算法执行时间

![2.png](/img/in-post/skill/data-structure/post-intro-recursion-iteration-1/2.png)

本例中, 单个递归实例自身只需 $ O(1) $ 时间, 故:

$ T(n) = O(1) * (n + 1) = O(n) $

## 递推方程

从递推的角度看, 为求解 `sum(A, n)`, 需

1. 递归求解规模为 `n - 1` 的问题 `sum(A, n-1)`

    `T(n-1)`

2. 再累加上 A[n-1]

    `O(1)`

3. 递归基: sum(A, 0)

    `O(1)`

4. 递归方程:

    $$
    \begin{cases}
      T(n) = T(n-1) + O(1)
      \\
      T(0) = O(1)
    \end{cases}
    =>
    T(n) = O(1) + n = O(n)
    $$
