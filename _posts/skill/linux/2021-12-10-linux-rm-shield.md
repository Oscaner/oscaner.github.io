---
layout: post
title: "Linux 屏蔽 rm 命令"
date: 2021-12-10 10:00
author: "Oscaner"
header-img: "assets/img/post-bg-alitrip.jpg"
multilingual: false
mathjax: false
no-catalog: true
categories:
  - skill
  - linux
  - trash
tags:
  - Skill
  - Linux
  - Trash
---

总是在一些沙雕群里能看到有人说要 `sudo rm -rf /` 然后跑路。

虽然这只是一句玩笑话，但也实实在在说明一个问题，每个开发者总会有思路不清晰的时候，有时候手快就真的 `sudo rm` 了呢。

那么，是不是可以把 `rm` 命令屏蔽，替换为类似回收站的功能呢？

于是我去研究了一下。下面就是我的思路。

1. Linux

    [Trash-Cli : Command line interface for Trash in Linux](https://www.2daygeek.com/trash-cli-command-line-trashcan-linux-system/){:target="_blank"}{:rel="nofollow"}

    ```shell
    # Ubuntu
    $ sudo apt install trash-cli
    # RHEL/CentOS
    $ sudo yum install trash-cli
    # Fedora
    $ sudo dnf install trash-cli
    # Arch
    $ sudo pacman -S trash-cli
    # openSUSE
    $ sudo zypper in trash-cli
    # or use pip
    $ sudo pip install trash-cli
    # Set alias.
    $ echo 'alias rm=trash-put' >> ~/.bashrc
    $ source ~/.bashrc
    ```

    使用 `alias` 将 `rm` 替换为 `trash-put` 命令。


2. macOS

    [sindresorhus/macos-trash](https://github.com/sindresorhus/macos-trash){:target="_blank"}{:rel="nofollow"}

    ```shell
    $ brew install macos-trash
    # Set alias
    $ echo 'alias rm=trash' >> ~/.bashrc
    $ source ~/.bashrc
    ```

    使用 `alias` 将 `rm` 替换为 `trash` 命令。

3. Windows

    Hummmmm, windows 应该没有这个困扰。(确信脸


为了防止污染系统根的 `bashrc`，所以只写在了 Home 下的 `~/.bashrc` 里。

如果想要屏蔽系统根的 `rm`，请写到 `/etc/bashrc`

此时如果你想真正删除一个文件，可以写一个 `realrm` 命令去使用。

```shell
> echo 'alias realrm="/bin/rm $@"' >> ~/.bashrc
> source ~/.bashrc
```
