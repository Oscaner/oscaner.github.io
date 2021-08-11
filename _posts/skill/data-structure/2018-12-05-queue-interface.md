---
layout: post
title: "C++ 数据结构 (四) 栈与队列 (3) 队列接口与实现"
date: 2018-12-05 15:41
author: "Oscaner"
header-img: "img/post-bg-alitrip.jpg"
multilingual: false
mathjax: true
no-catalog: false
categories:
  - skill
  - clang
  - c++
  - data structure
tags:
  - Skill
  - Clang
  - C++
  - Data Structure
---

## 操作与接口

![1.png](/img/in-post/skill/data-structure/post-queue-interface/1.png)

队列 (queue) 也是受限的序列: 先进先出 (FIFO)、后进后出 (LILO)

只能在队尾插入 (查询): `enqueue()` + `rear()`

只能在队头删除 (查询): `dequeue()` + `front()`

## 操作实例

![2.png](/img/in-post/skill/data-structure/post-queue-interface/2.png)

## 模板类

队列既然属于序列的特列，故亦可直接基于向量或列表派生

```cpp
template <typename T>
class Queue : public List<T> { // 由列表派生的队列模板类
  public: // size() 与 empty() 直接沿用
    void enqueue(T const &e) { insertAsLast(e); } // 入队
    T dequeue() { return remove(first()); } // 出队
    T & front() { return first() -> data; } // 队首
};
```

确认: 如此实现的队列接口，均只需 $ O(1) $ 时间
