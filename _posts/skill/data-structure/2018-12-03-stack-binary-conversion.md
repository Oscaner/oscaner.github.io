---
layout: post
title: "C++ 数据结构 (四) 栈与队列 (2) 栈应用 (1) 进制转换"
date: 2018-12-03 12:05
author: "Oscaner"
header-img: "assets/img/post-bg-alitrip.jpg"
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

## 典型应用场合

1. 逆序输出 (conversion)

    输出次序与处理过程颠倒, 递归深度和输出长度不易预知

2. 递归嵌套 (stack permutation + parenthesis)

    具有自相似性的问题可递归描述, 但分支位置和嵌套深度不固定

3. 延迟缓冲 (evaluation)

    线性扫描算法模式中, 在预读足够长之后, 方能确定可处理的前缀

4. 栈式计算 (RPN)

    基于栈结构的特定计算模式

## 进制转换

![1.png](/assets/img/in-post/skill/data-structure/post-stack-binary-conversion/1.png)

```cpp
void convert(Stack<char> &S, __int64 n, int base) {
  // 新进制下的数位符号, 可视 base 取值范围适当扩充
  static char digit[] = {'0', '1', '2', '3',
                          '4', '5', '6', '7',
                          '8', '9', 'A', 'B',
                          'C', 'D', 'E', 'F'};
  while (n > 0) { // 由低到高, 逐一计算出新进制下的各位数
    S.push(digit[n % base]); // 余数 (对应的数位) 入栈
    n /= base; // n 更新为其对 base 的除商
  }
}

main() {
  Stack<char> S; convert(S, n, base); // 用栈记录转换得到的各数位
  while (!S.empty()) printf("%c", S.pop()); // 逆序输出
}
```
