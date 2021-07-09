---
layout: post
title: "CentOS 7 下添加 PHP-FPM 至系统服务"
date: 2018-12-14 15:23
author: "Oscaner"
header-img: "img/post-bg-alitrip.jpg"
multilingual: false
mathjax: false
no-catalog: false
categories:
  - skill
  - php
  - linux
tags:
  - Skill
  - PHP
  - Linux
---

## 创建 Nginx 启动脚本

```shell
> vim /etc/init.d/php-fpm
```

```shell
#!/bin/sh
# chkconfig:   2345 15 95

# description:  PHP-FPM (FastCGI Process Manager) is an alternative PHP FastCGI implementation \

# with some additional features useful for sites of any size, especially busier sites.
# DateTime: 2016-09-20

# Source function library.
. /etc/rc.d/init.d/functions

# Source networking configuration.
. /etc/sysconfig/network

# Check that networking is up.
[ "$NETWORKING" = "no" ] &amp;&amp; exit 0

phpfpm="/usr/sbin/php-fpm"
prog=$(basename ${phpfpm})

lockfile=/var/lock/subsys/phpfpm

start() {
    [ -x ${phpfpm} ] || exit 5
    echo -n $"Starting $prog: "
    daemon ${phpfpm}
    retval=$?
    echo
    [ $retval -eq 0 ] &amp;&amp; touch $lockfile
    return $retval
}

stop() {
    echo -n $"Stopping $prog: "
    killproc $prog -QUIT
    retval=$?
    echo
    [ $retval -eq 0 ] &amp;&amp; rm -f $lockfile
    return $retval
}

restart() {
    configtest || return $?
    stop
    start
}

reload() {
    configtest || return $?
    echo -n $"Reloading $prog: "
    killproc ${phpfpm} -HUP
    RETVAL=$?
    echo
}

force_reload() {
    restart
}

configtest() {
    ${phpfpm} -t
}

rh_status() {
    status $prog
}

rh_status_q() {
    rh_status >/dev/null 2>&amp;1
}

case "$1" in
    start)
        rh_status_q &amp;&amp; exit 0
        $1
        ;;
    stop)
        rh_status_q || exit 0
        $1
        ;;
    restart|configtest)
        $1
        ;;
    reload)
        rh_status_q || exit 7
        $1
        ;;
    status)
        rh_status
        ;;
    *)
        echo $"Usage: $0 {start|stop|status|restart|reload|configtest}"
        exit 2
esac
```

## 设置权限

```shell
> chmod a+x /etc/init.d/php-fpm
```

## 注册服务

```shell
> chkconfig --add php-fpm
```

## 设置开机启动

```shell
> chkconfig php-fpm on
> chkconfig --list
```

## PHP-FPM

```shell
# 查看 php-fpm 状态
> systemctl status php-fpm
# 启动 php-fpm
> systemctl start php-fpm
# 停止 php-fpm
> systemctl stop php-fpm
# 重启 php-fpm
> systemctl restart php-fpm
# 重载 php-fpm 配置
> systemctl reload php-fpm
```
