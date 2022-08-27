---
layout: post
title: "C++ 数据结构 (一) 绪论 (6) 动态规划 (1)"
date: 2018-11-21 15:15
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

【注】`fib()` 意为斐波那契额数列算法

## fib(): 递归

$ fib(n) = fib(n-1) + fib(n-2): {0, 1, 1, 2, 3, 5, 8 ...} $

```cpp
int fib(n) {
  return (2 > n) ? n : fib(n - 1) + fib(n - 2);
}
```

## fib(): 递推方程

$$
\begin{aligned}
  复杂度: &
  \begin{cases}
    T(0) = T(1) = 1
    \\
    T(n) = T(n - 1) + T(n - 2) + 1 \; , \; n > 1
  \end{cases}

  \\

  令: & S(n) = [T(n) + 1] / 2

  \\

  则: & S(0) = 1 = fib(1), \; S(1) = 1 = fib(2)

  \\

  故: & S(n) = S(n - 1) + S(n - 2) = fib(n + 1)

  \\

  & T(n) = 2 * S(n) - 1 = 2 * fib(n + 1) - 1 = O(fib(n + 1)) = O(\phi^n) = O(2^n)
\end{aligned}
$$

## fib(): 封底估算

- $ \phi = \frac{1 + \sqrt{5}}{2} = 1.61803 \cdots $

- `fib()` 计算第 43 项大致需要 1 s

    $$
    \begin{aligned}
    & \phi^{36} \approx 2^{25}
    \\
    & \phi^{43} \approx 2^{30} \approx 10^9 flo \approx 1 sec
    \end{aligned}
    $$

- `fib()` 计算第 67 项大致需要 1 day

    $$
    \begin{aligned}
    & \phi^5 \approx 10
    \\
    & \phi^{67} \approx 10^{14} flo \approx 10^5 sec \approx 1 day
    \end{aligned}
    $$

- `fib()` 计算第 92 项大致需要 3 century

    $$
    \phi^{92} \approx 10^{19} flo \approx 10^{10} sec \approx 10^5 day \approx 3 century
    $$

## fib(): 递归跟踪

递归版 `fib()` 低效的根源在于，各递归实例均被大量重复调用

![1.png](/assets/img/in-post/skill/data-structure/post-intro-dynamic-programming/1.png)

## fib(): 迭代

### 解决方法A: 记忆 (memoization)

将已计算过实例的结果制表备查

### 解决方法B: 动态规划 (dynamic programming)

颠倒计算方向，由自顶而下递归改为自底而上迭代

$ T(n) = O(n)，而且仅需 \  O(1) \  空间 $

![3.png](/assets/img/in-post/skill/data-structure/post-intro-dynamic-programming/3.png)

```cpp
f = 0; g = 1; // fib(0); fib(1)
while (0 < n--) {
    g = g + f;
    f = g - f;
}
return g;
```

| n    | g    |       | f    |        |
| :--: | :--: | :--:  | :--: | :--:   |
| 0    | 1    |       | 0    |        |
| 1    | 1    | 1 + 0 | 1    | 1 - 0  |
| 2    | 2    | 1 + 1 | 1    | 2 - 1  |
| 3    | 3    | 2 + 1 | 2    | 3 - 1  |
| 4    | 5    | 3 + 2 | 3    | 5 - 2  |
| ...  | g    |       | f    |        |
| ...  | g'   | g + f | f'   | g' - f |
