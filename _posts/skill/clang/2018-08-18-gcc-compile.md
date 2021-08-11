---
layout: post
title: "Clang - GCC 编译"
date: 2018-08-18 22:59
author: "Oscaner"
header-img: "img/post-bg-alitrip.jpg"
multilingual: false
mathjax: false
no-catalog: false
categories:
  - skill
  - clang
  - gcc
  - compile
tags:
  - Skill
  - Clang
  - GCC
  - Compile
---

示例代码

```c
#include <stdio.h>

int main() {
  printf("Hello World!\n" );
  return 0;
}
```

## 编译

### 一步到位

编译总共分四个阶段：

- 预处理（也称之为预编译，Preprocessing）
- 编译（Compilation）
- 汇编（Assembly）
- 链接（Linking）

```shell
> gcc -o test ./test.c
# 将 text.c 文件编译生成 test 程序（一步到位）
```

`-o`: 输出文件

### 分步介绍

#### 1. 预处理

```shell
> gcc -E ./test.c
# 直接在命令行窗口输出预处理代码
> gcc -E ./test.c -o ./test.i
# 输出 test.i 文件，存放 test.c 预处理代码
```

`-E`: 让编译器在预处理后停止，并输出预处理结果。本示例的预处理结果就是将 `stdio.h` 文件中的内容插入到 `test.c` 中

#### 2. 编译

```shell
> gcc -S ./test.i -o ./test.s
```

`-S`: 让编译器在编译生成汇编代码后停止。

#### 3. 汇编

```shell
> gcc -c ./test.s -o ./test.o
```

`-c`: 让编译器在汇编生成机器码后停止。

#### 4. 链接

```shell
> gcc ./test.o -o test
# 将 test.o 文件与 C 标准输入输出库进行链接，生成 test 程序
```

## Debug

### pedantic

`-pedantic`: 能够发现一些不符合 ANSI/ISO C 标准的代码，但不是全部。只有 ANSI/ISO C 语言标准中要求进行编译器诊断的那些情况，才会被 GCC 发现并提出警告。

```shell
> gcc -pedantic test.c -o test
```

### Wall

除了 `-pedantic` 之外，Gcc 还有一些编译选项也能够产生有用的警告信息。

这些选项大多以 `-W` 开头，其中最有价值的当数 `-Wall` 了，使用它能够使 GCC 产生尽可能多的警告信息。

```shell
> gcc -Wall test.c -o test
```

### Werror

GCC 给出的警告信息虽然从严格意义上说不能算作错误，但却很可能成为错误的栖身之所。

一个优秀的 Linux 程序员应该尽量避免产生警告信息，使自己的代码始终保持标准、健壮的特性。

所以将警告信息当成编码错误来对待，是一种值得赞扬的行为!

在编译程序时带上 `-Werror` 选项，那么GCC会在所有产生警告的地方停止编译，迫使程序员对自己的代码进行修改。

```shell
> gcc -Werror test.c -o test
```
