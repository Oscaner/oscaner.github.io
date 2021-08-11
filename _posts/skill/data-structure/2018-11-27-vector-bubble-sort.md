---
layout: post
title: "C++ 数据结构 (二) 向量 (7) 起泡排序"
date: 2018-11-27 14:44
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

## 排序器: 统一入口

```cpp
void Vector<T>::sort(Rank lo, Rank hi) { // 区间 [lo, hi)
  switch (rand() % 5) { // 视具体问题的特点灵活选取或扩充
    case 1: bubbleSort(lo, hi); break;    // 起泡排序
    case 2: selectionSort(lo, hi); break; // 选择排序 (习题)
    case 3: mergeSort(lo, hi); break;     // 归并排序
    case 4: heapSort(lo, hi); break;      // 堆排序 (第10章)
    default: quickSort(lo, hi); break;    // 快速排序 (第12章)
  }
} // 在此统一接口下, 具体算法的不同实现, 将在后续各章节陆续讲解
```

## 起泡排序

### 问题一

给定 n 个整数, 将它们按 (非降) 序排列

#### 观察

**有序/无序** 序列中, **任意/总有** 一对相邻元素 **顺序/逆序**

#### 扫描交换

依次比较每一对相邻元素, 如有必要, 交换之

若整趟扫描都没有进行交换, 则排序完成；否则, 再做一趟扫描交换

```cpp
void bubbleSort(int A[], int n)
{
  for (bool sorted = false; sorted = !sorted; n--) // 逐趟扫描交换, 直至安全有序
    for (int i = 1; i < n; i++) // 自左向右, 逐对检查 A[0, n) 内各相邻元素
      if (A[i-1] > A[i]) {      // 若逆序, 则
        swap(A[i-1], A[i]);     // 令其交换, 同时
        sorted = false;         // 清除 (全局) 有序标志
      }
}
```

### 问题二

该算法必然会结束? 至多需要迭代多少趟?

1. 不变性: 经 k 轮扫描交换后, 最大的 k 个元素必然就位

2. 单调性: 经 k 轮扫描交换后, 问题规模缩减至 n-k

3. 正确性: 经过至多 n 趟扫描后, 算法必然终止, 且能给出正确解答

![6.png](/img/in-post/skill/data-structure/post-vector-bubble-sort/6.png)

### 改进

```cpp
template <typename T>
void Vector<T>::bubbleSort(Rank lo, Rank hi) {
  while (!bubble(lo, hi--)); // 逐趟做扫描交换, 直至全序
}

template <typename T>
bool Vector<T>::bubbleSort(Rank lo, Rank hi) {
  bool sorted = true; // 整体有序标志
  while (++lo < hi)                   // 自左向右, 逐一检查各对相邻元素
    if (_elem[lo - 1] > _elem[lo]) {  // 若逆序, 则
      sorted = false;                 // 意味着尚未整体有序, 并需要
      swap(_elem[lo - 1], _elem[lo]); // 交换
    }
  return sorted; // 返回有序标志
} // 乱序限于 [0, √n) 时, 仍需 O(n^{3/2}) 时间 — 按理,  O(n) 应已足矣
```

### 再改进

```cpp
template <typename T>
void Vector<T>::bubbleSort(Rank lo, Rank hi) {
  while (lo < (hi = bubble(lo, hi))); // 逐趟扫描交换, 直至全序
}

template <typename T>
Rank Vector<T>::bubble(Rank lo, Rank hi) {
  Rank last = lo;   // 最右侧的逆序对初始化为 [lo - 1, lo]
  while (++lo < hi) // 自左向右, 逐一检查各对相邻元素
    if (_elem[lo - 1] > _elem[lo]) {  // 若逆序, 则
      last = lo;                      // 更新最右侧逆序对位置记录, 并
      swap(_elem[lo - 1], _elem[lo]); // 交换
    }
  return last; // 返回最右侧的逆序对位置
} // 前一版本中的逻辑型标志 sorted, 改为秩 last
```

![1.png](/img/in-post/skill/data-structure/post-vector-bubble-sort/1.png)

## 综合评价

效率相对于初版相同, 最好 $ O(n) $, 最坏 $ O(n^2) $, 主要是针对一般情况做了优化

输入含重复元素时, 算法的稳定性 (stability) 是更为细致的要求

重复元素在输入、输出序列中的相对次序, 是否保持不变?

![2.png](/img/in-post/skill/data-structure/post-vector-bubble-sort/2.png)

在起泡排序中, 元素 a 和 b 的相对位置发生变化, 只有一种可能:

经分别与其他元素的交换, 二者相互**接近**直至**相邻**

在接下来一轮扫描交换中, 二者因**逆序**而交换位置
