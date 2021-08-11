---
layout: post
title: "数学笔记 - 泰勒公式"
subtitle: "考研中的泰勒公式"
date: 2018-09-14 23:54
author: "Oscaner"
header-img: "img/post-bg-2015.jpg"
mathjax: true
catalog: true
categories:
  - skill
  - math
tags:
  - Skill
  - Math
  - Graduate
---

## 公式


$$
f_{( x )} = f_{( x_0 )} + f^\prime_{( x_0 )} ( x - x_0 ) + \dfrac{f^{\prime \prime}_{( x_0 )}}{2!} ( x - x_0 )^2 + \dots + \dfrac{f_{( x_0 )}^{( n )}}{n!} ( x - x_0 )^n + R_n ( x )
$$

- 标准公式 — 主要用于计算级数

$$
f_{( x )} = \sum_{n = 0}^{\infty} \dfrac{f^{( n )}_{( x_0 )}}{n!} ( x - x_0 )^n
$$

- 带余项的公式 — 主要用于证明题和计算n阶导数

$$
f_{( x )} = \sum_{k = 0}^{n} \dfrac{f_{( x_0 )}^{( k )}}{k!} ( x - x_0 )^k + R_n ( x )
$$

## Rn(x)余项

- 拉氏余项 — 主要用于证明题

$$
R_n ( x ) = \dfrac{f^{( n + 1 )}_{( \xi )}}{( n + 1 )!} ( x - x_0 )^{n + 1}
$$

- 佩氏余项 — 主要用于极限计算题

$$
R_n ( x ) = \mathrm{o} [ ( x - x_0 )^n ]
$$
