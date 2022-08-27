---
layout: post
title: "Linux 正则"
date: 2018-12-08 18:51
author: "Oscaner"
header-img: "assets/img/post-bg-alitrip.jpg"
multilingual: false
mathjax: false
no-catalog: false
categories:
  - skill
  - linux
  - regular
tags:
  - Skill
  - Linux
  - Regular
---

| 元字符 | 说明 | 示例 |
| :--: | :-- | :-- |
| `*` | 匹配 * 前面的那个字符的 0 次或多次 | `hel*o` => heo, helo, hello, helll0, ... |
| `.` | 匹配任意一个字符 (只匹配一个，可以是空格) | `ab.` => abc, abd, ab3, ab, ... |
| `^` | 匹配行首，行首的字符序列必须是 ^ 后的字符序列 | `^suda` => sudahuhuhuuuu, sudasdafjda, ... |
| `$` | 匹配行尾，行尾的字符序列必须是 $ 前的字符序列 | `suda$` => asdfasuda, jlkowwsuda, ... |
| `^$` | 匹配一个空行 | |
| `^.$` | 匹配只有一个字符的空行 | |
| `[]` | 匹配字符集合中的任意一个字符 (只匹配一个) | \\`[1-4]\\` => 匹配 1 至 4 中的任意一个数字 \
| | | \`[^1-4]\` => 匹配不是 1 至 4 的任意一个数字 \
| | | `[a-z][A-Z]*` => 匹配任意一个英文单词 |
| `\\` | 用于转义元字符，使之称为普通字符 | `\\*` => 此时 * 表示一个普通字符 |
| `<>` | 用于精确匹配 | `<the>` => 表示精确匹配 the 这个单词 |
| `{}` | 系列匹配 | \`JO{3}B\` => JOOOB \
| | | \`JO{3,}B\` => JOOOB, JOOOOB, ... \
| | | `JO{3,6}B` => JOOOB, JOOOOB, JOOOOOB, JOOOOOOB |
| `?` | 匹配前面的那一个字符 0 次或 1 次 | `JO?B` => JB, JOB |
| `+` | 匹配前面字符的 1 次或多次 | `JO+B` => JOB, JOOB, JOOOB, ... |
| `｜` | 与 () 结合使用，表示一组可选的字符集合 | `re(a｜o｜e)d` => read, reod, reed |
