---
published: false
layout: post
title: "Swift 4 - 开放 View 属性"
date: 2019-06-02 20:15
author: "Oscaner"
header-img: "assets/img/post-bg-alitrip.jpg"
multilingual: false
mathjax: false
no-catalog: true
categories:
  - skill
  - swift
tags:
  - Skill
  - Swift
---

在 IOS 开发的时候, 经常要用到类似于圆角半径、阴影之类的属性,

但是这些属性都没有开放到 storyboard 面板中, 需要代码实现。

查了相关资料, 发现可以自定义把这些属性开放到 storyboard 中, 把代码记录一下, 留作参考。

1. 创建 UIViewHelper.swift 文件

```swift
import UIKit

extension UIView {

  // 圆角半径
  @IBInspectable
  var cornerRadius: CGFloat {
    get {
      return layer.cornerRadius
    }
    set {
      layer.cornerRadius = newValue
    }
  }

  // 阴影半径
  @IBInspectable
  var shadowRadius: CGFloat {
    get {
      return layer.shadowRadius
    }
    set {
      layer.shadowRadius = newValue
    }
  }

  // 阴影透明度
  @IBInspectable
  var shadowOpacity: Float {
    get {
      return layer.shadowOpacity
    }
    set {
      layer.shadowOpacity = newValue
    }
  }

  // 阴影颜色
  @IBInspectable
  var shadowColor: UIColor? {
    get {
      return layer.shadowColor != nil ?
              UIColor(cgColor: layer.shadowColor!) : nil
    }
    set {
      layer.shadowColor = newValue?.cgColor
    }
  }

  // 阴影偏移
  @IBInspectable
  var shadowOffset: CGSize {
    get {
      return layer.shadowOffset
    }
    set {
      layer.shadowOffset = newValue
    }
  }

}
```

注: 设置阴影圆角属性的时候记得勾选 `clip to bounds` 允许裁边
