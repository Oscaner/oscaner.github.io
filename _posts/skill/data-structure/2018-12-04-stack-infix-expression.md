---
layout: post
title: "C++ 数据结构 (四) 栈与队列 (2) 栈应用 (3) 中缀表达式"
date: 2018-12-04 14:17
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

## 典型应用场合

1. 逆序输出 (conversion)

    输出次序与处理过程颠倒, 递归深度和输出长度不易预知

2. 递归嵌套 (stack permutation + parenthesis)

    具有自相似性的问题可递归描述, 但分支位置和嵌套深度不固定

3. 延迟缓冲 (evaluation)

    线性扫描算法模式中, 在预读足够长之后, 方能确定可处理的前缀

4. 栈式计算 (RPN)

    基于栈结构的特定计算模式

## 表达式求值

给定语法正确的算术表达式 S, 计算与之对应的数值

```shell
> echo $(( 0 + ( 1 + 23 ) / 4 * 5 * 67 - 8 + 9 ))
> set /a ( !0 ^<^< ( 1 - 2 + 3 * 4 ) ) - 5 * ( 6 ^| 7 ) / ( 8 ^^ 9 )
```

## 构思

![1.png](/assets/img/in-post/skill/data-structure/post-stack-infix-expression/1.png)

延迟缓冲

![3.png](/assets/img/in-post/skill/data-structure/post-stack-infix-expression/3.png)

## 实例

求值算法 = 栈 + 线性扫描

![3.png](/assets/img/in-post/skill/data-structure/post-stack-infix-expression/3.png)

## 实现：主算法

```cpp
float evaluate(char *S, char *&RPN) { // 中缀表达式
  Stack<float> opnd; Stack<char> optr; // 运算数栈、运算符栈
  optr.push('\\0'); // 尾哨兵 '\\0' 也作为头哨兵首先入栈
  while (!optr.empty()) { // 逐个处理各字符, 直至运算符栈空
    if (isDigit(*S)) // 若当前字符为操作数, 则
      readNumber(S, opnd); // 读入 (可能多位的) 操作数
    else // 若当前字符为运算符, 则视其与栈顶运算符之间优先级的高低
      switch(orderBetween(optr.top(), *S)) { /* 分别处理 */ }
  } // while
  return opnd.pop(); // 弹出并返回最后的计算结果
}
```

## 实现：优先级表

```cpp
const char pri[N_OPTR][N_OPTR] = { // 运算符优先等级 [栈顶][当前]
  //           |-------------- 当前运算符 --------------|
  //           +    -    *    /    ^    !    (    )    \\0
  /* --  + */ '>', '>', '<', '<', '<', '<', '<', '>', '>',
  /*  |  - */ '>', '>', '<', '<', '<', '<', '<', '>', '>',
  /* 栈  * */ '>', '>', '>', '>', '<', '<', '<', '>', '>',
  /* 顶  / */ '>', '>', '>', '>', '<', '<', '<', '>', '>',
  /* 运  ^ */ '>', '>', '>', '>', '>', '<', '<', '>', '>',
  /* 算  ! */ '>', '>', '>', '>', '>', '>', ' ', '>', '>',
  /* 符  ( */ '<', '<', '<', '<', '<', '<', '<', '=', ' ',
  /*  |  ) */ ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ',
  /* -- \\0 */ '<', '<', '<', '<', '<', '<', '<', ' ', '=',
};
```

## 实现：不同优先级处理方法

```cpp
switch(orderBetween(optr.top(), *S) {
  case '<': // 栈顶运算符优先级更低
    optr.push(*S); S++; break;            // 计算推迟, 当前运算符进栈
  case '=': // 优先级相等 (当前运算符为右括号, 或尾部哨兵'\0')
    optr.pop(); S++; break;               // 脱括号并接收下一个字符
  case '>': // 栈顶运算符优先级更高, 实施相应的计算, 结果入栈
    char op = optr.pop();                 // 栈顶运算符进栈, 执行对应的运算
    if ('!' == op)
      opnd.push(calcu(op, opnd.pop()));               // 一元运算符
    else {
      float pOpnd2 = opnd.pop(), pOpnd1 = opnd.pop(); // 二元运算符
      opnd.push(calcu(pOpnd1, op, pOpnd2));           // 实施计算, 结果入栈
    }
    break;
}
```

## 实例

![4.png](/assets/img/in-post/skill/data-structure/post-stack-infix-expression/4.png)
