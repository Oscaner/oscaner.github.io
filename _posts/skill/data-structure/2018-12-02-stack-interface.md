---
layout: post
title: "C++ 数据结构 (四) 栈与队列 (1) 栈接口与实现"
date: 2018-12-02 14:09
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

![1.png](/assets/img/in-post/skill/data-structure/post-stack-interface/1.png)

## 操作实例

LIFO: Last In First Out

![2.png](/assets/img/in-post/skill/data-structure/post-stack-interface/2.png)

## 实现

栈既然属于序列的特例，故可直接基于向量或列表派生

```cpp
template <typename T>
class Stack : public Vector<T> { // 由向量派生
  public: // size()、empty() 以及其他开放接口均可直接沿用
    void push(T const &e) { insert(size(), e); } // 入栈
    T pop() { return remove(size() - 1); } // 出栈
    T &top() { return (*this)[size() - 1]; } // 取顶
}; // 以向量 首/末 端为栈 底/顶
```
