---
layout: post
title: "Node.js - 环境设置"
date: 2018-09-11 23:10
author: "Oscaner"
header-img: "img/post-bg-alitrip.jpg"
multilingual: false
mathjax: false
no-catalog: false
categories:
  - skill
  - node.js
  - npm
tags:
  - Skill
  - Node.js
  - NPM
---

## 第一步 - 安装

### Windows

[下载地址](http://nodejs.cn/download/){:target="_blank"}{:rel="nofollow"}

下载 Node.js 并安装， 默认安装就行了.

### MacOS

利用 `brew` 进行安装

```shell
> brew install nvm
> nvm install node && nvm alias default node
```

### Ubuntu

```shell
> sudo apt install curl
> curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash
> nvm install node && nvm alias default node
```

## 第二步 - 查看版本

```shell
> node -v
# v16.3.0
> npm -v
# 7.15.1
```

![node-version.png](/img/in-post/skill/js/post-node-setup/node-version.png)

## 第三步 - 淘宝镜像 (可选)

如果用 npm 安装 package 经常卡住，有可能是网络问题，镜像源在国外。

可以安装淘宝镜像来避免此类问题。

```shell
$ npm install cnpm -g --registry https://registry.npm.taobao.org
$ cnpm -v
# cnpm@6.2.0
# npm@6.14.13
# node@16.3.0
# npminstall@3.28.0
# prefix=xxx
# darwin x64 20.5.0
# registry=https://registry.nlark.com
```
