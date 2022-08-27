---
layout: post
title: "C++ 数据结构 (二) 向量 (1) 接口与实现"
date: 2018-11-23 14:09
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

## ADT VS DS

- 抽象数据类型 (Abstract Data Type) ：数据模型 + 定义在该模型上的一组操作

    | 抽象定义 | 外部的逻辑特性 | 操作 & 语义 |
    | 一种定义 | 不考虑时间复杂度 | 不涉及数据的存储方式 |

- 数据结构 (Data Structure) ：基于某种特定语言, 实现 ADT 的一整套算法

    | 具体实现 | 内部的表示与实现 | 完整的算法 |
    | 多种实现 | 与复杂度密切相关 | 要考虑数据的具体存储机制 |

![1.png](/assets/img/in-post/skill/data-structure/post-vector-interface/1.png)

## 向量 ADT

### 从数组到向量

- 在 C/C++ 等高级语言中, 数组 `A[]` 中的元素与 `[0, n)` 内的编号一一对应

    ![2.png](/assets/img/in-post/skill/data-structure/post-vector-interface/2.png)

- 反之, 每个元素均由 (非负) 编号唯一指代, 并可直接访问

    `A[i]` 的物理地址 = `A + i * s`, s 为单个元素占用的空间量

    故亦称作线性数组 (linear array)

- 向量是数组的抽象与泛化, 由一组元素按线性次序封装而成

    1. 循秩访问 (call-by-rank): 各元素与 `[0, n)` 内的秩 (rank) 一一对应

    2. 元素的类型不限于基本类型

    3. 操作、管理维护更加简化、统一与安全

    4. 可更为便捷地参与复杂数据结构的定制与实现

### 向量接口

| 操作 | 功能 | 适用对象 |
| :--: | :--: | :--: |
| size() | 报告向量当前的规模 (元素总数) | 向量 |
| get(r) | 获取秩为 r 的元素 | 向量 |
| put(r, e) | 用 e 替换秩为 r 的元素的数值 | 向量 |
| insert(r, e) | e 作为秩为 r 的元素插入, 原后继元素依次后移 | 向量 |
| remove(r) | 删除秩为 r 的元素, 返回该元素中原存放的对象 | 向量 |
| disordered() | 判断所有元素是否已按非降序排列 | 向量 |
| sort() | 调整各元素的位置, 使之按非降序排列 | 向量 |
| find(e) | 查找目标元素 e | 向量 |
| search(e) | 查找目标元素 e, 返回不大于 e 且秩最大的元素 | 有序向量 |
| deduplicate() | 剔除重复元素 | 向量 |
| uniquify() | 剔除重复元素 | 有序向量 |
| traverse() | 遍历向量并统一处理所有元素, 处理方法由函数对象指定 | 向量 |

![3.png](/assets/img/in-post/skill/data-structure/post-vector-interface/3.png)

## Vector 模板类

### 框架

```cpp
typedef int Rank;          // 秩
#define DEFAULT_CAPACITY 3 // 默认初始容量 (实际应用中可设置为更大)

template <typename T> class Vector { // 向量模板类
  private: Rank _size; int _capacity; T *_elem; // 规模、容量、数据区
  protected:
      /* ... 内部函数 */
  public:
      /* ... 构造函数 */
      /* ... 析构函数 */
      /* ... 只读接口 */
      /* ... 可写接口 */
      /* ... 遍历接口 */
};
```

![4.png](/assets/img/in-post/skill/data-structure/post-vector-interface/4.png)

### 构造与析构

```cpp
// 构造器 ========================
// 默认
Vector(int c = DEFAULT_CAPACITY) {
  _elem = new T[_capacity = c];
  _size = 0;
}
// 数组区间复制
Vector(T const *A, Rank lo, Rank hi) {
  copyFrom(A, lo, hi);
}
// 向量区间复制
Vector(Vector<T> const &V, Rank lo, Rank hi) {
  copyFrom(V._elem, lo, hi);
}
// 向量整体复制
Vector(Vector<T> const &V) {
  copyFrom(V._elem, 0, V._size);
}
// 析构器 =========================
~Vector() {
  delete [] _elem; // 释放内部空间
}
```

### 基于复制的构造

```cpp
template <typename T> // T 为基本类型, 或已重载赋值操作符 '='
void Vector<T>::copyFrom(T* const A, Rank lo, Rank hi) {
  _elem = new T[_capacity = 2 * (hi - lo)]; // 分配空间
  _size = 0; // 规模清零
  while (lo < hi)               // A[lo, hi) 内的元素逐一
      _elem[_size++] = A[lo++]; // 复制到 _elem[0, hi - lo)
}
```

![5.png](/assets/img/in-post/skill/data-structure/post-vector-interface/5.png)
