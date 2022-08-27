---
layout: post
title: "C++ 数据结构 (一) 绪论 (1) 计算"
date: 2018-11-09 14:25
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

讲义下载: [《清华大学数据结构讲义》](https://pan.baidu.com/s/1Sk6_EC6LUUFaVSy4Idpzrg){:target="_blank"}{:rel="nofollow"}

## 引例

- 计算对象: 规律、技巧
- 计算目标: 高效、低耗

### 绳索计算机及其算法

- 输入: 任给直线 l 及其上一点 A
- 输出: 经过 A 做 l 的一条垂线

#### 算法

取 12 段等长的绳索, 首尾联接成环

从 A 点起, 将 4 段绳索沿 l 伸直并固定于 B

沿另一个方向找到第 3 段绳索的终点 C

移动点 C, 将剩余的 3 + 5 段绳索伸直

![1.png](/assets/img/in-post/skill/data-structure/post-intro-calc/1.png)

#### 总结

这里的计算机就是上述可以重复机械做出垂线的一个过程工具

### 尺规计算机及其算法

- 任给平面上线段 AB (输入), 将其三等分 (输出)

#### 算法

从 A 发出一条与 AB 不重合的射线 $ \rho $

在 $ \rho $ 上取 $ AC' = C'D' = D'B' $

联接 $ B'B $

经 $ D' $ 做 $ B'B $ 的平行线, 交 $ AB $ 于 $ D $

经 $ C' $ 做 $ B'B $ 的平行线, 交 $ AB $ 于 $ C $

![2.png](/assets/img/in-post/skill/data-structure/post-intro-calc/2.png)

#### 总结

这里的计算机就是上述用于重复机械做出三等分的尺规工具

其中还包括了一个子程序: 过直线外一点, 做平行线

## 算法

1. 计算 = 信息处理

    计算就是, 借助某种工具, 遵照一定规则, 以明确而机械的形式进行

2. 计算模型 = 计算机 = 信息处理工具

    所谓算法, 即在特定计算模型下, 用于解决特定问题的指令序列

- 输入: 待处理的信息 (问题)
- 输出: 经处理的信息 (答案)
- 正确性: 的确可以解决指定的问题
- 确定性: 任一算法都是可以描述为一个由基本操作组成的序列
- 可行性: 每一基本操作都是可实现, 且在常数时间内完成
- 有穷性: 对于任何输入, 经有穷次基本操作, 都可以得到输出

### 算法的有穷性

$$
序列 Hailstone ( n ) =

\begin{cases}

  { 1 } & , n \leqslant 1

  \\

  { n } \cup Hailstone ( \frac{n}{2} ) & , n 偶

  \\

  { n } \cup Hailstone ( 3n + 1 ) & , n 奇

  \\

\end{cases}
$$

1. `Hailstone (42) = { 42, 21, 64, 32, ..., 1 }`

    ```cpp
    // 计算序列 Hailstone(n) 的长度
    int hailstone(int n) {
      // 从 1 开始, 以下按定义逐步递推, 并累计步数, 直至 n = 1
      int length = 1;
      while (1 < n) {
        (n % 2) ? (n = 3 * n + 1) : (n = n / 2);
        length++;
      }
      // 返回 |Hailstone(n)|
      return length;
    }
    ```

2. 对于任意的 `n`, 是否总有 `| Hailstone(n) | < ∞` ?

### 好算法

- 正确: 符合语法, 能够编译、链接

    - 能够正确处理 **简单的** 输入
    - 能够正确处理 **大规模的** 输入
    - 能够正确处理 **一般性的** 输入
    - 能够正确处理 **退化的** 输入
    - 能够正确处理 **任意合法的** 输入

- 健壮: 能辨别不合法的输入并做适当处理, 而不致非正常退出
- 可读: 结构化 + 准确命名 + 注释 + ...
- 效率: 速度尽可能快, 存储空间尽可能少
