---
layout:     post
title:      "考研数学笔记 - 积分公式"
subtitle:   "考研常用的一些积分公式"
date:       2018-09-17 23:00:00
author:     "Oscaner"
header-img: "img/post-bg-2015.jpg"
mathjax: true
no-catalog: true
categories:
  - life
  - math
tags:
  - Life
  - Math
  - Graduate
---

$$
\begin{align*}

  \int x^k dx &= \dfrac{1}{k + 1} x^{k + 1} + C

  \\

  \int \dfrac{1}{x} dx &= \ln \left| x \right| + C

  \\

  \int a^x dx &= \dfrac{1}{\ln a} a^x + C \; \left( a > 0 且 a \neq 1 \right)

  \\

  \int e^x dx &= e^x + C

\end{align*}
$$

---

$$
\begin{align*}

  \int \sin x dx &= -\cos x + C

  \\

  \int \cos x dx &= \sin x + C

  \\

  \int \tan x dx &= -\ln \left| \cos x \right| + C

  \\

  \int \cot x dx &= \ln \left| \sin x \right| + C

  \\

  \int \sec x dx &= \ln \left| \sec x + \tan x \right| + C

  \\

  \int \csc x dx &= \ln \left| \csc x - \cot x \right| + C

\end{align*}
$$

---

$$
\begin{align*}

  \int \sec^2 x dx &= \tan x + C

  \\

  \int \csc^2 x dx &= -\cot x + C

  \\

  \int \sec x \tan x dx &= \int \dfrac{\sin x}{\cos^2 x} dx = \sec x + C

  \\

  \int \csc x \cot x dx &= \int \dfrac{\cos x}{\sin^2 x} = -\csc x + C

\end{align*}
$$

---

$$
\begin{align*}

  \int \dfrac{1}{\sqrt{1 - x^2}} dx &= \arcsin x + C

  \\

  \int \dfrac{1}{\sqrt{a^2 - x^2}} dx &= \arcsin \dfrac{x}{a} + C

  \\

  \int \dfrac{1}{\sqrt{x^2 + a^2}} dx &= \ln \left| x + \sqrt{x^2 + a^2} \right| + C

  \\

  \int \dfrac{1}{\sqrt{x^2 - a^2}} dx &= \ln \left| x + \sqrt{x^2 - a^2} \right| + C

\end{align*}
$$

---

$$
\begin{align*}

  \int \dfrac{1}{1 + x^2} dx &= \arctan x + C

  \\

  \int \dfrac{1}{a^2 + x^2} dx &= \dfrac{1}{a} \arctan \dfrac{x}{a} + C

\end{align*}
$$

---

$$
\begin{align*}

  \int \dfrac{1}{a^2 - x^2} dx &= \dfrac{1}{2a} \ln \left| \dfrac{a + x}{a - x} \right| + C

  \\

  \int \dfrac{1}{x^2 - a^2} dx &= \dfrac{1}{2a} \ln \left| \dfrac{x - a}{x + a} \right| + C

\end{align*}
$$

---

$$
\int \sqrt{a^2 - x^2} dx = \dfrac{a^2}{2} \arcsin \dfrac{x}{a} + \dfrac{x}{2} \sqrt{a^2 - x^2} + C
$$

---

$$
\begin{cases}

  I_n = \int_0^{\frac{\pi}{2}} \sin^n x dx = \int_0^{\frac{\pi}{2}} \cos^n x dx

  \\

  I_n = \frac{n - 1}{n} I_{n - 2}

  \\

  I_0 = \dfrac{\pi}{2} \; , \; I_1 = 1

\end{cases}
$$
