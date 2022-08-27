---
layout: post
title: "C++ 数据结构 (一) 绪论 (6) 动态规划 (2)"
date: 2018-11-21 16:23
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

## 最长公共子序列

子序列 (Subsequence): 由序列中若干字符, 按原相对次序构成

![1.png](/assets/img/in-post/skill/data-structure/post-intro-dynamic-programming-2/1.png)

最长公共子序列 (Longest Common Subsequence): 两个序列公共子序列中的最长者

![2.png](/assets/img/in-post/skill/data-structure/post-intro-dynamic-programming-2/2.png)

## LCS(): 递归

对于序列 `A[0, n]` 和 `B[0, m]`, `LCS(A, B)` 有三种情况

1. 递归基: 若 `n = -1` 或 `m = -1`, 则取作空序列 ("")

2. 减而治之: 若 `A[n] = 'X' = B[m]`, 则取作 `LCS(A[0, n), B[0, m)) + 'X'`

![3.png](/assets/img/in-post/skill/data-structure/post-intro-dynamic-programming-2/3.png)

3. 分而治之: 若 `A[n] ≠ B[m]`, 则在 `LCS(A[0, n], B[0, m))` 与 `LCS(A[0, n), B[0, m])` 中取更长者

![4.png](/assets/img/in-post/skill/data-structure/post-intro-dynamic-programming-2/4.png)

## LCS(): 理解

![5.png](/assets/img/in-post/skill/data-structure/post-intro-dynamic-programming-2/5.png)

1. 单调性: 无论如何, 每经过一次比对, 原问题的规模必可减小。

    具体的, 作为输入的两个序列, 至少其一的长度缩短一个单位。

2. 最好情况 (不出现分而治之的情况) 下, 只需 `O(n+m)` 时间。

    但问题在于, 出现分而治之的情况下, 原问题将被分解为两个子问题。

    更糟糕的是, 它们在随后进一步导出的子问题, 可能雷同。

    ![6.png](/assets/img/in-post/skill/data-structure/post-intro-dynamic-programming-2/6.png)

    在最坏情况下, `LCS(A[0, a], B[0, b])` 出现的次数为

    $$
    \begin{pmatrix}
      & n + m - a - b &
      \\
      & n - a &
    \end{pmatrix}
    =
    \begin{pmatrix}
      & n + m - a - b &
      \\
      & m - a &
    \end{pmatrix}
    $$

    特别的, `LCS(A[0], B[0])` 的次数可多达:

    $$
    \begin{pmatrix}
      & n + m &
      \\
      & n &
    \end{pmatrix}
    =
    \begin{pmatrix}
      & n + m &
      \\
      & m &
    \end{pmatrix}
    $$

    当 n = m 时, 时间复杂度为 $ O(2^n) $

## LCS(): 迭代

与 `fib()` 类似, `LCS()` 递归版也有大量重复的递归实例 (子问题), (最坏情况下) 先后共计出现 $ O(x^n) $ 个

各子问题, 分别对应于 A 和 B 的某个前缀组合, 因此总共不过 $ O(n * m) $ 种

采用动态规划的策略, 只需要 $ O(n * m) $ 时间可计算出所有子问题

为此, 只需:

1. 将所有子问题 (假想地) 列成一张表

2. 颠倒计算方向, 从 `LCS(A[0], B[0])` 出发依次计算出所有项

![7.png](/assets/img/in-post/skill/data-structure/post-intro-dynamic-programming-2/7.png)

## 算法实现

算法实现请看: [《PHP — LCS》]({% link _posts/skill/coding/2018-11-22-php-lcs.md %}){:target="_blank"}

【注】虽然是用 PHP 实现, 但原理基本一致, 可做参考
