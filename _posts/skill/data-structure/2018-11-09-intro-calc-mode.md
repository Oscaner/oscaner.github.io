---
layout: post
title: "C++ 数据结构 (一) 绪论 (2) 计算模型"
date: 2018-11-09 15:22
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

## 算法分析的两个主要方面

- 正确性: 算法功能与问题要求一致
    - 数学证明 ?
- 成本: 运行时间 + 存储空间
    - 如何度量 ? 如何比较 ?

### 考察

令 $ T_A (P) = 算法 A 求解问题实例 P 的计算成本 $

意义不大, 可能出现的问题实例太多

如何归纳概括 ?

### 观察

问题实例的规模, 往往是决定计算成本的主要因素

## 特定算法 + 不同实例

令 $ T_A (n) = 算法 A 求解某一问题规模为 n 的实例, 所需的计算成本  $

讨论特定算法 A (及其对应的问题) 时, 简记作 T(n)

然而, 这一定义仍有问题...

### 观察

同一问题等规模的不同实例, 计算成本不尽相同, 甚至有实质差别

`例如: 在平面上的 n 个点中, 找到所成三角形面积最小的三个点`

![1.png](/assets/img/in-post/skill/data-structure/post-intro-calc-mode/1.png)

以蛮力算法为例, 最坏情况下需枚举所有 $ C_n^3 $ 种组合, 但运气好的话一次即可

既然如此, 又该如何定义 $ T(n) $ 呢 ?

稳妥起见, 取 $ T(n) = max \\{ T(P) \  \vert \  \lvert P \rvert = n \\} $

亦即, 在同规模同为 n 的所有实例中, 只关注最坏 (成本最高) 者

## 特定问题 + 不同算法

同一问题通常有多种算法, 如何评判其优劣 ?

### 实验统计

1. 实验统计是最直接的方法, 但不足以准确反映算法的真正效率
    - 不同的算法, 可能更适应于不同 **规模** 的输入
    - 不同的算法, 可能更适应于不同 **类型** 的输入
    - 同一算法, 可能由不同 **程序员** 、用不同 **程序语言** 、经不同 **编译器** 实现
    - 同一算法, 可能实现并运行于不同的 **体系结构** 、 **操作系统** ...

2. 为给出 **客观** 的评判, 需要抽象出一个 **理想** 的平台或模型
    - 不再依赖于上述种种具体的因素, 从而直接而准确地描述、测量并评价算法

### 图灵机 (TM) 模型

![2.png](/assets/img/in-post/skill/data-structure/post-intro-calc-mode/2.png)

- Tape 依次均匀地划分为单元格, 各注有某一字符, 默认为 '#'
- Alphabet 字符的种类有限
- Head 总是对准某一单元格, 并可读取和改写其中的字符。每经过一个节拍, 可转向左侧或右侧的邻格
- State 总是处于有限种状态中的某一种。每经过一个节拍, 可 (按照规则) 转向另一种状态
- Transition Function:(q, c; d, L/R, p) 若当前状态为 q 且当前字符为 c, 则将当前字符 **改写** 为 d；**转向** 左侧/右侧的邻格；**转入** p 状态。一旦转入特定的状态 '**h**', 则 **停机**

#### 例子

功能: 将二进制非负整数加一

全 '1' 的后缀翻转为全 '0'
原最低位的 '0' 或 '#' 翻转为 '1'

```
(<, 1, 0, L, <) // 左行, 1 -> 0
(<, 0, 1, R, >) // 掉头, 0 -> 1
(<, #, 1, R, >) // ?
(>, 0, 0, R, >) // 右行
(>, #, #, L, h) // 复位
```

![3.png](/assets/img/in-post/skill/data-structure/post-intro-calc-mode/3.png)

### Random Access Machine (RAM) 模型

1. 寄存器顺序编号, 总数没有限制

    ```
    R[0], R[1], R[2], R[3], ...
    ```

2. 每一基本操作仅需常熟时间

    ```
    R[i] <- c
    R[i] <- R[j]
    IF R[i] = 0 GOTO 1
    ```

3. 与 TM 模型一样, RAM 模型也是一般计算工具的简化与抽象, 使我们可以独立于具体的平台, 对算法的效率做出可信的比较与评判

    在这些模型中, 算法的运行时间 $ \rightarrow $ 算法需要执行的基本操作次数

    $ T(n) = 算法为求解规模为 n 的问题, 所需执行的基本操作次数 $

#### 例子

功能: 向下取整的除法, $ 0 \leq c $, $ 0 < d $

![4.png](/assets/img/in-post/skill/data-structure/post-intro-calc-mode/4.png)

反复地从 $ R[0] = 1 + c $ 中减去 $ R[1] = d $

统计在下溢之前, 所做减法地次数 $ x $

```
0 R[3] <- 1           // increment
1 R[0] <- R[0] + R[3] // c++
2 R[0] <- R[0] - R[1] // c -= d
3 R[2] <- R[2] + R[3] // x++
IF R[0] > 0 GOTO 2    // if c > 0 goto 2
R[0] <- R[2] - R[3]   // else x-- and
STOP                  // return R[0] = x = (c/d) 向下取整
```

![5.png](/assets/img/in-post/skill/data-structure/post-intro-calc-mode/5.png)
