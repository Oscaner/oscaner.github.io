---
layout: post
title: "C++ 数据结构 (二) 向量 (3) 无序向量"
date: 2018-11-24 14:50
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

## 元素访问 (循秩访问)

通过 `V.get(r)` 和 `V.put(r, e)` 接口, 可以读、写向量元素

但就便捷性而言, 远不如数组元素的访问方式: `A[r]`

是否可沿用借助下标的访问方式？

为此, 需重载下标操作符

```cpp
template <typename T>
T & Vector<T>::operator[](Rank r) const { return _elem[r]; }
```

此后, 对外的 `V[r]` 对应于内部的 `V._elem[r]`

右值: `T x = V[r] + U[s] * W[t];`

左值: `V[r] = (T)(2 * x + 3);`

## 元素插入

```cpp
template <typename T> // e 作为秩为 r 元素插入, 0 <= r <= _size
Rank Vector<T>::insert(Rank r, T const & e) { // O(n - r)
  expand(); // 若有必要, 扩容
  for (int i = _size; i > r; i--) { // 自后向前
    _elem[i] = _elem[i - 1];        // 后继元素顺次后移一个单元
  }
  _elem[r] = e; // 置入新元素
  _size++;      // 更新容量
  return r;     // 返回秩
}
```

![1.png](/assets/img/in-post/skill/data-structure/post-vector-unordered/1.png)

## 元素删除

### 区间删除

```cpp
template <typename T> // 删除区间 [lo, hi), 0 <= lo <= hi <= _size
int Vector<T>::remove(Rank lo, Rank hi) { // O(n - hi)
  if (lo == hi) return 0; // 出于效率考虑, 单独处理退化情况
  while (hi < _size) _elem[lo++] = _elem[hi++]; // [hi, _size) 顺次前移 hi - lo 位
  _size = lo; // 更新规模
  shrink();   // 若有必要则缩容
  return hi - lo;
}
```

![2.png](/assets/img/in-post/skill/data-structure/post-vector-unordered/2.png)

### 单元素删除

可以视作区间删除操作的特例: `[r] = [r, r+ 1)`

```cpp
template <typename T> // 删除向量中秩为 r 的元素, 0 <= r < _size
T Vector<T>::remove(Rank r) { // O(n - r)
  T e = _ elem[r];  // 备份被删除元素
  remove(r, r + 1); // 调用区间删除算法
  return e;         // 返回被删除元素
}
```

## 元素查找

无序向量: T 为可判等的基本类型, 或已重载操作符 `==` 或 `!=`

有序向量: T 为可比较的基本类型, 或已重载操作符 `<` 或 `>`

```cpp
template <typename T> // 0 <= lo < hi <= _size
Rank Vector<T>::find(T const & e, Rank lo, Rank hi) const { // O(hi - lo) = O(n), 在命中多个元素时可返回秩最大者
  while((lo < hi--) && (e != _elem[hi])); // 逆向查找
  return hi; // hi < lo 意味着失败, 否则 hi 即命中元素的秩
} // Excel::match(e, range, type)
```

![3.png](/assets/img/in-post/skill/data-structure/post-vector-unordered/3.png)

## 元素去重

应用实例: 网络搜索的局部结果经过去重操作, 汇总为最终报告

### 算法

```cpp
template <typename T> // 删除重复元素, 返回被删除元素数目
int Vector<T>::deduplicate() { // 繁琐版 + 错误版
  int oldSize = _size; // 记录原规模
  Rank i = 1; // 从 _elem[1] 开始
  while (i < _size) { // 自前向后逐一考查各元素 _elem[1]
    (find(_elem[i], 0, i) < 0) ? // 在前缀中寻找雷同者
        i++                      // 若无雷同则继续考查其后继
        : remove(i);             // 否则删除雷同者 (至多一个?!)
  }
  return oldSize - _size; // 向量规模变化量, 即删除元素总数
}
```

### 正确性

不变性: 在当前元素 `V[i]` 的前缀 `V[0, i)` 中, 各元素彼此互异。初始 `i = 1` 时自然成立, 其余的一般情况 ...

单调性: 随着反复的 `while` 迭代

1. 当前元素前缀的长度单调非降, 且迟早增至 `_size`
2. 当前元素后缀的长度单调下降, 且迟早减至 0

故算法必然终止, 且至多迭代 $ O(n) $ 轮

![4.png](/assets/img/in-post/skill/data-structure/post-vector-unordered/4.png)

### 复杂度

每轮迭代中 `find()` 和 `remove()` 累计耗费线性时间, 故总体为 $ O(n^2) $

可进一步优化, 比如:

1. 仿照 `uniquify()` 高效版的思路, 元素移动的次数可降至 $ O(n) $。但比较次数依然时 $ O(n^2) $, 而且稳定性将被破坏

2. 先对需删除的重复元素做标记, 然后再统一删除。稳定性保持, 但因查找长度更长, 从而导致更多的比对操作

3. `V.sort().uniquify()`: 简明实现最优的 $ O(n * logn) $

## 向量遍历

遍历向量, 统一对各元素分别实施 `visit` 操作

- 利用 **函数指针** 机制, 只读或局部性修改

    ```cpp
    template <typename T>
    void Vector<T>::traverse(void (*visit)(T&)) { // 函数指针
      for (int i = 0; i < _size; i++) visit(_elem[i]);
    }
    ```

- 利用 **函数对象** 机制, 可全局性修改

    ```cpp
    template <typename T> template <typename VST>
    void Vector<T>::traverse(VST &visit) { // 函数对象
      for (int i = 0; i < _size; i++) visit(_elem[i]);
    }
    ```

- 遍历实例: 统一将向量中所有元素分别加一

    ```cpp
    template <typename T> // 假设 T 可直接递增或已重载操作符 "++"
    struct Increase { // 函数对象: 通过重载操作符 "()" 实现
        virtual void operator()(T &e) { e++; } // 加一
    };

    template <typename T>
    void increase(Vector<T> &V) {
        V.traverse(Increase<T>()); // 即可以之为基本操作遍历对象
    }
    ```
