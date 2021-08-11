---
layout: post
title: "PHP - Merge Sort"
date: 2018-11-28 14:20
author: "Oscaner"
header-img: "img/post-bg-alitrip.jpg"
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

用 PHP 实现归并排序

给定: `$array = [100, 5, 25, 29, 11, 65, 33, 22, 68, 19];`

结果: `$array = [5, 11, 19, 22, 25, 29, 33, 65, 68, 100];`

## 代码实现

该算法详解请看: [《C++ 数据结构 (二) 向量 (8) 归并排序》]({% link _posts/skill/data-structure/2018-11-27-vector-merge-sort.md %}){:target="_blank"}

```php
<?php

function mergeSort(array &$A, int $lo, int $hi) {
  if ($hi - $lo < 2) return; // 单区间自然有序
  $mi = ($lo + $hi) >> 1; // 取中
  mergeSort($A, $lo, $mi); // 深入左区间 [$lo, $mi)
  mergeSort($A, $mi, $hi); // 深入右区间 [$mi, $hi)
  merge($A, $lo, $mi, $hi); // 二路归并
}

function merge(array &$A, int $lo, int $mi, int $hi) {
  $l_len = $mi - $lo; // 左区间长度
  // 取出左区间元素
  $B = array();
  for ($i = 0; $i < $l_len; $i++) $B[$i] = $A[$lo + $i];

  $r_len = $hi - $mi; // 右区间长度

  for ($i = 0, $l = 0, $r = 0; ($l < $l_len) || ($r < $r_len);) {
    // (左区间未越界) and
    // ((右区间越界，即左区间元素有剩余，右区间已取完) or (左区间元素 <= 右区间元素, 此时右区间未越界))
    if ($l < $l_len && ($r >= $r_len || $B[$l] <= $A[$mi + $r])) {
      $A[$lo + $i] = $B[$l];
      $i++; $l++;
    }

    // (右区间未越界) and
    // ((左区间越界，即右区间元素有剩余，左区间已取完) or (右区间元素 <= 左区间元素, 此时左区间未越界))
    if ($r < $r_len && ($l >= $l_len || $A[$mi + $r] <= $B[$l])) {
      $A[$lo + $i] = $A[$mi + $r];
      $i++; $r++;
    }
  }

  unset($B);
}

$A = [100, 5, 25, 29, 11, 65, 33, 22, 68, 19];

mergeSort($A, 0, count($A));

for ($i = 0; $i < count($A); $i++) echo $A[$i] . ' ';
```

![1.png](/img/in-post/skill/coding/post-php-merge-sort/1.png)
