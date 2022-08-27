---
layout: post
title: "PHP - Foreach Object"
date: 2018-10-21 10:19
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

## 题目描述

使对象可以像数组一样进行 `foreach` 循环

要求属性必须是私有属性

## 代码实现

```php
<?php

/**
 * Class Test.
 */
class Test implements Iterator {

  /**
   * @var array
   */
  private $array;

  /**
   * 构造器
   * @param array $array 初始化数组
   */
  public function __construct($array = []) {
    $this->array = $array;
  }

  /**
   * 重置指针
   */
  public function rewind() {
    reset($this->array);
  }

  /**
   * 验证
   */
  public function valid() {
    return ($this->current() !== false);
  }

  /**
   * 获取当前 value
   */
  public function current() {
    return current($this->array);
  }

  /**
   * 获取当前 key
   */
  public function key() {
    return key($this->array);
  }

  /**
   * 指针下移
   */
  public function next() {
    return next($this->array);
  }

}

// 测试
$array = new Test(['one', 'two', 'three', 'my' => 'Oscaner']);

foreach ($array as $k => $v) {
  echo "{$k} => {$v}\n";
}
```

![1.png](/assets/img/in-post/skill/coding/post-php-foreach-object/1.png)
