---
layout: post
title: "PHP - Search Two Max"
date: 2018-11-21 14:48
author: "Oscaner"
header-img: "assets/img/post-bg-alitrip.jpg"
multilingual: false
mathjax: true
no-catalog: false
categories:
  - skill
  - coding
  - php
tags:
  - Skill
  - Coding
  - PHP
---

## 问题描述

找出数组中最大的两个数的下标, 用 `x1`、`x2` 存储, 且 `A[x1] >= A[x2]`

要求: 递归算法

给定: `$A = [10, 30, 400, 50, 10, 1000, 200, 60, 20, 10];`

结果:

```
A[x1] = A[5] = 1000
A[x2] = A[2] = 400
```

## 代码实现


该算法详解请看: [《C语言数据结构 (一) 绪论 (5) 迭代与递归 (3)》]({% link _posts/skill/data-structure/2018-11-20-intro-recursion-iteration-3.md %}){:target="_blank"}

```php
<?php

function swap(int &$x1, int &$x2) {
    $temp = $x1;
    $x1 = $x2;
    $x2 = $temp;
}

function max2(array $A, int $lo, int $hi, int &$x1, int &$x2) {
  // $A[$lo, $hi) 中仅有两个元素
  if ($lo + 2 == $hi) {
    if ($A[$x1 = $lo] < $A[$x2 = $lo + 1]) swap($x1, $x2);
    return;
  }

  // $A[$lo, $hi) 中有三个元素
  if ($lo + 3 == $hi) {
    if ($A[$x1 = $lo] < $A[$x2 = $lo + 1]) swap($x1, $x2);
    if ($A[$x2] < $A[$lo + 2]) $x2 = $lo + 2;
    if ($A[$x1] < $A[$x2]) swap($x1, $x2);
    return;
  }

  $mi = ($lo + $hi) / 2;

  // 找出左半边的 two max
  $x1L = 0; $x2L = 0;
  max2($A, $lo, $mi, $x1L, $x2L);

  // 找出右半边的 two max
  $x1R = 0; $x2R = 0;
  max2($A, $mi, $hi, $x1R, $x2R);

  // 判断左右两边的 two max
  if ($A[$x1L] > $A[$x1R]) {
    // 左边最大值 > 右边最大值
    $x1 = $x1L;

    // 判断 左边第二大值 与 右边最大值
    // 右边第二大值必然是四个值里最小的, 无需参与比较
    $x2 = ($A[$x2L] > $A[$x1R]) ? $x2L : $x1R;
  } else {
      // 右边最大值 >= 左边最大值
      $x1 = $x1R;

      // 判断 右边第二大值 与 左边最大值
      $x2 = ($A[$x2R] > $A[$x1L]) ? $x2R : $x1L;
  }
}

$A = [10, 30, 400, 50, 10, 1000, 200, 60, 20, 10];

$x1 = 0; $x2 = 0;

max2($A, 0, count($A), $x1, $x2);

echo 'A[x1] = ' . 'A[' . $x1 . '] = ' . $A[$x1] . "\n" .
     'A[x2] = ' . 'A[' . $x2 . '] = ' . $A[$x2] . "\n";
```

![1.png](/assets/img/in-post/skill/coding/post-php-two-max/1.png)
