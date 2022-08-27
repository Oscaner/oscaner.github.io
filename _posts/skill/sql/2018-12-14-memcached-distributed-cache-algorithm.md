---
layout: post
title: "Memcached 分布式缓存算法"
date: 2018-12-14 20:13
author: "Oscaner"
header-img: "assets/img/post-bg-alitrip.jpg"
multilingual: false
mathjax: false
no-catalog: false
categories:
  - skill
  - sql
  - memcached
tags:
  - Skill
  - SQL
  - Memcached
---

## 前言

Memcached 虽然被称为分布式缓存服务器, 但服务端并没有集成分布式功能。

Memcached 集群主机不能互相通信传输数据, 它的分布式需要通过客户端的逻辑算法进一步实现。

## 余数分布法

多服务器分布算法中, 最容易想到的就是余数法。

根据服务器台数的余数进行分散, 求得键的整数哈希值, 再除以服务器台数, 根据其余数来选择服务器。

```php
$servers = []; // 服务器列表

add($key, $value);   // 存储键值
$hash = crc32($key); // 计算hash

$index = $hash % count($servers);   // 求余数得索引
$server = $servers[$index]; // 得到相应的服务器
```

余数分步法的缺陷: 以 8 台服务器为例, 假设 hash 值为 10, 键值应该存放在第 `10 % 8 = 2` 台服务器上。而存好以后, 其中一台 down 了, 就剩 7 台, 这时候去取 hash 为 10 的数据, 以这种算法的逻辑会到 `10 % 7 = 3` 台服务器上。很明显, 是取不到数据的, 因为数据在第 2 台服务器上。这就是余数法的缺陷。

## 一致性哈希算法

首先求出 Memcached 服务器 (节点) 的哈希值, 并将其配置到有 `0 ~ 2^32` 刻度的圆 (continuum) 上。

然后用同样的方法求出存储数据的键的哈希值, 并映射到圆上。

从数据映射到的位置开始顺时针查找, 将数据保存到找到的第一个服务器上。

如果超过 `2^32` 仍找不到服务器, 就会保存到第一台 Memcached 服务器上。

```php
<?php
class Consistent {

  protected $_mulNodes = [];

  protected $_mul = 64;

  // 生成 hash 值
  public function _hash($str) {
    return sprintf("%u", crc32($str)); // 把字符串转成 32 位无符号整数
  }

  // 查找 key 所在服务器
  public function lookup($key) {
    $point = $this->_hash($key);
    foreach ($this->_mulNodes as $key => $value) {
      if ($key > $point) {
        $node = $value; break;
      }
    }
    reset($this->_mulNodes);
    $node = $node ?? current($this->_mulNodes);
    return $node;
  }

  // 添加服务器虚拟节点
  public function addNode($node) {
    for ($i = 0; $i < $this->_mul; $i++) {
      $this->_mulNodes[$this->_hash($node . '-' . $i)] = $node;
    }
    ksort($this->_mulNodes);
  }

  // 删除服务器节点
  public function delNode($node) {
    foreach ($this->_mulNodes as $k => $v) {
      if ($v == $node) unset($this->_mulNodes[$k]);
    }
  }

  // 查看所有服务器节点
  public function printNodes() {
    print_r($this->_mulNodes);
  }
}

$con = new Consistent();
$con->addNode('a'); $con->addNode('b'); $con->addNode('c');

echo '服务器列表如下: '; $con->printNodes();

echo 'name 键的 hash 落点: '; echo $con->_hash('name') . "\n";

echo 'name 键所在服务器: '; echo $con->lookup('name') . "\n";

```

![1.png](/assets/img/in-post/skill/sql/post-memcached-distributed-cache-algorithm/1.png)

事实上, 一致性哈希算法也做不到百分百缓存命中, 只不过相对于余数分步法来说, 缓存命中率得到了极大的提升。
