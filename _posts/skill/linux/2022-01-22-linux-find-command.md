---
layout: post
title: "笔记 - Linux Find command"
date: 2022-01-22 14:12
author: "Oscaner"
header-img: "img/post-bg-alitrip.jpg"
multilingual: false
mathjax: false
no-catalog: false
categories:
  - skill
  - linux
  - find
tags:
  - Skill
  - Linux
  - Find
---

| Options | Description |
| :--: | :-- |
| -type | 查找的文件类型 \
| | `-type d`: 目录 \
| | `-type f`: 文件 \
| | `-type l`: symblink (符号连接), 通常代指软链接 \
| | `-type c`: 字符串设备文件 \
| | `-type b`:  \
| | `-type p`:  |
| -print | 打印 |
| -delete | 删除找到的文件 |
| -name, -iname | 匹配文件名, i 忽略大小写 |
| -path, -ipath | 匹配文件路径, i 忽略大小写 |
| -atime | 在 n 天以内/以外访问过 \
| | `-atime -1`: 1 天以内 \
| | `-atime +1`: 1 天以外 |
| -mtime | 在 n 天以内/以外修改过 \
| | `-mtime -1`: 1 天以内 \
| | `-mtime +1`: 1 天以外 |
| -exec | 执行命令 \
| | `-exec rm {} \;`: 删除 |
| !, -not | 逻辑取反 |
| -o, -or | 逻辑或 |
| 空, -and | 逻辑与 |
| ... | 待补充 |

## 查找文件

1. Default

    ```shell
    > find [dir] -type f
    ```

2. 查找文件名中包含 picture 的文件

    ```shell
    > find [dir] -type f -name "*picture*" -print
    ```

3. 查找文件名中包含 picture 并且文件扩展名为 png 的文件

    ```shell
    > find [dir] -type f -name "*picture*.png" -print
    # or
    > find [dir] -type f \
        \( \
          -name "*picture*" \
          -name "*.png" \
        \) \
        -print
    ```

4. 查找文件名中包含 pic1 或者 pic2 的文件

    ```shell
    > find [dir] -type f \
        \( \
          -name "*pic1*" -o \
          -name "*pic2*" \
        \) \
        -print
    ```

5. 查找 files 目录下, 文件名包含 picture 的非 png 文件

    ```shell
    > find [dir] -type f \
      \( \
        -path "*/files/*" \
        -name "*picture*" \
        ! -name "*.png"
      \) \
      -print
    ```

## 查找目录

同上, 将 `-type f` 改成 `-type d` 即可

## 删除查找到的文件或目录

同上, 在 `-print` 后面补一个 `-delete` 即可

## 未完待续
