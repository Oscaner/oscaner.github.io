---
layout: post
title: "数学笔记 - 积分公式"
subtitle: "考研常用的一些积分公式"
date: 2018-09-17 23:00
author: "Oscaner"
header-img: "img/post-bg-2015.jpg"
mathjax: true
no-catalog: false
categories:
  - skill
  - math
tags:
  - Skill
  - Math
  - Graduate
---

## 基本积分公式

$$
\begin{align*}

  & \int x^k dx = \dfrac{1}{k + 1} x^{k + 1} + C

  \\

  & \int \dfrac{1}{x} dx = \ln \lvert x \rvert + C

  \\

  & \int a^x dx = \dfrac{1}{\ln a} a^x + C \; ( a > 0 且 a \neq 1 )

  \\

  & \int e^x dx = e^x + C

  \\
  \\

  & \int \sin x dx = -\cos x + C

  \\

  & \int \cos x dx = \sin x + C

  \\

  & \int \tan x dx = -\ln \lvert \cos x \rvert + C

  \\

  & \int \cot x dx = \ln \lvert \sin x \rvert + C

  \\

  & \int \sec x dx = \ln \lvert \sec x + \tan x \rvert + C

  \\

  & \int \csc x dx = \ln \lvert \csc x - \cot x \rvert + C

  \\
  \\

  & \int \sec^2 x dx = \tan x + C

  \\

  & \int \csc^2 x dx = -\cot x + C

  \\

  & \int \sec x \tan x dx = \int \dfrac{\sin x}{\cos^2 x} dx = \sec x + C

  \\

  & \int \csc x \cot x dx = \int \dfrac{\cos x}{\sin^2 x} = -\csc x + C

  \\
  \\

  & \int \dfrac{1}{\sqrt{1 - x^2}} dx = \arcsin x + C

  \\

  & \int \dfrac{1}{\sqrt{a^2 - x^2}} dx = \arcsin \dfrac{x}{a} + C

  \\

  & \int \dfrac{1}{\sqrt{x^2 + a^2}} dx = \ln \lvert x + \sqrt{x^2 + a^2} \rvert + C

  \\

  & \int \dfrac{1}{\sqrt{x^2 - a^2}} dx = \ln \lvert x + \sqrt{x^2 - a^2} \rvert + C

  \\
  \\

  & \int \dfrac{1}{1 + x^2} dx = \arctan x + C

  \\

  & \int \dfrac{1}{a^2 + x^2} dx = \dfrac{1}{a} \arctan \dfrac{x}{a} + C

  \\
  \\

  & \int \dfrac{1}{a^2 - x^2} dx = \dfrac{1}{2a} \ln \lvert \dfrac{a + x}{a - x} \rvert + C

  \\

  & \int \dfrac{1}{x^2 - a^2} dx = \dfrac{1}{2a} \ln \lvert \dfrac{x - a}{x + a} \rvert + C

  \\
  \\

  & \int \sqrt{a^2 - x^2} dx = \dfrac{a^2}{2} \arcsin \dfrac{x}{a} + \dfrac{x}{2} \sqrt{a^2 - x^2} + C

  \\
  \\

  & \begin{cases}

    I_n = \int_0^{\frac{\pi}{2}} \sin^n x dx = \int_0^{\frac{\pi}{2}} \cos^n x dx

    \\

    I_n = \frac{n - 1}{n} I_{n - 2}

    \\

    I_0 = \dfrac{\pi}{2} \; , \; I_1 = 1

  & \end{cases}

\end{align*}
$$

## 积分应用

### 长度公式

![IMG_20180918_230857.jpg](/img/in-post/skill/math/post-integral-formula/IMG_20180918_230857.jpg)

#### Rt坐标系

$$
\begin{cases}

  dl = \sqrt{( dx )^2 + ( dy )^2} = \sqrt{1 + ( y^\prime )^2} dx

  \\
  \\

  s = \int_a^b dl = \int_a^b \sqrt{1 + ( y^\prime )^2} dx

\end{cases}
$$

#### 极坐标系

$$
\begin{cases}

  dl = \sqrt{( r d\theta )^2 + ( dr )^2} = \sqrt{r^2 + ( r^\prime )^2} d\theta

  \\
  \\

  s = \int_{\alpha}^{\beta} dl = \int_{\alpha}^{\beta} \sqrt{r^2 + ( r^\prime )^2} d\theta

\end{cases}
$$

### 面积公式

![IMG_20180918_234741.jpg](/img/in-post/skill/math/post-integral-formula/IMG_20180918_234741.jpg)

#### Rt坐标系

- 不旋转

  略

- 绕y轴旋转

  少见，原理同绕x轴旋转一致，视具体情况自推

- 绕x轴旋转

$$
\begin{cases}

  ds = 2 \pi \lvert y \rvert \sqrt{( dx )^2 + ( dy )^2} = 2 \pi \lvert y \rvert \sqrt{1 + ( y^\prime )^2} dx

  \\
  \\

  s = \int_a^b ds = \int_a^b 2 \pi \lvert y \rvert \sqrt{1 + ( y\prime )^2} dx

\end{cases}
$$

#### 极坐标系

$$
\begin{cases}

  ds = \pi r_2^2 * \dfrac{d\theta}{2 \pi} - \pi r_1^2 * \dfrac{d\theta}{2 \pi} = \dfrac{1}{2} ( r_2^2 - r_1^2 ) d\theta

  \\
  \\

  s = \int_{\alpha}^{\beta} ds = \int_{\alpha}^{\beta} \dfrac{1}{2} ( r_2^2 - r_1^2 ) d\theta

\end{cases}
$$

### 体积公式

![IMG_20180920_232536.jpg](/img/in-post/skill/math/post-integral-formula/IMG_20180920_232536.jpg)

#### Rt坐标系

- 绕x轴旋转

$$
\begin{cases}

  dV = \pi y^2 dx

  \\
  \\

  V = \int_a^b dV = \int_a^b \pi y^2 dx

\end{cases}
$$

- 绕y轴旋转

$$
\begin{cases}

  dV = 2 \pi \lvert x \rvert \lvert y \rvert dx

  \\
  \\

  V = \int_a^b dV = \int_a^b 2 \pi \lvert x \rvert \lvert y \rvert dx

\end{cases}
$$

>【注】
>
> 在绕x轴旋转的时候，计算体积时宽用的是 `dx`，而计算长度和面积时宽用的是 `√[1+（y')^2] dx`.
>
> 虽然 `dx` 和 `√[1+（y')^2] dx` 这两者之间的差距微乎其微，
>
> 但是在计算长度和面积的时候，这一点点的长度差是不能忽视的。
>
> 而在计算体积的时候，相对体积来说，`dx` 和 `√[1+（y')^2] dx` 的长度差可以忽略不计。


### 其他公式

#### Rt坐标和极坐标之间的转换

$$
\begin{cases}

  x = r \cos \theta

  \\
  \\

  y = r \sin \theta

\end{cases}
$$

#### 椭圆弧的重心坐标公式

均匀密度情况下，重心和形心重合

$$
\begin{cases}

  x^\prime = \dfrac{\iint_D x d \sigma}{\iint_D d \sigma}

  \\
  \\

  y^\prime = \dfrac{\iint_D y d \sigma}{\iint_D d \sigma}

\end{cases}
$$

<center>( 其中 D 为椭圆弧的左右上下限与椭圆弧所围成的区域 )</center>
