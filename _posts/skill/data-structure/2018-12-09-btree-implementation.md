---
layout: post
title: "C++ 数据结构 (五) 二叉树 (4) 二叉树实现"
date: 2018-12-09 14:47
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

## BinNode: 模板类

```cpp
#define BinNodePosi(T) BinNode<T>* // 节点位置

template <typename T>
struct BinNode {
  BinNodePosi(T) parent, lChild, rChild; // 父亲、左孩子、右孩子
  T data; int height; int size(); // 数据、高度、子树规模
  BinNodePosi(T) insertAsLC(T const &); // 作为左孩子插入新节点
  BinNodePosi(T) insertAsRC(T const &); // 作为右孩子插入新节点
  BinNodePosi(T) succ(); // (中序遍历意义下) 当前节点的直接后继
  template <typename VST> void travLevel(VST &); // 子树层次遍历
  template <typename VST> void travPre(VST &);   // 子树先序遍历
  template <typename VST> void travIn(VST &);    // 子树中序遍历
  template <typename VST> void travPost(VST &);  // 子树后序遍历
}
```

![1.png](/assets/img/in-post/skill/data-structure/post-btree-implementation/1.png)

## BinNode: 接口

```cpp
template <typename T>
BinNodePosi(T) BinNode<T>::insertAsLC(T const &e) {
  return lChild = new BinNode(e, this);
}

template <typename T>
BinNodePosi(T) BinNode<T>::insertAsRC(T const &e) {
  return rChild = new BinNode(e, this);
}

template <typename T>
int BinNode<T>::size() { // 后代总数，亦即以其为根的子树的规模
  int s = 1; // 计入本身
  if (lChild) s += lChild -> size(); // 递归计入左子树规模
  if (rChild) s += rChild -> size(); // 递归计入右子树规模
} // O(n = |size|)
```

![2.png](/assets/img/in-post/skill/data-structure/post-btree-implementation/2.png)

## BinTree: 模板类

```cpp
template <typename T>
class BinTree {
  protected:
    int _size; // 规模
    BinNodePosi(T) _root; // 根节点
    virtual int updateHeight(BinNodePosi(T) x); // 更新节点 x 的高度
    void updateHeightAbove(BinNodePosi(T) x);   // 更新 x 及祖先的高度
  public:
    int size() const { return _size; } // 规模
    bool empty() const { return !_root; } // 判空
    BinNodePosi(T) root() const { return _root; } // 树根
    /* ... 子树接入、删除和分离接口 ... */
    /* ... 遍历接口 ... */
}
```

## BinTree: 高度更新

```cpp
#define stature(p) ( (p) ? (p) -> height : -1 )

template <typename T> // 更新节点 x 高度，具体规则因树不同而异
int BinTree<T>::updateHeight(BinNodePosi(T) x) {
  // 二叉树结点高度 = 左右子树结点高度最大者 + 1
  return x -> height = 1 +
          max(stature(x -> lChild), stature(x -> rChild));
} // 此处采用常规二叉树规则，O(1)

template <typename T> // 更新 v 及其历代祖先的高度
void BinTree<T>::updateHeightAbove(BinNodePosi(T) x) {
  while (x) { // 可优化: 一旦高度未变，即可终止
    updateHeight(x); x = x -> parent;
  }
} // O(n = depth(x))
```

## BinTree: 节点插入

```cpp
template <typename T>
BinNodePosi(T) BinTree<T>::insertAsRC(BinNodePosi(T) x, T const &e) { // insertAsLC()对称
  _size++; x -> insertAsRC(e); // x 祖先的高度可能增加，其余节点必然不变
  updateHeightAbove(x);
  return x -> rChild;
}
```

![3.png](/assets/img/in-post/skill/data-structure/post-btree-implementation/3.png)
