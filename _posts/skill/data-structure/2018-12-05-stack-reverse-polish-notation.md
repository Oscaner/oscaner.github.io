---
layout: post
title: "C++ 数据结构 (四) 栈与队列 (2) 栈应用 (4) 逆波兰表达式"
date: 2018-12-05 14:14
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

## RPN

逆波兰表达式 (Reverse Polish Notation), 又称后缀表达式

J.Lukasiewicz (12/21/1878 - 02/13/1956)

例如: `0! + 123 + 4 * ( 5 * 6! + 7! / 8 ) / 9` => `0 ! 123 + 4 5 6 ! * 7 ! 8 / + * 9 /`

在由运算符 (operator) 和操作数 (operand) 组成的表达式中不使用括号 (parenthesis-free), 即可表达带优先级的运算关系

![1.png](/assets/img/in-post/skill/data-structure/post-stack-reverse-polish-notation/1.png)

![2.png](/assets/img/in-post/skill/data-structure/post-stack-reverse-polish-notation/2.png)

![3.png](/assets/img/in-post/skill/data-structure/post-stack-reverse-polish-notation/3.png)

## 体验

![4.png](/assets/img/in-post/skill/data-structure/post-stack-reverse-polish-notation/4.png)

## infix 到 postfix: 手工转换

例如: `( 0 ! + 1 ) ^ ( 2 * 3 ! + 4 - 5 )`

假设: 事先未就运算符之间的优先级关系做过任何约定

1. 用括号显式地表达式优先级

    `{ ( [ 0 ! ] + 1 ) ^ ( [ ( 2 * [ 3 ! ] ) + 4 ] - 5 ) }`

2. 将运算符移到对应的右括号后

    `{ ( [ 0 ] ! 1 ) + ( [ ( 2 [ 3 ] ! ) * 4 ] + 5 ) - } ^`

3. 抹去所有括号, 即得

    `0 ! 1 + 2 3 ! * 4 + 5 - ^`

## infix 到 postfix: 转换算法

```cpp
float evaluate(char *S, char *&RPN) { // RPN 转换
  /* ....................................... */
  while (!optr.empty()) { // 逐个处理各字符, 直至运算符栈空
    if (isDigit(*S)) {  // 若当前字符为操作数, 则直接将其
      readNumber(S, opnd); append(RPN, opnd.top()); // 接入 RPN
    } else {            // 若当前字符为运算符
      switch (orderBetween(optr.top(), *S)) {
        /* ........................ */
        case '>':   // 且可立即执行, 则在执行相应计算的同时将其
          char op = optr.pop(); append(RPN, op); // 接入 RPN
          /* .................... */
          break;
        /* ........................ */
      }
    }
  }
}
```
