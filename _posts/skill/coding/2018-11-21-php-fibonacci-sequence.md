---
layout: post
title: "PHP - Fibonacci Sequence"
date: 2018-11-21 16:25
author: "Oscaner"
header-img: "img/post-bg-alitrip.jpg"
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

请编写斐波那契数列算法

输入：`5`

输出：

```
0 => 0
1 => 1
2 => 1
3 => 2
4 => 3
5 => 5
```

## 代码实现

该算法详解请看: [《C语言数据结构 (一) 绪论 (6) 动态规划 (1)》]({% link _posts/skill/data-structure/2018-11-21-intro-dynamic-programming-1.md %}){:target="_blank"}

```php
<?php

function fib(int $n) {
  $f = 0; $g = 1;
  while(0 < $n--) {
    $g = $g + $f;
    $f = $g - $f;
  }
  return $f;
}

if ($argc > 1) {
  for ($i = 0; $i <= $argv[1]; $i++) {
    echo $i . "\t=> " . fib($i) . "\n";
  }
}
```

![1.png](/img/in-post/skill/coding/post-php-fibonacci-sequence/1.png)
