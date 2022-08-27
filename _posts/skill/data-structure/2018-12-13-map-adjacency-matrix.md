---
layout: post
title: "C++ 数据结构（六）图（2）邻接矩阵"
date: 2018-12-13 16:06
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

## Graph 模板类

```cpp
template <typename Tv, typename Te> // 顶点类型、边类型
class Graph {
  private:
    void reset() { // 所有顶点、边的辅助信息复位
      for (int i = 0; i < n; i++) { // 顶点
        status(i) = UNDISCOVERED; dTime(i) = fTime(i) = -1;
        parent(i) = -1; priority(i) = INI_MAX;
        for (int j = 0; j < n; j++) // 边
        if (exists(i, j)) status(i, j) = UNDETERMINED;
      }
    }
  public:
    /* ... 顶点操作、边操作、图算法：无论如何实现，接口必须统一 ... */
}; // Graph
```

## 实例

![4.png](/assets/img/in-post/skill/data-structure/post-map-adjacency-matrix/4.png)

## Vertex 顶点类

```cpp
typedef enum { UNDISCOVERED, DISCOVERED, VISITED } VStatus;
template <typename Tv>
struct Vertex { // 顶点对象（并未严格封装）
  Tv data; int inDegree, outDegree; // 数据、出入度数
  VStatus status; // （如上三种）状态
  int dTime, fTime; // 时间标签
  int parent; // 在遍历树中的父节点
  int priority; // 在遍历树中的优先级（最短通路、极短跨边等）
  Vertex (Tv const &d): // 构造新顶点
    data(d), inDegree(0), outDegree(0), status(UNDISCOVERED),
    dTime(-1), fTime(-1), parent(-1),
    priority(INI_MAX) {}
}
```
