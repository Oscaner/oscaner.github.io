---
layout: post
title: "C++ 数据结构 (一) 绪论 (3) 复杂度"
date: 2018-11-17 15:34
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

## 大 O 记号

当 $ n \gg 2 $ 后, 对于规模为 $ n $ 输入, 算法:

1. 需要执行的基本操作次数: $ T(n) = ? $

2. 需占用的存储单元数: $ S(n) = ? $ (通常不考虑)

$ T(n) = O( f(n) ) $

$ if \  \exists c > 0, 当 \  n \gg 2 \  后, 有 \  T ( n ) > c * f ( n ) $

与 $ T(n) $ 相比, $ f(n) $ 更为简介, 但依然反映前者的增长趋势

常系数可忽略: $ O( f(n) ) = O( c * f(n) ) $

低次项可忽略: $ O( n^a + n^b ) = O( n^a ), a > b > 0 $

## 其他记号

### Omega

$ T(n) = \Omega ( f ( n ) ) $

$ if \  \exists c > 0, 当 \  n \gg 2 \  后, 有 \  T ( n ) > c * f ( n ) $

### Theta

$ T(n) = \Theta ( f ( n ) ) $

$ if \  \exists c_1 > c_2 > 0, 当 \  n \gg 2 \  后, 有 \  c_1 * f( n ) > T( n ) > c_2 * f(n) $

## 大 O 复杂度

### 常数复杂度

这类算法的效率最高

$ O(2) \  = \  O(2013) \  = \  O(2013 * 2013) \  = \  O(2013^{2013}) \  = \  O(1) $

### 对数复杂度

$ \ln (n) $ | $ \lg (n) $ | $ \log_{100} (n) $ | $ \log_{2013} (n) $ |

1. 常底数无所谓

    $ \forall \  a, \  b > 0, \  \log_a n = \log_a b * \log_b n = \Theta (\log_b n) $

2. 常数次幂无所谓

    $ \forall \  c > 0, \  \log n^c = c * \log n = \Theta (\log n) $

3. 对数多项式

    $ 123 * \log^{321} n + \log^{105} (n^2 - n + 1) = \Theta (\log^{321} n) $

4. 小总结

    这类算法非常有效, 复杂度无限接近于常数

    $ \forall c > 0, \  \log n = O(n^c) $

### 多项式复杂度

1. $ 100n + 200 = O(n) $

2. $ (100n - 500)(20n^2 - 300n + 2013) = O(n * n^2) = O(n^3) $

3. $ \frac{2013n^2 - 20}{1999n - 1} = O( \frac{n^2}{n} ) = O(n) $

4. 一般的: $ a_k n^k + a_{k-1} n^{k-1} + \cdots + a_1 n + a_0 = O(n^k), \  a_k > 0 $

### 指数复杂度

这类算法的计算成本增长极快, 通常被认为不可忍受。

1. $ T(n) = a^n $

2. $ \forall c > 1, \  n^c = O(2^n) $

    $ \forall c > 1, \  {1.0000001}^n = \Omega (n^{1000}), \  n^{1000} = O({1.0000001}^n) = O(2^n) $

### 小结

从 $ O(n^c) $ 到 $ O(2^n) $, 是从有效算法到无效算法的分水岭

![1.png](/assets/img/in-post/skill/data-structure/post-intro-complexity/1.png)

很多问题的 $ O(2^n) $ 算法往往显而易见。然而, 设计出 $ O(n^c) $ 算法却极其不易, 甚至有时注定只能徒劳无功

### 问题描述

> S 包含 n 个正整数, $ \sum S = 2m $
>
> S 是否有子集 T, 满足 $ \sum T = m $ ？

直觉算法: 逐一枚举 S 的每一子集, 并统计其中元素的总和

1. 定理: $ \lvert 2^s \rvert = 2^{\lvert s \rvert} = 2^n $

    直觉算法需要迭代 $ 2^n $ 轮, 并 (在最坏情况下) 至少需要花费这么多的时间

2. 定理: subset is NP-complete

    就目前的计算模型而言, 不存在可在多项式复杂度内回答此问题的算法。就此意义而言, 上述的直觉算法已属最优
