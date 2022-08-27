---
layout: post
title: "PHP - Selection Sort"
date: 2018-12-01 16:30
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

用 PHP 实现选择排序

给定：`$array = [100, 5, 25, 29, 11, 65, 33, 22, 68, 19];`

结果：`$array = [5, 11, 19, 22, 25, 29, 33, 65, 68, 100];`

## 代码实现

该算法详解请看: [《C++ 数据结构 (三) 列表 (3) 选择排序》]({% link _posts/skill/data-structure/2018-12-01-list-selection-sort.md %}){:target="_blank"}

```php
<?php

function selectionSort(array &$A, int $lo, int $hi) {
  while (++$lo <= $hi) { // 共 $hi - $lo 个元素
    $i = $max = $lo - 1; // 初始化

    // 遍历 [$lo, $hi) 找到最大值
    // 基于算法稳定性考虑，多个相同最大值则选择下标最大者
    while (++$i <= $hi) if ($A[$i - 1] >= $A[$max]) $max = $i - 1;

    array_unshift($A, $A[$max]); // 将最大值从头插入数组

    // 删除原最大值并索引重排，[$new, $lo, ..., $max, ..., $hi)
    array_splice($A, $max + 1, 1);
  }
}

$A = [100, 5, 25, 29, 11, 65, 33, 22, 68, 19];

selectionSort($A, 0, count($A));

print_r($A);
```

![1.png](/assets/img/in-post/skill/coding/post-php-selection-sort/1.png)
