---
layout: post
title: "MySQL - 常用语法及函数"
subtitle: "MySQL 开发中常用的一些语法及函数归总"
date: 2018-08-05 22:18
author: "Oscaner"
header-img: "assets/img/post-bg-alitrip.jpg"
multilingual: false
mathjax: false
no-catalog: false
categories:
  - skill
  - sql
  - mysql
  - syntax
tags:
  - Skill
  - SQL
  - MySQL
  - Syntax
---

## 常用语法

### 插入数据

#### 1. 插入数据

```sql
> INSERT INTO <TABLE_NAME>(id, FIELD1, FIELD2, ...) VALUES(NULL, VALUE1, VALUE2, ...), (NULL, VALUE1, VALUE2, ...), ...;
-- 插入多条数据
-- 主键ID为自增字段，直接NULL即可
```

#### 2. 插入检索出来的数据

```sql
> INSERT INTO <TABLE_NAME_1>(FIELD3, FIELD4, ...) SELECT FIELD1, FIELD2, ... FROM <TABLE_NAME_2>;
-- 从 <数据表2> 查询 <字段名1> <字段名2> <...> 的值插入 <数据表1> 的 <字段名3> <字段名4> <...>
```

### 更新数据

```sql
> UPDATE <TABLE_NAME> SET FIELD=VALUE [WHERE CONDITIONS];
-- 不加条件则更新整个数据表数据
```

### 删除数据

```sql
> DELETE FROM <TABLE_NAME> [WHERE CONDITIONS];
-- 不加条件则删除整张表的数据，但自增字段不会重新开始
> TRUNCATE TABLE <TABLE_NAME>;
-- 清空数据表，自增字段重新从1开始
```

### 查询数据

```sql
> SELECT <FIELD> FROM <TABLE_NAME>;
> SELECT * FROM <TABLE_NAME>;
```

### 条件控制

#### 1. WHERE 语句

```sql
> SELECT * FROM <TABLE_NAME> WHERE id=3;
-- 从数据表查询id=3的所有字段数据
```

#### 2. HAVING 语句

```sql
> SELECT * FROM <TABLE_NAME> GROUP BY <FIELD> HAVING <CONDITIONS>;
-- 根据 <字段名> 分组并筛选出达到 <条件> 的组

-- 举个例子：有数据表user
+----------------------+
|user_name| dept| score|
+----------------------+
|zhangsan |sales|    90|
|lisi     |sales|    90|
|wangfei  |IT   |    89|
|leifeng  |IT   |    95|
|gouzi    |hr   |    92|
+----------------------+
> SELECT dept, COUNT(user_name) count_tmp FROM user WHERE score>89 GROUP BY dept HAVING count_tmp>1;
-- 先查出 score>89 的员工纪录
-- 根据 dept 分组（GROUP BY dept)
-- 再用 count 聚合函数统计部门人数
-- 最后筛选出部门总人数大于1人的部门
```

## 常用函数

### 数学函数

数学函数主要用于处理数字，包括整形. 浮点数等。

| 函数 | 说明 |  ||
| :-- | :-- | :-- | :-- |
| ABS(x)   | 返回x的绝对值 | `ABS(-1) = 1` ||
| CEIL(x), <br> CEILING(x) | 返回大于或等于x的最小整数 | `CEIL(1.5) = 2` ||
| FLOOR(x) | 返回小于或等于x的最大整数 | `FLOOR(1.5) = 1` ||
| RAND()   | 返回0->1的随机数 |  ||
| RAND(x)  | 返回0->x的随机数，x值相同时返回的随机数相同 |  ||
| SIGN(x)  | 返回x的符号，x是负数. 0. 正数分别返回-1. 0. 1 | `SIGN(-10) = -1` ||
| PI()     | 返回圆周率(3.141593) | `PI() = 3.141593` ||
| TRUNCATE(x,y) | 返回数值x保留到小数点后y位的值(与ROUND最大的区别是不会进行四舍五入) | `TRUNCATE(1.23456, 3) = 1.234` ||
| ROUND(x) | 返回离x最近的整数 | `ROUND(1.23456) = 1` ||
| ROUND(x,y) | 保留小数点后y位的值，但截断时要进行四舍五入 | `ROUND(1.23456, 3) = 1.235` ||
| POW(x,y), <br> POWER(x,y) | 返回x的y次方 | `POW(2, 3) = 8` ||
| SQRT(x)  | 返回x的平方根 | `SQRT(25) = 5` ||
| EXP(x)   | 返回e的x次方 | `EXP(3) = 20.085536923188` ||
| MOD(x,y) | 返回x除以y以后的余数 | `MOD(5, 2) = 1` ||
| LOG(x)   | 返回自然对数(以e为底的对数) | `LOG(20.085536923188 ) = 3` ||
| LOG10(x) | 返回以10为底的对数 | `LOG10(100) = 2` ||
| RADIANS(x) | 将角度转换为弧度 | `RADIANS(180) = 3.1415926535898` ||
| DEGREES(x) | 将弧度转换为角度 | `DEGREES(3.1415926535898 ) = 180` ||
| SIN(x)   | 求正弦值(参数是弧度) | `SIN(RADIANS(30)) = 0.5` ||
| ASIN(x)  | 求反正弦值(参数是弧度) |  ||
| COS(x)   | 求余弦值(参数是弧度) |  ||
| ACOS(x)  | 求反余弦值(参数是弧度) |  ||
| TAN(x)   | 求正切值(参数是弧度) |  ||
| ATAN(x), <br> ATAN2(x) | 求反正切值(参数是弧度) |  ||
| COT(x)   | 求余切值(参数是弧度) |  ||

### 字符串函数

字符串函数是MySQL中最常用的一类函数，字符串函数主要用于处理表中的字符串。

| 函数 | 说明 |  ||
| :-- | :-- | :-- | :-- |
| CHAR_LENGTH(s) | 返回字符串s的字符数 | `CHAR_LENGTH('你好123') = 5` ||
| LENGTH(s)      | 返回字符串s的长度 | `LENGTH('你好123') = 9` ||
| CONCAT(s1, s2,...) | 将字符串s1,s2等多个字符串合并为一个字符串 | `CONCAT('12', '34') = 1234` ||
| CONCAT_WS(x, s1, s2,...) | 同CONCAT(s1,s2,...)函数，但是每个字符串直接要加上x | `CONCAT_WS('@', '12', '34') = 12@34` ||
| INSERT(s1, x, len, s2)   | 将字符串s2替换s1的x位置开始长度为len的字符串 | `INSERT('12345', 1, 3, 'abc') = abc45` ||
| UPPER(s), <br> UCAASE(s) | 将字符串s的所有字母变成大写字母 | `UPPER('abc') = ABC` ||
| LOWER(s), <br> LCASE(s)  | 将字符串s的所有字母变成小写字母 | `LOWER('ABC') = abc` ||
| LEFT(s, n)  | 返回字符串s的前n个字符 | `LEFT('abcde', 2) = ab` ||
| RIGHT(s, n) | 返回字符串s的后n个字符 | `SRIGHT('abcde', 2) = de` ||
| LPAD(s1, len, s2) | 字符串s2来填充s1的开始处，使字符串长度达到len | `LPAD('abc', 5, 'xx') = xxabc` ||
| RPAD(s1,len,s2)   | 字符串s2来填充s1的结尾处，使字符串的长度达到len | `RPAD('abc', 5, 'xx') = abcxx` ||
| LTRIM(s) | 去掉字符串s开始处的空格 |  ||
| RTRIM(s) | 去掉字符串s结尾处的空格 |  ||
| TRIM(s)  | 去掉字符串s开始和结尾处的空格 |  ||
| TRIM(s1 FROM s) | 去掉字符串s中开始处和结尾处的字符串s1 | `TRIM('@' FROM '@@abc@@') = abc` ||
| REPEAT(s, n)    | 将字符串s重复n次 | `REPEAT('ab', 3) = ababab` ||
| SPACE(n)        | 返回n个空格 |  ||
| REPLACE(s, s1, s2) | 将字符串s2替代字符串s中的字符串s1 | `REPLACE('abc', 'a', 'x') = xbc` ||
| STRCMP(s1,s2)   | 比较字符串s1和s2 |  ||
| SUBSTRING(s, n, len) | 获取从字符串s中的第n个位置开始长度为len的字符串 |  ||
| MID(s, n, len)  | 同SUBSTRING(s,n,len) |  ||
| LOCATE(s1,s), <br> POSITION(s1 IN s) | 从字符串s中获取s1的开始位置 | `LOCATE('b', 'abc') = 2` ||
| INSTR(s, s1)    | 从字符串s中获取s1的开始位置 | `INSTR('abc', 'b') = 2` ||
| REVERSE(s)      | 将字符串s的顺序反过来 | `REVERSE('abc') = cba` ||
| ELT(n, s1, s2,...)   | 返回第n个字符串 | `ELT(2, 'a', 'b', 'c') = b` ||
| EXPORT_SET(x,s1,s2)  | 返回一个字符串，在这里对于在“bits”中设定每一位，你得到一个“on”字符串，并且对于每个复位(reset)的位，你得到一个 “off”字符串。每个字符串用“separator”分隔(缺省“,”)，并且只有“bits”的“number_of_bits” (缺省64)位被使用 | `EXPORT_SET(5, 'Y', 'N', ',', 4) = Y,N,Y,N` ||
| FIELD(s, s1, s2...)  | 返回第一个与字符串s匹配的字符串位置 | `FIELD('c', 'a', 'b', 'c') = 3` ||
| FIND_IN_SET(s1, s2)  | 返回在字符串s2中与s1匹配的字符串的位置 |  ||
| SUBSTRING_INDEX(str, delim, count) | 返回从字符串str的第count个出现的分隔符delim之后的子串。如果count是正数，返回第count个字符左边的字符串。如果count是负数，返回第(count的绝对值(从右边数))个字符右边的字符串。 | `SUBSTRING_INDEX('a*b', '*', 1) = a` ||
| LOAD_FILE(file_name) | 读入文件并且作为一个字符串返回文件内容。文件必须在服务器上，你必须指定到文件的完整路径名，而且你必须有file权 限。文件必须所有内容都是可读的并且小于max_allowed_packet。 如果文件不存在或由于上面原因之一不能被读出，函数返回NULL。 |  ||

### 日期时间函数

MySQL的日期和时间函数主要用于处理日期时间。


| 函数 | 说明 |  ||
| :-- | :-- | :-- | :-- |
| CURDATE(), <br> CURRENT_DATE() | 返回当前日期 |  ||
| CURTIME(), <br> CURRENT_TIME() | 返回当前时间 |  ||
| NOW(), <br> CURRENT_TIMESTAMP(), <br> LOCALTIME(), <br> SYSDATE(), <br> LOCALTIMESTAMP() | 返回当前日期和时间 |  ||
| UNIX_TIMESTAMP() | 以 UNIX 时间戳的形式返回当前时间 |  ||
| UNIX_TIMESTAMP(d) | 将日期 d 以 UNIX 时间戳的形式返回 | `UNIX_TIMESTAMP ('2011-11-11 11:11:11') = 1320981071` ||
| FROM_UNIXTIME(d) | 将 UNIX 时间戳的时间转换为普通格式的时间 | `FROM_UNIXTIME (1320981071) = 2011-11-11 11:11:11` ||
| UTC_DATE() | 返回 UTC 日期 |  ||
| UTC_TIME() | 返回 UTC 时间 |  ||
| MONTH(d) | 返回日期 d 中的月份值 | 范围是 `1->12` ||
| MONTHNAME(d) | 返回日期 d 当中的月份名称 | 如 `Janyary` ||
| DAYNAME(d) | 返回日期 d 是星期几 | 如 `Monday`, `Tuesday` ||
| DAYOFWEEK(d) | 日期 d 是星期几 | 1 表示星期日，2 表示星期一 ||
| WEEKDAY(d) | 日期 d 是星期几 | 0 表示星期一，1 表示星期二 ||
| WEEK(d)， <br> WEEKOFYEAR(d) | 计算日期 d 是本年的第几个星期， | 范围是 `0->53` ||
| DAYOFYEAR(d) | 计算日期 d 是本年的第几天 |  ||
| DAYOFMONTH(d) | 计算日期 d 是本月的第几天 |  ||
| QUARTER(d) | 返回日期 d 是第几季节 | 返回 `1->4` ||
| HOUR(t) | 返回 t 中的小时值 |  ||
| MINUTE(t) | 返回 t 中的分钟值 |  ||
| SECOND(t) | 返回 t 中的秒钟值 |  ||
| EXTRACT(type FROM d) | 从日期 d 中获取指定的值，type 指定返回的值。<br />type 可取值为：<br />1. MICROSECOND<br />2. SECOND. MINUTE<br />3. HOUR<br />4. DAY<br />5. WEEK<br />6. MONTH<br />7. QUARTER<br />8. YEAR<br />9. SECOND_MICROSECOND<br />10. MINUTE_MICROSECOND<br />11. MINUTE_SECOND<br />12. HOUR_MICROSECOND<br />13. HOUR_SECOND<br />14. HOUR_MINUTE<br />15. DAY_MICROSECOND<br />16. DAY_SECOND<br />17. DAY_MINUTE<br />18. DAY_HOUR<br />19. YEAR_MONTH |  ||
| TIME_TO_SEC(t) | 将时间 t 转换为秒 |  ||
| SEC_TO_TIME(s) | 将以秒为单位的时间 s 转换为时分秒的格式 |  ||
| TO_DAYS(d) | 计算日期 d 距离 0000 年 1 月 1 日的天数 |  ||
| FROM_DAYS(n) | 计算从 0000 年 1 月 1 日开始 n 天后的日期 |  ||
| DATEDIFF(d1, d2) | 计算日期 d1->d2 之间相隔的天数 |  ||
| ADDDATE(d, n) | 计算起始日期 d 加上 n 天的日期 | `ADDDATE('2011-11-11 11:11:11', 1) = 2011-11-12 11:11:11` ||
| ADDDATE(d，INTERVAL expr type) | 计算起始日期 d 加上一个时间段后的日期 | `ADDDATE ('2011-11-11 11:11:11', INTERVAL 5 MINUTE) = 2011-11-11 11:16:11` ||
| DATE_ADD(d, INTERVAL expr type) | 同上 |  ||
| SUBDATE(d, n) | 日期 d 减去 n 天后的日期 |  ||
| SUBDATE(d, INTERVAL expr type) | 日期 d 减去一个时间段后的日期 |  ||
| ADDTIME(t, n) | 时间 t 加上 n 秒的时间 |  ||
| SUBTIME(t, n) | 时间 t 减去 n 秒的时间 |  ||
| DATE_FORMAT(d, f) | 按表达式 f 的要求显示日期 d | `DATE_FORMAT ('2011-11-11 11:11:11', '%Y-%m-%d %r') = 2011-11-11 11:11:11 AM` ||
| TIME_FORMAT(t, f) | 按表达式 f 的要求显示时间 t | `TIME_FORMAT ('11:11:11', '%r') = 11:11:11 AM` ||
| GET_FORMAT(type, s) | 获得国家地区时间格式函数 | `GET_FORMAT (date, 'usa') = %m.%d.%Y` ||

### 条件判断函数

#### 1. IF(expr, v1, v2)函数

如果表达式 expr 成立，返回结果 v1；否则，返回结果 v2

```sql
> SELECT IF(1 > 0, 'YES', 'NO')
-- return: YES
```

#### 2. IFNULL(v1, v2)函数

如果 v1 的值不为 NULL，则返回 v1，否则返回 v2

```sql
> SELECT IFNULL(null, 'Hello Word')
-- return: Hello Word
```

#### 3. CASE

```sql
> SELECT CASE
    WHEN e1
    THEN v1
    WHEN e2
    THEN v2
    ...
    ELSE vn
  END
```

CASE 表示函数开始，END表 示函数结束。如果 e1 成立，则返回 v1；如果 e2 成立，则返回 v2。当有一个成立，后面的都不执行；当都不成立，则返回 vn。

```sql
> SELECT CASE expr
    WHEN e1 THEN v1
    WHEN e2 THEN v2
    ...
    ELSE vn
  END
```

如果表达式 expr 的值等于 e1，返回 v1；如果等于 e2，则返回 e2.否则返回 vn。

### 系统信息函数

系统信息函数用来查询 MySQL 数据库的系统信息

| 函数 | 说明 |
| :-- | :-- |
| VERSION() | 返回数据库的版本号 |
| CONNECTION_ID() | 返回服务器的连接数 |
| DATABASE()<br />SCHEMA() | 返回当前数据库名 |
| USER()<br />SYSTEM_USER()<br />SESSION_USER()<br />CURRENT_USER()<br />CURRENT_USER() | 返回当前用户 |
| CHARSET(str) | 返回字符串 str 的字符集 |
| COLLATION(str) | 返回字符串 str 的字符排列方式 |
| LAST_INSERT_ID() | 返回最近生成的 AUTO_INCREMENT 值 |

### 加密函数

加密函数是 MySQL 用来对数据进行加密的函数

#### 1. PASSWORD

该函数可以对字符串 str 进行加密，一般情况下，`PASSWORD(str)` 用于给用户的密码加密

```sql
> SELECT PASSWORD('123')
-- return: *23AE809DDACAF96AF0FD78ED04B6A265E05AA257
```

#### 2. MD5

`MD5(str)` 函数可以对字符串str进行散列，可以用于一些普通的不需要解密的数据加密

```sql
> SELECT MD5('123')
-- return: 202cb962ac59075b964b07152d234b70
```

#### 3. ENCODE 与 DECODE

`ENCODE(str, pswd_str)` 函数可以使用加密密码 pswd_str 来加密字符串 str，加密结果是二进制数，需要使用 BLOB 类型的字段保存。
该函数与 `DECODE(crypt_str, pswd_str)` 是一对，需要同样的密码才能够解密

```sql
> SELECT ENCODE('123', 'xxoo')
-- return: ;vx
> SELECT DECODE(';vx','xxoo')
-- return: 123
```

### 其他函数

#### 1. 格式化函数 FORMAT

`FORMAT(x, n)` 函数可以将数字 x 进行格式化，将 x 保留到小数点后 n 位

```sql
> SELECT FORMAT(3.1215926, 3)
-- return: 3.142
```

#### 2. 不同进制的数字进行转换

- `ASCII(s)` 返回字符串s的第一个字符的 ASCII 码；
- `BIN(x)` 返回 x 的二进制编码；
- `HEX(x)` 返回 x 的十六进制编码；
- `OCT(x)` 返回 x 的八进制编码；
- `CONV(x, f1, f2)` 返回 f1 进制数变成 f2 进制数；

#### 3. IP 地址与数字相互转换的函数

- `INET_ATON(IP)` 函数可以将 IP 地址转换为数字表示；
- `INET_NTOA(n)` 函数可以将数字 n 转换成 IP 形式

```sql
> SELECT INET_ATON('192.168.0.1')
-- return: 3232235521
> SELECT INET_NTOA(3232235521)
-- return: 192.168.0.1
```

#### 4. 加锁函数和解锁函数


- `GET_LOCK(name, time)` 函数定义一个名称为 name. 持续时间长度为 time（单位秒）的锁。如果锁定成功，则返回 1；如果尝试超时，则返回 0；如果遇到错误，返回 NULL；
- `RELEASE_LOCK(name)` 函数解除名称为 name 的锁。如果解锁成功，则返回1；
- `IS_FREE_LOCK(name)` 函数判断是否已使用名为 name 的锁定。如果使用，返回 0；否则，返回 1；

```sql
> SELECT GET_LOCK('MySQL', 10)
-- return: 1 (持续 10 秒)
> SELECT IS_FREE_LOCK('MySQL')
-- return: 1
> SELECT RELEASE_LOCK('MySQL')
-- return: 1
```

#### 5. 重复执行指定操作的函数

`BENCHMARK(count, expr)` 函数将表达式 expr 重复执行 count 次，然后返回执行时间。该函数可以用来判断 MySQL 处理表达式的速度。

```sql
> SELECT BENCHMARK(10000, NOW())
-- return: 0 (返回系统时间 1 万次)
```

#### 6. 改变字符集的函数

`CONVERT(s USING cs)` 函数将字符串s的字符集编程 cs

```sql
> SELECT CHARSET('ABC')
-- return: utf-8
> SELECT CHARSET(CONVERT('ABC' USING gbk))
-- return: gbk
```

#### 7. 转换数据类型

- `CAST(x AS type)`
- `CONVERT(x, type)`

这两个函数只对 `BINARY`, `CHAR`, `DATE`, `DATETIME`, `TIME`, `DECIMAL`, `SIGNED`, `UNSIGNED` 有效。

```sql
> SELECT CAST('123' AS UNSIGNED INTEGER) + 1
-- return: 124
> SELECT '123' + 1
-- return: 124 (其实 MySQL 能默认转换)
> SELECT CAST(NOW() AS DATE)
-- return: 2014-12-18
```
