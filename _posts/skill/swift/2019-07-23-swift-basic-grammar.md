---
layout: post
title: "Swift 5 - 基础语法"
date: 2019-07-23 22:57
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

## 注释

1. 单行注释: `//`
2. 多行注释: `/* */`
3. 文档注释: `///`
4. 分组注释: `// MARK:-`

## 常量与变量

- 常量: 定义之后无法修改
- 变量: 定义之后可以修改

```swift
// 定义常量
let a: Int = 10
a = 11 // Cannot assign to value: 'a' is a 'let' constant.

// 定义变量
var b: Int = 20
```

> 注: 所谓常量无法修改, 指的是该常量的指针所指向的对象无法被修改, 但对象内部的属性仍然可以修改。如下所示:

```swift
let view: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
view.backgroundColor = UIColor.red
```

## 数据类型

### 整型

#### 有符号

- `Int8`: 有符号8位整型
- `Int16`: 有符号16位整型
- `Int32`: 有符号32位整型
- `Int64`: 有符号64位整型
- `Int`: 和平台相关

#### 无符号

- `UInt8`: 无符号8位整数
- `UInt16`: 无符号16位整数
- `UInt32`: 无符号32位整数
- `UInt64`: 无符号64位整数
- `UInt`: 和平台相关

```swift
var m: Int = 10
```

### 浮点型

- `Float`: 32位浮点型
- `Double`: 64位浮点型(默认)

```swift
let pi: Double = 3.14
```

### 布尔型

- `TRUE`: 真
- `FALSE`: 假

```swift
let t: Bool = TRUE
```

### 字符串

#### 定义

```swift
// 定义单行字符串
let str = "Hello Swift"

// 定义多行字符串
let str1 = """
静夜思
作者: 李白
窗前明月光, 疑是地上霜
举头望明月, 低头思故乡
"""
```

Swift 5 新增特性: `Raw String`, 用 `#` 包裹带有转义字符的字符串

```swift
// 之前版本要输出 \ 字符需要输入 \\ 进行转义
let a = "字符串中有\\转义字符反斜杠\\"
print(a) // 字符串中有\转义字符反斜杠\

// 用 # 包裹则无需 \\
let b = #"字符串中有\转义字符反斜杠\"#
print(b) // 字符串中有\转义字符反斜杠\

// 若字符串中有#则需 ## 包裹
let c = ##"字符串中有#转义字符反斜杠\"##
print(c) // 字符串中有#转义字符反斜杠\
```

#### 常用操作

##### 字符长度

```swift
let str = "12345678"
let len2 = str.count // 8
let len3 = (str as NSString).length // 8
```

##### 字符拼接

- `+`
- append

```swift
let str1 = "abc" + 'cde'
var str = "abc"
str.append("cde")
```

##### 字符遍历

```swift
let str = "abcdefg"
for char in str {
  print(char)
}
// ========================
for (idx, val) in str.enumerated() {
  print("\(idx): \(val)")
}
```

##### 字符大小写

```swift
let str = "aBcDeF"
print(str.lowercased()) // 小写
print(str.uppercased()) // 大写
```

##### 字符包含

```swift
let str = "abcdefg"
print(str.contains("cd")) // true
print(str.contains("o"))  // false
```

##### 字符分割

```swift
import Foundation
let str = "abcdefg$hijklmn$opqrst$uvw"
let separate = str.components(separatedBy: "$")
for item in separate {
  print(item)
}
```

##### 字符替换

```swift
import Foundation
let str = "abcdefg$hijklmn$opqrst$uvw"
let replace = str.replacingOccurrences(of: "$", with: ",")
print(replace)
```

##### 字符子串

```swift
let str = "Hello World"

// 截取字符串的前五个字符
let sub1_1 = str.prefix(5)
// or
let index1 = str.index(str.startIndex, offsetBy: 5)
let sub1_2 = str[str.startIndex..<index1] // Hello

// 截取后五个字符
let sub2_1 = str.suffix(5)
// or
let index2 = str.index(str.endIndex, offsetBy: -5)
let sub2_2 = str[index2..<str.endIndex] // World

// 截取第3个字符到第5个字符的字符子串
let index3 = str.index(str.startIndex, offsetBy: 2)
let index4 = str.index(str.startIndex, offsetBy: 4)
let sub3 = str[index3...index4] // llo
```

### 可选类型

可以判断是否为空(nil)的数据类型。Swift 中只有可选类型才会出现 nil 的情况。

注: nil 相当于其它语言中的 NULL

#### 定义

```swift
let name1: Optional<String> = nil

let name2: String? = nil
```

#### 解包

1. 强制解包

    ```swift
    var str: String? = nil

    str = "Hello"
    print(str) // Optional("Hello")

    // 强制解包 !
    print(str!) // "Hello"
    ```

2. 隐式解包

    ```swift
    var str: String? = "Hello"
    if let str1 = str {
        print(str1) // "Hello"
    }

    // or
    guard let str2 = str else {
      return
    }
    print(str2) // "Hello"
    ```

#### 案例

```swift
// 进行网络请求
let url: URL? = URL(string: "https://www.oscaner.com")
if let tempUrl = url {
  let request = URLRequest(url: tempUrl)
}
```

### 日期类型

```swift
var date = Date()
```

### 泛类型

- `Any`: 一个空协议集合的别名, 它表示没有实现任何协议。因此它可以是 **任何类型**, 包括类实例与结构体实例。**可以表示任何类型, 包括函数类型**
- `AnyObject`: 一个成员为空的协议, **任何对象** 都实现了这个协议。**可以表示任何类型的实例**

## 数据结构

### 元组

元组用于定义一组数据, 数据可以是任意类型, 组成元组的数据可以称为元素。

#### 定义

```swift
// 写法一:
let person_one = ("1001", "张三", 30, 90)
// person_one: (String, String, Int, Int)
// 下标访问
print(person_one.0)

// 写法二:
let person_two = (
  id: "1001",
  name: "张三",
  age: 30,
  score: 90
)
// person_two: (id: String, name: String, age: Int, score: Int)
// 键名访问
print(person_two.id)

// 写法三:
let (id, name) = ("1001", "张三")
// 直接访问
print(id)
```

### 数组

数组是一堆**有序的**由**相同类型**元素构成的集合, 数组必须初始化才可使用

#### 定义

1. 定义的同时初始化

    ```swift
    // 定义可变的字符数组
    var array1: [String] = [String]()
    // 定义不可变的泛型数组
    let array2: [NSObject] = ["zhangsan", 18]

    let array = [1, 2, 3, 4, 5]
    ```

2. 先声明, 后初始化

    ```swift
    // 先声明变量类型
    var array3: Array<String>
    // or
    var array4: [String]

    // 后初始化
    array3 = array4 = [String]()
    ```

#### 基本操作

1. 数组长度: `array.count`
2. 数组判空: `array.isEmpty`
3. 添加数据: `array.append(6)`
4. 插入数据: `array.insert(10, at: 2)`
5. 删除元素: `array.dropFirst()` `array.dropLast()`
6. 修改元素: `array[0] = 100`
7. 数组取值: `array[1]` `array.first`
8. 数组倒叙: `array.reverse()`

#### 遍历

1. 普通遍历

    ```swift
    for i in 0..<array.count {
      print(array[i])
    }
    ```

2. for in 循环

    ```swift
    for item in array {
      print(item)
    }
    ```

3. 设置遍历区间

    ```swift
    for item in array[0..<2] {
      print(item)
    }
    ```

4. 枚举遍历

    ```swift
    let names = ["zhangsan", "lisi", 18]
    for (idx, name) in names.enumerated() {
      print("\(idx): \(name)")
    }
    ```

### 字典

- 字典是由键值 `key:value` 对组成的集合
- 字典中的元素之间是 **无序** 的
- 字典是由两部分集合构成, 一个是健集合, 一个是值集合
- 字典可以通过健间接访问值
- 健集合不能有重复元素, 值集合可以有重复元素
- 字典 `Dictionary` 是一个泛型集合

#### 定义

```swift
// 定义
var dict1: [String: Any] = [String: Any]()
let dict2: [String: Any] = [
  "name": "zhangsan"
  "age": 18
]

// 声明
var dict3: Dictionary<Int, String>
var dict4: [Int: String]

// 类型补齐
let p = ["name": "zhangsan", "age": 18, "sex": "男"] as [String: Any]
```

#### 基本操作

- 获取长度: `dict.count`
- 字典判空: `dict.isEmpty`
- 添加数据: `dict["address"] = "宁波"`
- 删除数据: `dict.removeValue(forKey: "sex")`
- 修改数据: `dict.updateValue("lisi", forKey: "name")`
- 查询数据: `dict["name"]`

#### 字典遍历

1. 普通遍历

    ```swift
    for key in dict.keys {
      print(key)
    }
    for value in dict.values {
      print(value)
    }
    ```

2. 元组遍历

    ```swift
    for (key, value) in dict {
      print("\(key): \(value)")
      // name: zhangsan
    }
    ```

3. 枚举遍历

    ```swift
    for (index, value) in dict.enumerated() {
      print("\(index): \(value)")
      // 0: (key: "name", value: "zhangsan")
    }
    ```

## 基本运算

### 类型转换

#### 强制类型转换

由于 Swift 是强类型语言, 基本运算必须保证数据类型一致, 否则会报错

可以使用强制类型转换

```swift
let a = 10
let b = 3.14

let c = Double(a) + b
let d = a + Int(b)
```

#### 字符串转换

1. 基本类型可通过插值方式转换成字符串

    ```swift
    var age = 10
    var str = "小明今年\(age)岁了"
    ```

2. 字符串转换成基本类型, 必须保证字符串的内容是可以转换的

    ```swift
    var number = "123"
    var no = Int(number)
    ```

#### 类型转化符号

##### 类型检查操作符 `is`

```swift
let str = "Hello"

if str is String {
    print("str is String")
}
```

##### 类型转换操作符 `as`

```swift
// 确定类型转换会成功
let a = "Hello" as! String

// 不确定类型转换会成功
let b = "Hello" as? Int
```

### 常见运算符

- 基本运算符: `+` `-` `*` `/` `%`
- (复合)赋值运算符: `=` `+=` `-=` `*=` `/=` `%=`
- 比较运算符: `>` `>=` `<` `<=` `==` `!=`
- 区间运算符: `...` `..<`
- 最值运算符: `.max` `.min`
- 逻辑运算符: `&&` `||` `!`

## 逻辑分支

### 条件判断

#### if 语句

- 判断语句可以不用 `()`
- 执行语句必须用 `{}`
- 判断语句需要明确的 Boolean 值, 即不再有非0即真的概念, 必须明确 TRUE or FALSE

1. 案例一

    ```swift
    let a = 10

    // 错误写法
    if a {
      print(a)
    }

    // 正确写法
    if a > 9 {
      print(a)
    }
    ```

2. 案例二

    ```swift
    let score = 87
    if score < 60 {
      print("不及格")
    } else if score < 90 {
      print("及格")
    } else if score < 100 {
      print("优秀")
    } else {
      print("完美")
    }
    ```

3. 案例三

    ```swift
    let view: UIView? = UIView()

    if view != nil {
      view!.backgroundColor = UIColor.red
    }
    ```

#### 三目运算符

```swift
let a = 10
let b = 50

let result = a > b ? a : b
// 相当于
// if a > b {
//    result = a
// } else {
//    result = b
// }
print(result)
```

#### guard 语句

guard 是 Swift 2.0 新增的语法, 目的是提高程序的可读性

它与 if 语句类似, 但不同的是, 只有当条件为 FALSE 时才会执行 `{}` 内的代码

```swift
var age = 18

func online(age: Int) -> Void {
  guard age >= 18 else {
    print("小于18岁")
    return
  }
  print("不小于18岁")
}

online(age)
```

#### switch 语句

- switch 后可以不用 `()`
- case 后可以不用 `break`
- case 后多行语句可以不用 `()`

1. 案例一: 常规

    ```swift
    let sex = 0

    switch sex {
      case 0:
        print("男")
      case 1:
        print("女")
      default:
        print("其它")
    }
    ```

2. 案例二: case 多值判断

    ```swift
    // 多值
    let sex = 1
    switch sex {
      case 0, 1:
        print("正常人")
      default:
        print("保密")
    }

    // 范围
    let score = 88
    switch score {
      case 0..<60:
        print("不及格")
      case 60..<90:
        print("及格")
      case 90..<100:
        print("优秀")
      default:
        print("完美")
    }
    ```

3. 案例三: case 穿透

    ```swift
    let sex = 1
    switch sex {
      case 0:
        fallthrough
      case 1:
        print("正常人")
      default:
        print("保密")
    }
    ```

4. 案例四: 支持多种数据类型

    ```swift
    // 浮点型
    let f = 3.14
    switch f {
      case 3.14:
        print("PI")
      default:
        print("not PI")
    }

    // 字符串型
    let m = 5
    let n = 10
    var result = 0

    let opration = "+"

    switch opration {
      case "+":
        result = m + n
      case "-":
        result = m - n
      case "*":
        result = m * n
      case "/":
        result = m / n
      default:
        result = 0
    }
    ```

### 循环

#### for 循环

```swift
for i in 0..<10 {
  print(i)
}

// 如果不需要用到下标
for _ in 0..<10 {
  print("hello")
}

// 取下标和值
let str = "abcdegf"
for (idx, val) in str.enumerated() {
  print("\(idx): \(val)")
}
```

#### while 循环

先判断再执行

```swift
var a = 10
while a < 20 {
  print(a)
  a += 1
}
```

#### repeate while 循环

先执行再判断

```swift
var b = 0
repeat {
  print(b)
  b += 1
} while b < 20
```

## 其它小知识

### 判断倍数 - Swift 5

```swift
let number = 4
// 判断 4 是否为 2 的倍数
if number.isMultiple(of: 2) {
  print("Even")
} else {
  print("Odd")
}
```

### 随机数 - Swift 4.2

```swift
let ranInt = Int.random(in: 0..<5)
let ranFloat = Float.random(in: 0..<5)
let ranDouble = Double.random(in: 0..<5)
let ranBool = Bool.random()

var names = ["ZhangSan", "LiSi", "WangWu"]
// 数组重新排序
let shuffled = names.shuffled()
```

### 布尔切换 - Swift 4.2

```swift
var isSwift = true
isSwift.toggle() // 无返回值
print(isSwift)
```
