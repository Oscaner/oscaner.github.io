---
layout: post
title: "C++ 数据结构 (三) 列表 (2) 无序列表"
date: 2018-11-28 15:22
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

## 秩到位置

是否可以模仿向量的**循秩访问**方式?

可以，比如，通过重载下标操作符

```cpp
template <typename T> // assert: 0 <= r < size
T List<T>::operator[](Rank r) const { // O(r)，效率低下，可偶尔为之，却不宜常用
  Posi(T) p = first(); // 从首节点出发
  while (0 < r--) p = p -> succ; // 顺数第 r 个节点
  return p -> data; // 目标节点
} // 任一节点的秩，亦即其前驱的总数
```

## 查找

在节点 `p` (可能是 `trailer`) 的 `n` 个 (真) 前驱中，找到等于 `e` 的最后者

```cpp
template <typename T> // 从外部调用时，0 <= n <= rank(p) < _size
Posi(T) List<T>::find(T const &e, int n, Posi(T) p) const { // 顺序查找，O(n)
  while (0 < n--) // 从右向左，逐个将 p 的前驱与 e 比对
    if (e == (p = p -> pred) -> data) return p; // 直至命中或范围越界
  return NULL; // 若越出左边界，意味着查找失败
} // header 的存在使得处理更为简洁
```

## 插入

```cpp
template <typename T>
Posi(T) List<T>::insertBefore(Posi(T) p, T const &e) {
  _size++;
  return p -> insertAsPred(e); // e 当作 p 的前驱插入
}

template <typename T> // 前插入算法 (后插入算法完全对称)
Posi(T) ListNode<T>::insertAsPred(T const &e) { // O(10
  Posi(T) x = new ListNode(e, pred, this); // 创建 (耗时 100 倍)
  pred -> succ = x; pred = x; return x; // 建立链接，返回新节点的位置
}
```

![1.png](/assets/img/in-post/skill/data-structure/post-list-unordered/1.png)

## 复制

```cpp
template <typename T> // 基本接口
void List<T>::copyNodes(Posi(T) p, int n) { // O(n)
  init(); // 创建头、尾哨兵节点并做初始化
  while (n--) { // 将起自 p 的 n 项依次作为末节点插入
    insertAsLast(p -> data); p = p -> succ;
  }
}
```

## 删除

```cpp
template <typename T>
T List<T>::remove(Posi(T) p) { // O(1)
  T e = p -> data; // 备份待删除节点数值 (设类型 T 可直接赋值)
  p -> pred -> succ = p -> succ;
  p -> succ -> pred = p -> pred;
  delete p; _size--; return e; // 返回备份数值
}
```

![2.png](/assets/img/in-post/skill/data-structure/post-list-unordered/2.png)

## 析构

```cpp
template <typename T>
List<T>::~List() { // 列表析构
  clear(); delete header; delete trailer; // 清空列表，释放头、尾哨兵
}

template <typename T>
int List<T>::clear() { // 清空列表
  int oldSize = _size;
  while (0 < _size) // 反复删除首节点，直至列表变空
    remove(header -> succ);
  return oldSize;
} // O(n)，线性正比于列表规模
```

![3.png](/assets/img/in-post/skill/data-structure/post-list-unordered/3.png)

## 唯一化

```cpp
template <typename T>
int List<T>::deduplicate() { // 剔除无序列表中的重复节点
  if (_size < 2) return 0; // 平凡列表自然无重复
  int oldSize = _size; // 记录原规模
  Posi(T) p = first(); Rank r = 1; // p 从首节点起
  while (trailer != (p = p -> succ)) { // 依次直到末节点
    Posi(T) q = find(p -> data, r, p); // 在 p 的 r 个 (真) 前驱中，查找与之雷同者
    q ? remove(q) : r++; // 若存在，则删除；否则秩递增
  } // assert：循环过程中的任意时刻，p 的所有前驱互不相同
  return oldSize - _size; // 列表规模变化量，即被删除元素总数
} // 正确性及效率分析的方法与结论，与 Vector::deduplicate() 相同
```
