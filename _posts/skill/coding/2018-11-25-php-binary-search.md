---
layout: post
title: "PHP - Binary Search"
date: 2018-11-25 14:54
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

用 PHP 实现二分查找

要求: 返回不大于所查询元素的最后一个元素的下标

给定: `$A = [1, 3, 5, 8, 13, 19, 20, 31, 43, 50];`

查询 `8`，结果返回: `3`
查询 `0`，结果返回: `-1`
查询 `100`，结果返回: `9`

## 代码实现

该算法详解请看: [《C++ 数据结构（二）向量（5）二分查找》]({% link _posts/skill/data-structure/2018-11-27-vector-bubble-sort.md %}){:target="_blank"}

```php
<?php
function binSearch(array $A, int $e, int $lo, int $hi) {
  while ($lo < $hi) {
      $mi = ($lo + $hi) >> 1; // 折半
      ($e < $A[$mi]) ? $hi = $mi : $lo = $mi + 1; // [$lo, $mi) or ($mi, $hi)
  }

  return --$lo;
}

$A = [1, 3, 5, 8, 13, 19, 20, 31, 43, 50];

if ($argc > 1) echo binSearch($A, $argv[1], 0, count($A)) . "\n";
```

![1.png](/assets/img/in-post/skill/coding/post-php-binary-search/1.png)
