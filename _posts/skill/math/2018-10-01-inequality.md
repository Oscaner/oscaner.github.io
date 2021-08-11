---
layout: post
title: "数学笔记 - 不等式"
date: 2018-10-01 21:14
author: "Oscaner"
header-img: "img/post-bg-2015.jpg"
multilingual: false
mathjax: true
catalog: true
categories:
  - skill
  - math
  - graduate
tags:
  - Skill
  - Math
  - Graduate
---

## 柯西不等式

### 普通形式

- 简记：平方和的乘积 ≥ 乘积和的平方

$$
( a_1^2 + a_2^2 + \cdots + a_n^2 ) ( b_1^2 + b_2^2 + \cdots + b_n^2 ) \geqslant ( a_1 b_1 + a_2 b_2 + \cdots + a_n b_n )^2
$$

$$
\sum_{i = 1}^n a_i^2 \sum_{i = 1}^n b_i^2 \geqslant ( \sum_{i = 1}^n a_i b_i )^2
$$

### 积分形式

- 又称作 `施瓦茨不等式`
- 定积分从某种意义上来说，是更高级的求和（或者称之为面积求和）
- 明显与柯西不等式的形式相似
- 简记：平方和的乘积 ≥ 乘积和的平方

$$
\int_{a}^b f_{( x )}^2 \, dx \int_{a}^b g_{( x )}^2 \, dx \geqslant ( \int_{a}^b f_{( x )} g_{( x )} \, dx )^2
$$

## 杨不等式

### 普通形式

$$
\begin{cases}

  \dfrac{1}{p} + \dfrac{1}{q} = 1

  \\
  \\

  p > 0, q > 0

\end{cases}

=> a^{\frac{1}{p}} b^{\frac{1}{q}} \leqslant \dfrac{a}{p} + \dfrac{b}{q}

$$

### 积分形式

$$
\begin{cases}

  a > 0, b > 0

  \\

  x = \phi_{( y )}, y = \varphi_{( x )}

  \\

  \varphi_{( 0 )} = 0

  \\

  y 在 [ 0, a ] 上单调递增

\end{cases}

=> \int_0^a \varphi_{( x )} \, dx + \int_0^b \phi_{( y )} \, dy \geqslant ab
$$
