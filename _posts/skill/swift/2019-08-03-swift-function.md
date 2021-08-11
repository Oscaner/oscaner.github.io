---
published: false
layout: post
title: "Swift 5 - 函数与闭包"
date: 2019-08-03 14:53
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

## 函数

### 常见的函数定义

```swift
func 函数名(形参) -> 返回值类型 {
  // 具体实现
  return 返回值
}
```

#### 无参无反

```swift
func about1() -> Void {
  print("first.")
}

func about2() -> () {
  print("second.")
}

func about3() {
  print("third.")
}
```

#### 有参无反

```swift
func about(a: Int) {
  print(a)
}
```

#### 无参有反

```swift
func about() -> String {
  return "Hello Word!"
}
```

#### 有参有反

```swift
func about(a: Int) -> Int {
  return a * 2
}
```

### 注意事项

#### 注意一: 形参常量

Swift 函数形参默认为常量, 无法在函数内部修改形参值。

```swift
let a = 10

func show(input: Int) {
  print("intput 1: \(input)")
  input += 1 // show error
}
```

#### 注意二: 形参标签

每一个函数的形参都包含 **形参标签** 和 **形参名**

- **形参标签** 用于调用函数时显示
- **形参名** 用于函数内部使用

```swift
func show(input name: String) {
  print(name)
}
show(input: "LiSi")

func show2(_ name: String) {
  print(name)
}
show2("WangWu")
```

#### 注意三: 默认参数

```swift
func show(_ name: String = "ZhangSan") {
  print(name)
}
show()
```

#### 注意四: 无限形参

```swift
func add(numbers: Int...) -> Int {
  var tmp = 0
  for item in numbers {
    tmp += item
  }
  return tmp
}
add(numbers: 1, 2, 3, 4)
```

#### 注意五: 引用传递

Swift 默认是采用 **值传递**, 若想要修改传入的参数, 则需要采用 **引用传递**

```swift
func show(input number: inout Int) {
  print("input 1: \(number)")
  number += 1
  print("input 2: \(number)")
}

var num = 10
show(input: &num)
print("input 3: \(num)")
```

### 使用技巧

类似于 **数据类型**, 函数也是有类型的, 它默认是 **引用类型**, 并且可以像 `Int` `Double` 一样来使用。

```swift
func add(a: Int, b: Int) -> Int {
  return a + b;
}

var mathFunction: (Int, Int) -> Int = add

var result = mathFunction(10, 20)
print(result)
```

因此, 函数也可以作为其它函数的参数

```swift
func add(a: Int, b: Int) -> Int {
  return a + b;
}

func calc(a: Int, b: Int, calcMethod: (Int, Int) -> Int) {
  print(calcMethod(a, b))
}

calc(a: 10, b: 20, calcMethod: add)
```

同样, 函数也可以作为其它函数的返回值

```swift
func add(a: Int, b: Int) -> Int {
  return a + b
}
func add(a: Int, b: Int) -> Int {
  return a * b
}

func getResult(a: Int) -> (Int, Int) -> Int {
  if a > 10 {
    return add
  } else {
    return multiply
  }
}

var addResult = getResult(a: 2)(10, 20)
var multiplyResult = getResult(a: 12)(10, 20)
```

## 闭包

### 例子

1. 计算一个数的平方

    ```swift
    // 函数写法
    func square(param: Int) -> Int {
      return param * param
    }
    square(param: 3)

    // 闭包写法
    let squareCloure = { (param: Int) -> Int in
      return param * param
    }
    squareCloure(3)
    ```

### 概念

闭包, 又称为 **匿名函数**、**回调**。在网络请求中经常用到, 主要用于异步请求。

### 知识点

#### 参数简写

```swift
// 例子: 根据给定的数组和表达式返回新的数组
func getList(score: [Int], con: (Int) -> Bool) -> [Int] {
  var newScore: [Int] = [Int]()
  for item in score {
    if con(item) {
      newScore.append(item)
    }
  }
  return newScore
}

let newArray = getList(score: [74, 10, 20, 90, 83], con: {
  (s: Int) -> Bool in return s > 80
})
```

1. 简写一: 省略 `->` 与返回类型

    根据表达式返回值自动判断

    ```swift
    let newArray = getList(score: [74, 10, 20, 90, 83], con: { (s: Int) in return s > 80 })
    ```

2. 简写二: 省略参数类型和括号

    根据函数的参数自动推断参数类型

    ```swift
    let newArray = getList(score: [74, 10, 20, 90, 83], con: { s in return s > 80 })
    ```

3. 简写三: 省略 `return` 关键字

    ```swift
    let newArray = getList(score: [74, 10, 20, 90, 83], con: { s in s > 80 })
    ```

4. 简写四: 省略参数名称和 `in` 关键字

    ```swift
    let newArray = getList(score: [74, 10, 20, 90, 83], con: { $0 > 80 })
    ```

#### 闭包类型

##### 尾随闭包

尾随闭包是一个书写在函数括号之后的闭包表达式, 函数支持将其作为最后一个参数调用

```swift
// 尾随闭包
func doSomething(info: String, clousre: (String) -> Void) {
  clousre(info)
}

// 不使用尾随闭包进行函数调用
doSomething(info: "Hello", clousre: { s in print(s) })

// 使用尾随闭包进行函数调用
doSomething(infoL "World") { s in
  print(s)
}
```

##### 逃逸闭包

逃逸闭包会在函数执行结束之后被调用, 用 `@escaping` 申明

```swift
// 逃逸闭包: 闭包可以超出函数的范围来调用
// 定义闭包数组
var closureArray: [ () -> Void ] = [ () -> Void ]()

// 定义非逃逸闭包函数
func nonEscapeClosure(closure: () -> Void) {
  closure()
}

// 定义逃逸闭包函数
func escapeClosure(closure: @escaping () -> Void) {
  print('Start')
  closureArray.append(closure)
  print('End')
}

var x = 10
// 打印10
print(x)

nonEscapeClosure {
    x = 100
}
// 打印100, 非逃逸闭包已执行
print(x)

escapeClosure {
    x = 200
}
// 打印100, 逃逸闭包未执行
print(x)

closureArray.first?()
// 打印200, 逃逸闭包执行
print(x)
```

##### 自动闭包

自动闭包是一种自动创建的闭包, 不接受任何参数, 被调用时会返回被包装在其中的表达式的值

```swift
// 自动闭包
func printIfTrue(predicate: @autoclosure () -> Bool) {
  if predicate() {
    print("is true")
  }
  else {
    print("is false")
  }
}

// 自动将 2 > 1 转换成 () -> Bool 闭包
printIfTrue(predicate: 2 > 1)
```

#### 循环引用

闭包的循环引用容易引起内存不能即使释放

##### 案例

```swift
/// Class NetworkTools
class NetworkTools: NSObject {
  /// 完成回调
  var finishedCallBack: (() -> ())?
  /// 加载数据
  /// - parameter finished: 完成回调
  func loadData(finished: () -> ()) {
    self.finishedCallback = finished
    working()
  }

  func working() {
    finishedCallBack?()
  }

  deinit {
    print("网络工具 88")
  }
}
```

```swift
class ViewController: UIViewController {

  var tools: NetworkTools?

  override func viewDidLoad() {
    super.viewDidLoad()

    tools = NetworkTools()
    tools?.loadData() {
      print("加载数据完成, 更新界面:", NSThread.currentThread())
      self.view.backgroundColor = UIColor.redColor()
    }
  }

}
```

##### 解决方案

1. 方案一

    - 使用 `weak` 进行弱引用
    - `weak` 会将对象释放的引用置为 nil, 因此申明的变量必须是可选性
    - `self` 本身是一个可选性, 因此 `weakSelf` 也是一个可选性。然而在真正使用时, `self` 对应的是自身控制器, 必然有值, 因此可以强制解包。

    ```swift
    weak var weakSelf = self
    tools?.loadData() {
      print("加载数据完成, 更新界面:", NSThread.currentThread())
      weakSelf!.view.backgroundColor = UIColor.redColor()
    }
    ```

2. 方案二

    - 与方案一类似, 书写方式不同

    ```swift
    tools?.loadData {[weak self] () -> () in
      print("加载数据完成, 更新界面:", NSThread.currentThread())
      self!.view.backgroundColor = UIColor.redColor()
    }
    ```

3. 方案三

    - 使用关键字 `unowned`
    - 即使原有引用的对象已被释放, 仍然会保持对已释放对象的一个"无效"引用。若继续调用, 将会 crash

    ```swift
    tools?.loadData {[unowned self] () -> () in
      print("加载数据完成, 更新界面:", NSThread.currentThread())
      self.view.backgroundColor = UIColor.redColor()
    }
    ```

### 高阶函数

#### sort 排序

```swift
var array: [String] = ["A", "C", "B", "Z", "E"]
// 默认升序
array.sorted()
// 降序
array.sort { (str1, str2) -> Bool in
  return str1 > str2
}
```

#### forEach 遍历

```swift
var array: [String] = ["A", "C", "B", "Z", "E"]
// 遍历
array.forEach { (str) in
  print(str)
}
```

#### filter 筛选

```swift
var array: [String] = ["Aa", "Ca", "Ba", "Za", "Ea"]
// 筛选
array.filter { (str) -> Bool in
  str.hasPrefix("A")
}.forEach { (str) in
  print(str)
}
```

#### map 变换

```swift
var array: [String] = ["Aa", "Ca", "Ba", "Za", "Ea"]
// map
array.map { (str) -> String in
  "Hello " + str
}.forEach { (str) in
  print(str)
}
```

#### reduce 合规

```swift
var sum: [Int] = [11, 22, 33, 44]
// reduct 第一个参数是初始值, 第二个参数为中间结果, 第三个参数为每次数组中遍历的值
var total = sum.reduct(0) { (result, num) -> Int in
  return result + num
}
print(total)
```

#### allSatisfy 符合条件 (Swift 4.2)

```swift
let scores = [100, 20, 30, 40]
// 检查序列中的所有元素是否满足条件
let passed = scores.allStatisfy { $0 &lt; 101 }
print(passed)
```

#### compactMap (Swift 4)

与 map 不同的是, map 是对数组内元素的格式化。而 compactMap 对于不合规的数据 (结果为nil) 将会丢弃

```swift
let array = ["a", "1", "b", "100", "40"]

let a = array.map { (item) -> Int? in
  return Int(item)
}
print(a) // [nil, Optional(1), nil, Optional(100), Optional(40)]

let b = array.compactMap { (item) -> Int? in
  return Int(item)
}
print(b) // [1, 100, 40]
```

#### mapValues (Swift 4)

对字典中的 value 进行操作, 返回新的字典

```swift
let dic = [
  "first": 1,
  "second": 2,
  "third": 3,
  "fourth": 4
]

let mapValues = dic.mapValues({ $0 + 2})
print(mapValues)
```

#### compactMapValues (Swift 5)

进行 mapValues 转换的时候过滤不合规的数据

```swift
let dic = [
  "first": "1",
  "second": "2",
  "third": "3",
  "fourth": "doc"
]

let newDic = dic.compactMapValues({ Int($0) })
print(newDic)
```

#### first (Swift 4.1)

筛选第一个符合条件的数据

```swift
let array: [String] = ["Ab", "Ac", "Ba", "Bc", "Ca"]
let element = array.first(where: { $0.hasPrefix("C") })
print(element) // Ca
```

#### last (Swift 4.2)

```swift
let array: [String] = ["Ab", "Ac", "Ba", "Bc", "Ca"]
let element = array.last(where: { $0.hasPrefix("A") })
print(element) // Ac
```

#### removeAll (Swift 4.2)

删除所有符合条件的元素

```swift
let array: [String] = ["Ab", "Ac", "Ba", "Bc", "Ca"]
array.removeAll(where: { $0.hasPrefix("B") })
print(array)
```
