---
layout: post
title: "PHP - Bubble Sort"
date: 2018-11-19 15:59
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

用 PHP 实现起泡排序

给定：`$array = [100, 5, 25, 29, 11, 65, 33, 22, 68, 19];`

结果：`$array = [5, 11, 19, 22, 25, 29, 33, 65, 68, 100];`

## 代码实现

该算法详解请看：[《C++ 数据结构 (二) 向量 (7) 起泡排序》]({% link _posts/skill/data-structure/2018-11-27-vector-bubble-sort.md %}){:target="_blank"}

```php
<?php
function bubble(array &$A, int $lo, int $hi) {
  $last = $lo; // 记录最后一组逆序对位置

  while (++$lo < $hi) { // 遍历 [$lo, $hi) 内所有元素

    if ($A[$lo - 1] > $A[$lo]) { // 若逆序

      $last = $lo; // 记录逆序对位置

      // 交换位置
      $temp = $A[$lo - 1];
      $A[$lo - 1] = $A[$lo];
      $A[$lo] = $temp;

    }

  }

  // 返回最后一组逆序对位置，[$lo, $last) 不一定有序，[$last, $hi) 必然有序
  return $last;
}

function bubbleSort(array &$A, int $lo, int $hi) {
    // 将 $last 赋值给 $hi，则接下来只排序 [$lo, $last) 内的元素
    while ($lo < ($hi = bubble($A, $lo, $hi)));
}

$A = [100, 5, 25, 29, 11, 65, 33, 22, 68, 19];

bubbleSort($A, 0, count($A));

for ($i = 0; $i < count($A); $i++) {
  echo "{$A[$i]} ";
}
```

![1.png](/assets/img/in-post/skill/coding/post-php-bubble-sort/1.png)
