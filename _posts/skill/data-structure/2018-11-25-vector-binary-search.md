---
layout: post
title: "C++ 数据结构 (二) 向量 (5) 二分查找"
date: 2018-11-25 14:39
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

【注】二分查找的前提是有序向量, 亦或有序线性表

## 接口

```cpp
template <typename T> // 查找算法同一接口, 0 <= lo < hi <= _size
Rank Vector<T>::search(T const &e, Rank lo, Rank hi) const {
  return (rand() % 2) ?            // 按各 50% 的概率随机选用
    binSearch(_elem, e, lo, hi):   // 二分查找算法, 或者
    fibSearch(_elem, e, lo, hi);   // Fibonacci 查找算法
}
```

## 语义

![1.png](/img/in-post/skill/data-structure/post-vector-binary-search/1.png)

应该便于有序向量自身的维护: `V.insert(1 + V.search(e), e)`

即便失败, 也应给出新元素适当的插入位置

若允许重复元素, 则每一组也需按其插入的次序排列

【约定】

- 在有序向量区间 `A[lo, hi)` 中, 确定 **不大于 e 的最后一个** 元素
- 若 `-∞ < e < V[lo]`, 则返回 `lo - 1` (左侧哨兵)
- 若 `V[hi - 1] < e < +∞`, 则返回 `hi - 1` (末元素 = 右侧哨兵左邻)

## 版本A

### 原理

![2.png](/img/in-post/skill/data-structure/post-vector-binary-search/2.png)

减而治之: 以任一元素 `x = S[mi]` 为界, 都可将待查找区间分为三部分, `S[lo, mi) <= S[mi] <= S(mi, hi)`

只需将目标元素 e 与 x 做一比较, 即可分三种情况进一步处理:

1. `e < x`: 则 e 若存在必属于 **左侧** 子区间 `S[lo, mi)`, 故可递归深入

2. `x < e`: 则 e 若存在必属于 **右侧** 子区间 `S(mi, hi)`, 亦可递归深入

3. `e = x`: 已在此处命中, 可随即返回

二分 (折半) 策略: 轴点 mi 总是取作中点 —— 于是每经过 **至多两次** 比较, 或者能够命中, 或者将问题规模缩减一半

### 实现

```cpp
template <typename T> // 在有序向量区间 [lo, hi) 内查找元素 e
static Rank binSearch(T *A, T const &e, Rank lo, Rank hi) {
  while (lo < hi) { // 每步迭代可能要做两次比较判断, 有三个分支
    Rank mi = (lo + hi) >> 1; // 以中点为轴点
    if (e < A[mi]) hi = mi;          // 深入前半段 [lo, mi) 继续查找
    else if (A[mi] < e) lo = mi + 1; // 深入后半段 (mi, hi)
    else return mi;                  // 在 mi 处命中
  }
  return -1; // 查找失败
}
```

### 实例

![3.png](/img/in-post/skill/data-structure/post-vector-binary-search/3.png)

`S.search(8, 0, 7)`: 共经 2 + 1 + 2 = 5 次比较, 在 `S[4]` 处命中

`S.search(3, 0, 7)`: 共经 1 + 1 + 2 = 4 次比较, 在 `S[1]` 处失败

线性递归: $ T(n) = T(\frac{n}{2}) + O(1) = O(\log n) $, 大大优于顺序查找

递归跟踪: 轴点总取中点, 递归深度 $ O(\log n) $; 各递归实例均耗时 $ O(1) $

### 查找长度

如何更为精细地评估查找算法地性能？

考查关键码地比较次数, 即查找长度 (search length)

通常, 需分别针对成功与失败查找, 从最好、最坏、平均等角度评估

比如, 成功、失败时地平均查找长度均大致为 $ O(1.50 * \log n) $

![4.png](/img/in-post/skill/data-structure/post-vector-binary-search/4.png)

## 版本B

### 改进思路

**直接解决** 二分查找中左、右分支转向代价不平衡的问题

比如, 每次迭代 (或每个递归实例) 仅做 **1次** 关键码比较

如此, 所有分支只有 **2个** 方向, 而不再是 **3个**

同样的, 轴点 **mi** 取作中点, 则查找每深入一层, 问题规模也缩减一半

1. `e < x`: 则 `e` 若存在必属于左侧子区间 `S[lo, mi)`, 故可递归深入

2. `x <= e`: 则 `e` 若存在必属于右侧子区间 `S[mi, hi)`, 亦可递归深入

只有当元素数目 `hi - lo = 1` 时, 才判断该元素是否命中

![5.png](/img/in-post/skill/data-structure/post-vector-binary-search/5.png)

### 实现

```cpp
template <typename T> static Rank binSearch(T *A, T const &e, Rank lo, Rank hi) {
  while (1 < hi - lo) { // 有效查找区间的宽度缩短至 1 时, 算法才会终止
    Rank mi = (lo + hi) >> 1; // 以中点为轴点, 经比较后确定深入
    (e < A[mi]) ? hi = mi : lo = mi; // [lo, mi) or [mi, hi)
  } // 出口时 hi = lo + 1, 查找区间仅含一个元素 A[lo]
  return (e == A[lo]) ? lo : -1; // 返回命中 or -1
} // 相对于版本A, 最好 (坏) 情况下更坏 (好) ; 各种情况下的 SL 更加接近, 整体性能更趋稳定
```

### 语义约定

以上二分查找算法

未严格兑现 `search()` 接口的语义约定: 返回不大于 e 的最后一个元素

只有兑现这一约定, 才可有效支持相关算法, 比如: `V.insert(1 + V.search(e), e)`

1. 当有多个命中元素时, 必须返回 **最靠后 (秩最大) 者**

2. 失败时, 应返回 **小于 e 的最大者 (含哨兵[lo - 1])**

![6.png](/img/in-post/skill/data-structure/post-vector-binary-search/6.png)

## 版本C (最终版)

### 实现

```cpp
template <typename T> static Rank binSearch(T *A, T const &e, Rank lo, Rank hi) {
  while (lo < hi) { // 不变性: A[0, lo) <= e < A[hi, n)
    Rank mi = (lo + hi) >> 1; // 以中点为轴点, 经比较后确定深入
    (e < A[mi]) ? hi = mi : lo = mi + 1; // [lo, mi) 或 (mi, hi)
  } // 出口时,  A[lo = hi] 为大于 e 的最小元素
  return --lo; // 故 lo - 1 即不大于 e 的元素的最大秩
}
```

### 与版本B的差异

1. 待查找区间宽度缩短至 `0` 而非 `1` 时, 算法才结束

2. 转入右侧子向量时, 左边界取作 `mi + 1` 而非 `mi`

3. 无论成功与否, 返回的秩严格符合接口的语义

### 正确性

不变性: `A[0, lo) <= e < A[hi, n)`, `A[hi]` 总是大于 e 的最小者

初始时, $ lo = 0 且 hi = n, A[0, lo) = A[hi, n) = \emptyset $, 自然成立

数学归纳: 假设不变性一直保持至(a), 以下无非两种情况 ...

![7.png](/img/in-post/skill/data-structure/post-vector-binary-search/7.png)
