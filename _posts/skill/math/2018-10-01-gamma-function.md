---
layout: post
title: "数学笔记 - 伽玛函数"
date: 2018-10-01 22:34
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

## 积分形式

$$
\begin{cases}
  \Gamma_{( x + 1 )} = \int_0^{+\infty} t^x e^{-t} dt
  \\ \\
  \Gamma_{( x )} = \int_0^{+\infty} t^{x - 1} e^{-t} dt
\end{cases}
$$

【注】

- 考研中常见 t = x^2 , 即

$$
\Gamma_{( u + 1 )} = \int_0^{+\infty} x^{2u} e^{- x^2} d_{( x^2 )} = 2 \int_0^{+\infty} x^{2u + 1} e^{- x^2} dx
$$

## 递归公式

$$
\Gamma_{( x )} = x \Gamma_{( x - 1 )}
$$

- 从而我们可以得到

$$
\Gamma_{( x )} = x!
$$

## 特殊值

$$
\Gamma_{( \frac{1}{2} )} = \sqrt{\pi}
$$

- 例子

$$
\Gamma_{( \frac{3}{2} )} = \Gamma_{( \frac{1}{2} + 1 )} = \dfrac{1}{2} \Gamma_{( \frac{1}{2}  )} = \dfrac{\sqrt{\pi}}{2}
$$

【注】在概率正态分布中经常要用到伽玛函数，应用形式基本是以上几种。
