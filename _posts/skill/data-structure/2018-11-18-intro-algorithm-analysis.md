---
layout: post
title: "C++ 数据结构 (一) 绪论 (4) 算法分析"
date: 2018-11-18 14:49
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

## 主要任务

1. 算法分析的两个主要任务: 正确性 (不变性 * 单调性), 复杂度

2. C++ 等高级语言的 **基本指令**, 均等效于常数条 RAM 的 **基本指令**

3. 在渐进意义下, 二者大体相当于:

    - 分支转向: `goto`

        算法的灵魂, 出于结构化考虑, 被隐藏了

    - 迭代循环: `for()`、`while()`、...

        本质上就是 "if + goto"

    - 调用 + 递归 (自我调用)

        本质上也是 goto

## 主要方法

复杂度分析的主要方法:

- 迭代: 级数求和
- 递归: 递归跟踪 + 递推方程
- 猜测 + 验证

## 级数

### 算数级数

与末项平方同阶

1. $ T(n) = 1 + 2 + \cdots + n = \frac{n(n+1)}{2} = O(n^2) $

### 幂方级数

比幂次高出 **一阶**

1. $ \sum_{k=0}^{n} k^d \approx \int_{0}^{n} x^{d+1} dx = \frac{1}{d+1} x^{d+1} \lvert_0^n = \frac{1}{d+1} n^{d+1} = O(n^{d+1}) $

2. $ T_2 (n) = 1^2 + 2^2 + 3^2 + \cdots + n^2 = \frac{n(n+1)(2n+1)}{6} = O(n^3) $

3. $ T_3 (n) = 1^3 + 2^3 + 3^3 + \cdots + n^3 = \frac{n^2(n+1)^2}{4} = O(n^4) $

4. $ T_4 (n) = 1^4 + 2^4 + 3^4 + \cdots + n^4 = \frac{n(n+1)(2n+1)(3n^2+3n-1)}{30} = O(n^5) $

### 几何级数

与末项同阶

1. $ T_a (n) = a^0 + a^1 + \cdots + a^n = \frac{a^{n+1} - 1}{a-1} = O(a^n) $

2. $ 1 + 2 + 4 + \cdots + 2^n = 2^{n+1} - 1 = O(2^{n+1}) = O(2^n) $

### 收敛级数

1. $ 2 + \frac{3}{2} + \frac{4}{3} + \cdots + \frac{n}{n-1} = 1 - \frac{1}{n} = O(1) $

2. $ 1 + \frac{1}{2^2} + \cdots + \frac{1}{n^2} \lt 1 + \frac{1}{2^2} + \cdots = \frac{\pi^2}{6} = O(1) $

3. $ \frac{1}{3} + \frac{1}{7} + \frac{1}{8} + \frac{1}{15} + \frac{1}{24} + \frac{1}{26} + \frac{1}{31} + \frac{1}{35} + \cdots = 1 = O(1) $

### 调和级数

1. $ h(n) = 1 + \frac{1}{2} + \frac{1}{3} + \cdots + \frac{1}{n} = \Theta (\log n) $

### 对数级数

1. $ \log 1 + \log 2 + \log 3 + \cdots + \log n = \log (n!) = \Theta (n \log n) $

## 循环 VS 级数

### 算数级数: $ \sum_{i=0}^{n-1} n = n + n + \cdots + n = n * n = O(n^2) $

```cpp
for (int i = 0; i < n; i++) {
    for (int j = 0; j < n; j++) {
        function(i, j);
    }
}
```

![1.png](/assets/img/in-post/skill/data-structure/post-intro-algorithm-analysis/1.png)

### 算数级数: $ \sum_{i=0}^{n-1} i = 0 + 1 + \cdots + (n-1) = \frac{n(n-1)}{2} = O(n^2) $

```cpp
for (int i = 0; i < n; i++) {
    for (int j = 0; j < i; j++) {
        function(i, j);
    }
}
```

![2.png](/assets/img/in-post/skill/data-structure/post-intro-algorithm-analysis/2.png)

### 算数级数: ...

```cpp
for (int i = 0; i < n; i++) {
    for (int j = 0; j < i; j += 2013) {
        function(i, j);
    }
}
```

![3.png](/assets/img/in-post/skill/data-structure/post-intro-algorithm-analysis/3.png)

### 几何级数: $ 1 + 2 + 4 + \cdots + 2^{ \lfloor \log_2 (n-1) \rfloor } = \sum_{k=0}^{ \lfloor \log_2 (n-1) \rfloor } 2^k = 2^{ \lceil \log_2 n \rceil } = O(n) $

```cpp
for (int i = 1; i < n; i <<= 1) {
    for (int j = 0; j < i; j++) {
        function(i, j);
    }
}
```

![4.png](/assets/img/in-post/skill/data-structure/post-intro-algorithm-analysis/4.png)

### 几何级数: ...

$$
\displaylines{
  \sum_{k=0}^{n} \lceil \log_2 i \rceil
    \\
    &=& O(n \log n) \; (i = 0, 1, 2, 3~4, 5~8, 9~16, \cdots )
    \\
    &=& 0 + 0 + 1 + 2 * 2 + 3 * 4 + 4 * 8 + \cdots
    \\
    &=& \sum_{k=0 \cdots \log n} (k * 2^{k-1}) = O(\log n * 2^{\log n})
}
$$

```cpp
for (int i = 0; i <= n; i++) {
    for (int j = 1; j < i; j += j) {
        function(i, j);
    }
}
```

![5.png](/assets/img/in-post/skill/data-structure/post-intro-algorithm-analysis/5.png)

## 示例

### 取非极端元素

1. 问题

    $$
    \displaylines{
      给定整数子集 S, \lvert S \rvert = n \geq 3
      \\
      找出元素 a \in S , \  a \neq max(S) \  且 \  a \neq min(S)
    }
    $$

2. 算法

    1. 从 S 中任取三个元素 {x, y, z}

        若 S 以数组形式给出, 不妨取前三个

        由于 S 是集合, 这三个元素必 **互异**

    2. 确定并排除其中的最小、最大值

        不妨 $ 设 x = max \lbrace x, y, z \rbrace, y = min \lbrace x, y, z \rbrace $

    3. 输出剩下的元素 z

3. 总结

    无论输入规模 n 多大, 上述算法需要的执行时间都不变

    $ T(n) = C = O(1) = \Omega (1) = \Theta (1) $

