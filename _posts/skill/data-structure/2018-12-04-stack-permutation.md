---
layout: post
title: "C++ 数据结构 (四) 栈与队列 (2) 栈应用 (2) 栈混洗与括号匹配"
date: 2018-12-04 14:09
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

## 括号匹配

### 实例

![2.png](/assets/img/in-post/skill/data-structure/post-stack-permutation/2.png)

观察: 除了各种括号, 其余符号均可暂时忽略

![3.png](/assets/img/in-post/skill/data-structure/post-stack-permutation/3.png)

### 尝试

0. 平凡: 无括号的表达式是匹配的

1. 减治?

![4.png](/assets/img/in-post/skill/data-structure/post-stack-permutation/4.png)

2. 分治?

![5.png](/assets/img/in-post/skill/data-structure/post-stack-permutation/5.png)

然而, 根据以上性质, 却不易直接应用已知的策略

究其根源在于, 1 和 2 均为**必要性**, 比如反例:

![6.png](/assets/img/in-post/skill/data-structure/post-stack-permutation/6.png)

### 构思

颠倒以上思路: 消去一对紧邻的左右括号, 不影响全局的匹配判断。亦即:

![7.png](/assets/img/in-post/skill/data-structure/post-stack-permutation/7.png)

那么, 如何找到这对括号?

再者, 如何使问题的这种简化得以持续进行?

顺序扫描表达式, 用栈记录已扫描的部分

反复迭代: 反遇 `(`, 则进栈；凡遇 `)`, 则出栈

![8.png](/assets/img/in-post/skill/data-structure/post-stack-permutation/8.png)

### 实现

```cpp
bool paren(const char exp[], int lo, int hi) // exp[lo, hi)
  Stack<char> S; // 使用栈记录已发现但尚未匹配的左括号
  for (int i = lo; i < hi; i++) // 逐一检查当前字符
    if ('(' == exp[i]) S.push(exp[i]); // 遇左括号: 则进栈
    else if (!S.empty()) S.pop(); // 遇右括号: 若栈非空, 则弹出左括号
    else return false; // 否则 (遇右括号时栈已空) , 必不匹配
  return S.empty(); // 最终, 栈空当且仅当匹配
}
```

### 实例

![9.png](/assets/img/in-post/skill/data-structure/post-stack-permutation/9.png)

### 拓展

从实例可以看出, 明明直接使用 **计数器** 即可判断括号是否匹配, 为何还要使用 **栈结构** 呢?

反例: `[ ( ] )`, 如果使用计数器, 那将会显示匹配, 然而事实上括号种类不同, 并不匹配

因此, 栈结构的思路和算法, 可便捷地推广至多种括号并存地情况

![10.png](/assets/img/in-post/skill/data-structure/post-stack-permutation/10.png)

甚至, 只需约定"括号"地通用格式, 而不必事先固定括号地类型与数目

如: `<body>|</body>`, `<h1>|</h1>`, `<font>|</font>`, `<p>|</p>`,

## 栈混洗

所谓栈混洗, 就是根据某种约定的规则, 对栈内元素进行重新排序。

考查栈: `A = < a1, a2, ..., an ]、B = S = Ø`, 左端为栈顶

只允许: 将 A 的顶元素弹出并压入 S (`S.push(A.pop())`), 或将 S 的顶元素弹出并压入 B (`B.push(S.pop())`)

若经过一系列以上操作后, A 中元素全部转入 B 中, `B = [ a(k1), ..., a(kn) >`, 右端为栈顶

则称之为 A 的一个栈混洗 (stack permutation)

![11.png](/assets/img/in-post/skill/data-structure/post-stack-permutation/11.png)

### 计数

同一输入序列, 可有多种栈混洗

`[ 1, 2, 3, 4 >`, `[ 4, 3, 2, 1 >`, `[ 3, 2, 4, 1 >`, ...

长度为 n 的序列, 可能的栈混洗总数:

$$ SP(n) = \sum_{k=1}^{n} SP(k - 1) * SP(n - k) = catalan(n) = \frac{(2n)!}{(n+1)!n!} \leqslant n! $$

![12.png](/assets/img/in-post/skill/data-structure/post-stack-permutation/12.png)

### 甄别

输入序列 `< 1, 2, 3, ..., n ]` 的 任一排列 `[ p1, p2, p3, ..., pn >` 是否为栈混洗?

简单情况: `< 1, 2, 3 ]`, `n = 3`

栈混洗 6! / 4! / 3! = 5 种, 全排列 3! = 6 种, 少了一种? 少的是 `[ 3, 1, 2 >`

![13.png](/assets/img/in-post/skill/data-structure/post-stack-permutation/13.png)

观察: 任意三个元素能否按某相对次序出现于混洗中, 于其他元素无关。`123` 不能混洗成 `312`, 这是一类 **禁形**

故推广: 对于任何 `1 ≤ i < j < k ≤ n, [ ..., k, ..., i, ..., j, ... >` 必非栈混洗

反过来, 不存在 `312` 模式的序列, 一定是栈混洗吗?

### 甄别算法

充要性: A permutation is a stack permutation iff, it does NOT involve the permutation `312`

如此, 可得一个 $ O(n^3) $ 的甄别算法

`[ p1, p2, p3, ..., pn >` 是 `< 1, 2, 3, ..., n ]` 的栈混洗, **当且仅当** 对于任意 `i < j`, 不含模式 `[ ..., j+1, ..., i, ..., j, ... >`

如此, 可得一个 $ O(n^2) $ 的甄别算法

直接借助栈 A、B 和 S, 模拟混洗过程。每次 `S.pop()` 之前, 检测 S 是否已空；或需弹出的元素在 S 中, 却非顶元素

如此, 可得一个 $ O(n) $ 的甄别算法

## 栈混洗与括号匹配

观察: 每一栈混洗, 都对应于栈 S 的 `n次push` 与 `n次pop` 操作构成的序列

![14.png](/assets/img/in-post/skill/data-structure/post-stack-permutation/14.png)
