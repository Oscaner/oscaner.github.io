---
layout: post
title: "数学笔记 - 中值定理"
date: 2018-10-01 22:16
author: "Oscaner"
header-img: "assets/img/post-bg-2015.jpg"
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

## 罗尔定理

- f(x) 在 [a,b] 内连续，在 (a,b) 内可导

$$
f_{( a )} = f_{( b )} => f_{( \xi )} = 0
$$

## 拉格朗日中值定理

- f(x) 在 [a,b] 内连续，在 (a,b) 内可导

$$
f_{( b )} - f_{( a )} = f_{( \xi )} ( b - a )
$$

## 柯西中值定理

- f(x) 在 [a,b] 内连续，在 (a,b) 内可导
- g(x) 在 [a,b] 内连续，在 (a,b) 内可导
- 分母不能为0

$$
\dfrac{f_{( b )} - f_{( a )}}{g_{( b )} - g_{( a )}} = \dfrac{f_{( \xi )}^\prime}{g_{( \xi )}^\prime}
$$

## 积分中值定理

- f(x) 在 [a,b] 内连续
- g(x) > 0

$$
\int_{a}^b f_{( x )} g_{( x )} \, dx = f_{( \xi )} \int_{a}^b g_{( x )} \, dx
$$
