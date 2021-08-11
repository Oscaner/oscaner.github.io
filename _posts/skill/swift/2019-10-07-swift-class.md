---
published: false
layout: post
title: "Swift 5 - 枚举、结构体与类"
date: 2019-10-07 20:54
author: "Oscaner"
header-img: "img/post-bg-alitrip.jpg"
multilingual: false
mathjax: false
no-catalog: false
categories:
  - skill
  - swift
tags:
  - Skill
  - Swift
---

## 枚举

### 概念

枚举简单的说也是一种数据类型，只不过是这种数据类型只包含自定义的特定数据，它是一组有共同特性的数据的集合。

- 它声明在类中，可以通过实例化类来访问它的值
- 枚举也可以定义构造函数 (initializers) 来提供一个初始成员值，可以在原始的实现基础上扩展它们的功能
- 可以遵守协议 (protocols) 来提供标准的功能

### 语法

#### 定义

Swift 中使用 enum 关键词来创建枚举并且把它们的整个定义放在一对大括号内:

```swift
enum enumname {
  // Enumeration definition on here
}
```

```swift
enum Method {
  case ADD
  case SUB
  case MUL
  case DIV
}
// Or
enum Method {
  case ADD, SUB, MUL, DIV
}

let selectMethod = Method.Sub

switch (selectMethod) {
  case Method.ADD:
    print("加法")
  case Method.SUB:
    print("减法")
  case Method.MUL:
    print("乘法")
  case Method.DIV:
    print("除法")
}
```

#### 赋值

枚举类型赋值可以是**字符串/字符/整型/浮点型**

```swift
enum CompassPoint: Int {
  case NORTH = 1
  case SOUTH = 2
  case EAST = 3
  case WEST = 4
}

enum CompassPoint: Double {
  case NORTH = 1.0
  case SOUTH = 2.0
  case EAST = 3.0
  case WEST = 4.0
}

enum CompassPoint: String {
  case NORTH = "North"
  case SOUTH = "South"
  case EAST = "East"
  case West = "West"
}
```

#### 类型推断

当枚举类型确定的时候，访问值可以直接通过 **.值** 访问

```swift
enum Method {
  case ADD
  case SUB
  case MUL
  case DIV
  func method() {

  }
}

let a: Method = .ADD

let selectMethod = Method.SUB

switch (selectMethod) {
  case .ADD:
    print("加法")
  case .SUB:
    print("减法")
  case .MUL:
    print("除法")
  case .DIV:
    print("乘法")
}
```

#### 原始值

```swift
enum CompassPoint: Int {
  case NORTH = 1
  case SOUTH = 2
  case EAST = 3
  case WEST = 4
}

let point: CompassPoint = .SOUTH

print(point.rawValue); // print: 2

let p = CompassPoint(rawValue: 4)
if let p = p {
  switch p {
    case .NORTH:
      print("North")
    case .SOUTH:
      print("South")
    case .EAST:
      print("East")
    case .West:
      print("West")
  }
}
```

#### 遍历(Swift 4.2)

Swift 4.2 中对枚举扩充了一个功能，通过枚举继承 `CaseIterable` 来允许枚举被遍历。

```swift
enum Method: CaseIterable {
  case ADD, SUB, MUL, DIV
}

for method in Method.allCases {
  print(method)
}
```

#### 枚举种的可选参数(Swift 5)

Swift 5 之后，可变参数的枚举种定义时，`...` 改成了数组

```swift
enum ABC {
  // case abc(argv: Int...)
  case abc(argv: [Int])
}

func getABC() -> ABC {
  return .abc(argv: [0, 1, 2, 3])
}
```

## 结构体

### 概念

- 结构体 (struct) 是由一系列具有相同类型或不同类型的数据构成的数据集合
- 结构体是值类型
- 结构体即可以定义属性又可以定义方法

### 语法

```swift
struct Name {
  // 属性和方法
}
```

```swift
struct Person {
  var name = "Zhangsan"
  var age = 10
  var sex = "man"
  func say() {
    print("I"m say now);
  }
}
```

#### 实例化

```swift
let p1 = Person()
var p2 = Person(name: "Lisi", age: 20, sex: "woman")
```

#### 访问属性和方法

```swift
let name = p2.name
p2.say()
```

#### 值类型

结构体是值类型，非引用类型

```swift
var p3 = p2
p3.name = "Alias"

print(p2.name)
print(p3.name)
```

### 常用的结构体

`Swift` 中的 `String` `Array` `Dictionary` 是通过结构体来实现的，因此它们可以进行值传递。

#### CGRect

```swift
/* Rectangles. */
public struct CGRect {
  public var origin: CGPoint
  public var size: CGSize
  public init()
  public init(origin: CGPoint, size: CGSize)
}
```

#### CGSize

```swift
/* Sizes. */
public struct CGSize {
  public var width: CGFloat
  public var height: CGFloat
  public init()
  public init(width: CGFloat, height: CGFloat)
}
```

#### CGPoint

```swift
/* Points. */
public struct CGPoint {
  public var x: CGFloat
  public var y: CGFloat
  public init()
  public init(x: CGFloat, y: CGFloat)
}
```

## 类

### 概念

- `Swift` 虽然推荐面向协议编程，但其也是一门面向对象编程的语言。
- 面向对象的基础是类，类产生了对象，即类的实例。
- `Swift` 中用 `class` 关键字来定义类

### 语法

```swift
class ClassName {
  // 定义属性和方法
}
```

```swift
class Person {
  var name = "Zhangsan"
  var age = 10
  var sex = "man"
  func say() {
    print("人会说话")
  }
}
```

#### 实例化

```swift
var p1 = Person()
```

#### 访问属性和方法

```swift
var p1 = Person()
// 访问
p1.age
// 设置
p1.age = 30
```

#### 引用类型

不同于值类型，引用类型被赋值到一个常量、变量或者本身被传递到一个函数的时候，它是不会被拷贝的，使用的是对相同实例的引用。

```swift
var p2 = p1

print(p1.name)
p2.name = "Lisi"
print(p1.name)
```

#### 特征运算符

因为类是引用类型，可能有很多变量或常量引用到了同一个类的实例。

为了找出两个变量是否引用了同一个实例，可以使用特征运算符。

```swift
let p3 = Person()
p1 === p2 // True
p1 === p3 // False
p1 !== p3 // True
```

#### 继承

- 一个类可以从另一个类继承方法、属性和其它特性
- 当一个类从另一个类继承后，继承的类就是被继承类的子类
- 继承的目的是为了代码复用 `Do not repeat yourself`

```swift
class Vehicle {
  var currentSpeed = 0.0
  func makeNoise() {
    print("Ba Ba")
  }
}

// 定义子类
class Bicycle: Vehicle {
  var hasBasket = false
}

var vehicle = Vehicle()
vehicle.makeNoise()
var bicycle = Bicycle()
bicycle.makeNoise()
```

#### 重写(覆写)

- 重写就是子类可以对父类的方法属性就行重写

- 重写需要在前面加上 `override` 关键字

    ```swift
    class Bicycle: Vehicle {
      var hasBasket = false
      override func makeNoise() {
        print("Di Di")
      }
    }

    var bicycle = Bicycle()
    bicycle.makeNoise()
    ```

- 通过 `final` 关键字可以防止方法属性被子类重写

    ```swift
    class Vehicle {
        var currentSpeed = 0.0
        func makeNoise() {
            print("Ba Ba")
        }
        final func run() {
            print("Running")
        }
    }
    ```

## 类与结构体

### 相同点

- 属性
- 方法
- 构造函数
- 扩展
- 遵循协议

### 不同点

- 类可以继承
- 类可以进行类型转换 (子类 as 父类)
- 类有析构函数
- 类有引用计数

### 使用场景

- 类和结构体都可以用来定义数据类型，结构体用于值传递，类用于引用传递

- 使用结构体的场景

    - 需要定义的数据类型中只有少量的简单数据类型和属性
    - 需要定义的数据类型在数据传递时需要值传递
    - 不需要继承另一个数据类型
