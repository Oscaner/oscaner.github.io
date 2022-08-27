---
layout: post
title: "PHP - Binary Conversion"
date: 2018-12-03 15:20
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

用 PHP 实现进制转换

输入: 十进制数

输出: 根据自定义进制（1 < 进制 <= 16）输出相应结果

## 代码实现

该算法详解请看: [C++ 数据结构 (四) 栈与队列 (2) 栈应用 (1) 进制转换]({% link _posts/skill/data-structure/2018-12-03-stack-binary-conversion.md %}){:target="_blank"}

```php
<?php

function convert(int $n, int $base) {
  $digit = ['0', '1', '2', '3',
            '4', '5', '6', '7',
            '8', '9', 'A', 'B',
            'C', 'D', 'E', 'F'];

  $res = '';

  while ($n > 0) {
    $res = $digit[$n % $base] . $res;
    $n = floor($n / $base);
  }

  return $res;
}

if ($argc > 2) echo convert($argv[1], $argv[2]) . "\n";

else if ($argc == 1) echo convert($argv[1], 10) . "\n";

else echo '请输入待操作数';
```

![1.png](/assets/img/in-post/skill/coding/post-php-binary-conversion/1.png)
