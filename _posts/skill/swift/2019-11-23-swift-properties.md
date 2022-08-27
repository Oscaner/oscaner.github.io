---
published: false
layout: post
title: "Swift 5 – 属性与方法"
date: 2019-11-23 13:20
author: "Oscaner"
header-img: "assets/img/post-bg-alitrip.jpg"
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

## 属性

### 属性类型

- 存储属性: 存储实例的常量和变量
- 计算属性: 通过某种方式计算出来的动态属性
- 类属性: 也可以称为静态属性, 与类自身相关的属性

#### 存储属性

- 存储属性是最简单的属性, 它作为类实例的一部分, 用于存储常量和变量
- 可以给存储属性提供一个默认值, 也可以在初始化方法中对其进行初始化

```swift
class Student {
  // 存储属性
  var age: Int = 0
  var name: String?
  var chineseScore: Double = 0.0
  var mathScore: Double = 0.0
}

// 创建学生对象
let stu = Student()

// 给存储属性赋值
stu.age = 10
stu.name = "Zhangsan"
stu.chineseScore = 89.0
stu.mathScore = 98.0
```

#### 计算属性

- 计算属性不存储实际的值, 而是提供 `getter` 和可选的 `setter` 来间接获取和设置其它属性
- 计算属性一般只提供 `getter` 方法
- 如果只提供 `getter`, 而不提供 `setter`, 则该计算属性为只读属性, 并且可以省略 `get {}`

```swift
class Student {
  // 存储属性
  var age: Int = 0
  var name: String?
  var chineseScore: Double = 0.0
  var mathScore: Double = 0.0

  // 计算属性
  var averageScore: Double {
    get {
      return (chineseScore + mathScore) / 2
    }

    // newValue 是系统分配的变量名, 内部存储着新值
    set {
      // 这里会进入死循环, 又进行赋值调用 set
      self.averageScore = newValue
    }
  }
}

// 创建学生对象
let stu = Student()

print(stu.averageScore)
```

#### 类属性 (静态属性)

- 类属性, 也可以称为静态属性, 是直接与类本身相关联
- 所有类和实例都共有一份静态属性, 因此在某一处修改之后, 该类属性就会被修改
- 静态属性的设置和修改, 需要通过类来完成

```swift
class Student {
  // 存储属性
  var age: Int = 0
  var name: String?
  var chineseScore: Double = 0.0
  var mathScore: Double = 0.0

  // 计算属性
  var averageScore: Double {
    get {
      return (chineseScore + mathScore) / 2
    }
  }

  // 静态属性
  static var englishScore: Double = 95.5
}

// 设置静态属性的值
Student.englishScore = 90.5
print(Student.englishScore)
```

#### 懒加载属性

- Apple 设计思想: 希望所有对象只有在使用的时候才加载到内存中
- 在 `OC` 中可以通过重写 `get` 方法来进行懒加载
- `Swift` 中用 `lazy` 关键字来声明属性懒加载

```swift
// 格式
// lazy var 变量: 类型 = { 闭包 }()

lazy var teacher: [String] = { () -&gt; [String] in
  return ["Mr. Zhang", "Mr. Li", "Mr. Yang"]
}()
```

#### 区别

- 存储属性: 存储常量和变量
- 计算属性: 依赖于存储属性, 通过 `getter` 和 `setter` 方法间接访问和设置值
- 类属性: 本质是一个静态属性, 在类中限定了其作用域, 用关键字 `static` 修饰
- 懒加载属性: 用关键字 `lazy` 修饰, 必须进行初始化
- 全局属性: 作用域为全局的属性

### 属性监听

- `Swift` 中可以通过属性监听器来监听和响应属性值的变化
- 属性监听器

    - `willSet`: 属性值设置之前
    - `didSet`: 属性值设置之后

- 属性监听器只能用于存储属性

```swift
class Student {
  var name: String? {
    // 属性值设置之前
    willSet {
      print("Will Set: ")
      if let newValue = newValue {
        print(newValue)
      }
    }
    // 属性值设置之后
    didSet {
      print("Did Set:")
      if let oldValue = oldValue {
        print(oldValue)
      }
    }
  }
}

let stu = Student()
stu.name = "Zhangsan"
```

## 方法

### 实例方法

- 实例方法属于特定类实例、结构体实例或枚举实例的方法

#### self 属性

- 每一个类的实例内部都隐含一个叫做 `self` 的属性, 可以使用 `self` 访问类中的属性和方法

    ```swift
    class Student {
      var str = "Hello world!"
      func say(info: String) {
        print(info)
      }
      func eat(food: String) {
        self.say(info: food)
        print("Eat \(food)")
      }
    }

    var stu = Student()
    stu.eat(food: "Rice")
    ```

- 在值类型中修改自身的属性, 需要申明 `mutating` 关键字

    ```swift
    struct Student {
      var str = "Hello world!"
      mutating func eat() {
        self.str = "Hello Swift!"
      }
    }
    ```

### 类型方法

#### 静态方法

- 在函数前申明 `static` 关键字
- 可以在类、结构体中使用

```swift
static func paly() {
  print("Play")
}
```

#### 类方法

- 在函数前申明 `class` 关键字
- 仅在类中使用

```swift
class func play() {
  print("Play")
}
```

#### 总结

##### 相同点

- 都可以修饰计算属性和方法

##### 不同点

- `class` 不能修饰存储属性, `static` 可以修饰存储属性
- `class` 修饰的计算属性可以被重写, `static` 修饰的计算属性不能被重写
- `class` 修饰的计算属性被重写时, 可以使用 `static` 转为静态属性
- `class` 修饰的类方法可以被重写, `static` 修饰的静态方法不能被重写
- `class` 修饰的类方法被重写时, 可以使用 `static` 转为静态方法
- `class` 只能在类中使用, `static` 可以在类、结构体、枚举中使用

## 构造与析构

### 构造函数

构造函数用于初始化一个类的实例
默认情况下创建一个类时, 必然会调用一个构造函数 (系统默认构造函数)
若继承自 `NSObject`, 则可以对父类的构造函数进行重写

#### 默认构造函数

- 在创建类和结构体的实例时必须为所有的存储属性设置一个合适的初始值

    ```swift
    class Person {
      var name: String
      init() {
        print("Init.")
        name = "Zhangsan"
      }
    }

    var p = Person()
    p.name
    ```

#### 自定义构造函数

```swift
class Person {
  var name: String
  // Default.
  init() {
    name = "Zhangsan"
  }
  // Custom.
  init(name: String) {
    self.name = name
  }
}

var p = Person()
p.name
var p2 = Person(name: "Wangwu")
p2.name
```
