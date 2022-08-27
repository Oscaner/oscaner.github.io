---
layout: post
title: "C++ 数据结构 (二) 向量 (6) 斐波那契查找"
date: 2018-11-25 16:13
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

【注】斐波那契查找是在二分查找的基础上根据斐波那契数列进行分割的

## 思路及原理

二分查找版本A的效率仍有改进的余地, 因为不难发现

转向左、右分支前的关键码 **比较次数** 不等, 而 **递归深度** 却相同

若能通过 **递归深度** 的不均衡, 对 **转向成本** 的不均衡进行补偿

平均查找长度应能进一步缩短 ...

比如, 若设 `n = fib(k) - 1`, 则可取 `mi = fib(k - 1) - 1`

于是, 前、后子向量的长度分别为 `fib(k - 1) - 1`、`fib(k - 2) - 1`

![1.png](/assets/img/in-post/skill/data-structure/post-vector-fibonacci-search/1.png)

## 查找长度

Fibonacci 查找的 ASL, (在常系数的意义上) 由于二分查找

以 `n = fib(6) - 1 = 7` 为例, 在等概率情况下

$ 平均成功查找长度 = \frac{5 + 4 + 3 + 5 + 2 + 5 + 4}{7} = \frac{28}{7} = 4.00 $

$ 平均失败查找长度 = \frac{4 + 5 + 4 + 4 + 5 + 4 + 5 + 4}{8} = \frac{35}{8} = 4.38 $

![2.png](/assets/img/in-post/skill/data-structure/post-vector-fibonacci-search/2.png)

## 实现

```cpp
template <typename T> // 0 <= lo <= hi <= _size
static Rank fibSearch(T *A, T const &amp;e, Rank lo, Rank hi) {
  Fib fib(hi - lo); // 用 O(logn) = O(log(hi - lo)) 时间创建 Fib 数列
  while (lo < hi) {
    while (hi - lo < fib.get()) fib.prev(); // 至多迭代几次 ?
    // 通过向前顺序查找, 确定形如 Fib(k) - 1 的轴点 (分摊 O(1))
    Rank mi = lo + fib.get() - 1;    // 按黄金比例切分
    if (e < A[mi]) hi = mi;          // 前半段 [lo, mi)
    else if (A[mi] < e) lo = mi + 1; // 后半段 (mi, hi)
    else return mi;                  // 匹配
  }
  return -1; // 查找失败
}
```

## 最优性

通用策略: 对于任何的 $ A[0, n) $, 总是选取 $ A[\lambda n] $ 作为轴点, $ 0 \leq \lambda < 1 $

比如: 二分查找对应于 $ \lambda = 0.5 $, Fibonacci 查找对应于 $ \lambda = \phi = 0.6180339 \cdots $

在 $ [0, 1) $ 内, $ \lambda $ 如何取值才能达到最优？设平均查找长度 $ \alpha (\lambda) * \log_2 n $, 何时 $ \alpha (\lambda) $ 最小

递推式: $ \alpha (\lambda) * \log_2 n = \lambda * \lbrack 1 + \alpha (\lambda) * \log_2 (\lambda n) \rbrack + (1 - \lambda ) * \lbrack 2 + \alpha (\lambda) * \log_2 ((1 - \lambda) n) \rbrack  $

整理后: $ \frac{- \ln 2}{\alpha (\lambda)} = \frac{\lambda * \ln \lambda + (1 - \lambda) * \ln (1 - \lambda)}{2 - \lambda} $, 当 $ \lambda = \phi $ 时, $ \alpha (\lambda) = 1.440420 \cdots $ 达到最小

![3.png](/assets/img/in-post/skill/data-structure/post-vector-fibonacci-search/3.png)
