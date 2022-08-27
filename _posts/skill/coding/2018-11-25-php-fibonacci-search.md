---
layout: post
title: "PHP - Fibonacci Search"
date: 2018-11-25 16:33
author: "Oscaner"
header-img: "assets/img/post-bg-alitrip.jpg"
multilingual: false
mathjax: true
no-catalog: false
categories:
  - skill
  - coding
  - php
  - fibonacci
tags:
  - Skill
  - Coding
  - PHP
  - Fibonacci
---

## 问题描述

用 PHP 编写斐波那契查找

要求: 查询失败返回 `-1`; 查询成功返回下标

给定: `$A = [1, 3, 5, 8, 13, 19, 20, 31, 43, 50];`

查询 `8`，结果返回: `3`

## 代码实现

该算法详解请看: [《C++ 数据结构 (二) 向量 (6) 斐波那契查找》]({% link _posts/skill/data-structure/2018-11-25-vector-fibonacci-search.md %}){:target="_blank"}

```php
<?php
function fib($k) {
  $f = 0; $g = 1;
  while (0 < $k--) {
    $g = $g + $f;
    $f = $g - $f;
  }
  return $f;
}

function fibSearch(array $A, int $e, int $lo, int $hi, array $fibArr) {
  $k = $hi - $lo;

  while ($lo < $hi) {
    while ($hi - $lo < $fibArr[$k--]); // $fibArr[$k] < $hi - $lo < $fibArr[$k + 1]
    $mi = $lo + $fibArr[$k] - 1;
    if ($e < $A[$mi]) $hi = $mi;          // 左区间 [$lo, $mi)
    else if ($A[$mi] < $e) $lo = $mi + 1; // 右区间 ($mi, $lo)
    else return $mi;                      // 匹配
  }

  return -1;
}

$A = [1, 3, 5, 8, 13, 19, 20, 31, 43, 50];

$fibArr = array();

for ($i = 0; $i <= count($A); $i++) $fibArr[$i] = fib($i);

if ($argc > 1) echo fibSearch($A, $argv[1], 0, count($A), $fibArr) . "\n";

else echo fibSearch($A, 8, 0, count($A), $fibArr) . "\n";
```

![1.png](/assets/img/in-post/skill/coding/post-php-fibonacci-search/1.png)
