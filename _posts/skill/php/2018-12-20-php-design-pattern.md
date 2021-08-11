---
layout: post
title: "PHP 面向对象与设计模式"
date: 2018-12-20 15:53
author: "Oscaner"
header-img: "img/post-bg-alitrip.jpg"
multilingual: false
mathjax: false
no-catalog: false
categories:
  - skill
  - php
tags:
  - Skill
  - PHP
---

## 设计模式

设计模式指, 提供一种广泛的可重用的方式来解决我们日常开发中遇到的问题。

设计模式并不一定就是一个类库或者第三方框架, 它们更多的表现为一种思想, 并且广泛地应用在系统之中。

它们也表现为一种模式或者模块, 可以在多个不同地场景下用于解决问题。

设计模式可以用于加速开发, 并且将很多大的想法或者设计, 以一种简单的方式实现。

当然, 虽然设计模式在开发中很有作用, 但是千万要避免在不适当的场景误用它们。

通俗的讲, 在软件开发过程中, 应用于经常出现的典型场景中的、可复用的典型解决方案, 称之为设计模式。

如何学习设计模式? `典型场景->典型问题->典型解决方法`

## 多态

所谓多态, 就是指同一个东西以不同形态展示。它是面向对象程序设计 (OOP) 的一个重要特征。

如果一个语言只支持类而不支持多态, 只能说明它是基于对象, 而非面向对象。

多态的实现常体现为**在子类重写父类方法**。

## 面向接口开发

在一个面向对象的系统中, 系统的各种功能是由许许多多的不同对象协作完成的。

在这种情况下, 各个对象内部是如何实现的, 对于系统设计人员来说就显得不那么重要, 而各个对象之间的协作关系则成为系统设计的关键。

小到不同类之间的通信, 大到各个模块之间的交互, 在系统设计之初都是要着重考虑的, 这也是系统设计的主要工作内容。

而面向接口开发就是指按照这种思路来实现。

### 关于接口的理解

接口从更深层次的理解, 应是定义 (规范/约束) 与实现 (名实分离的原则) 的分离。

接口本身反映了系统设计人员对系统的抽象理解。

接口应有两类:

第一类是对个体的抽象, 它对应为一个抽象体 (Abstract Class);

第二类是对个体某一方面的抽象, 即形成一个抽象面 (Interface) 。

其中, 一个体可能有多个抽象面, 抽象体和抽象面是有区别的。

### 接口所处环境

环境是系统要素所处的空间与外部影响因素的总和, 任何接口都是在一定的环境中产生的。

因此环境的定义及环境的变化对接口的影响是不容忽视的, 脱离原先的环境, 所有的接口都将失去原有的意义。

### 开发模型

按照组件的开发模型 (3C), 它们三者相辅相成, 各司一面, 浑然一体, 缺一不可。

面向对象: 我们考虑问题时, 以对象为单位, 考虑它的属性及方法。

面向过程: 我们考虑问题时, 以一个具体的流程 (事务过程) 为单位, 考虑它的实现。

接口设计与非接口设计是争对复用技术而言的, 与面向对象 (过程) 不是一个问题。

```php
<?php
// 定义一个 Db 接口
interface Db {

  // 连接数据库
  function conn();

}
```

## 简单工厂模式

简单工厂模式 (Simple Factory), 又叫做静态工厂方法模式 (Static Factory Method)

```php
// 接续上面的 Db 接口
class DbMysql implements Db {

  public function conn() {
    echo '我用 Mysql 方式帮你连上了数据库';
  }

}

class DbSqlite implements Db {

  public function conn() {
    echo '我用 Sqlite 方式帮你连上了数据库';
  }

}
```

此时我们并不知道类 `DbMysql` 和 `DbSqlite` 的内部细节

通过 Db 接口只能知道, 这两个类内部都定义了 `conn()` 方法, 于是调用之

```php
$db = new DbMysql();
$db->conn();

$dbi = new DbSqlite();
$dbi->conn();
```

但是, 对于使用者来说, 开放的还是过于多 (为了连接个数据库, 我还要记住那么多类, 好烦)

而且, 若以后还要添加其他连接方式, 使用者需要记住的类越来越多, 这不便于使用者使用

于是就出现了**简单工厂模式** (让使用者知道的越少越好, 最好一个方法搞定所有数据库连接)

```php
class Factory {

  public static function createDb($type) {
    switch ($type) {
      case 'Mysql':
        return new DbMysql();
        break;
      case 'Sqlite':
        return new DbSqlite();
        break;
      default:
        throw new Exception('The type is error!', 1);
        break;
    }
  }

}
```

现在, 使用者连具体有哪些类都不需要知道了,

只需要知道有一个 `Factory::createDb()` 方法传参即可创建相应类

```php
$mysql = Factory::createDb('Mysql');
$mysql->conn();

$sqlite = Factory::createDb('Sqlite');
$sqlite->conn();
```

至此, 简单工厂模式便完成了。

## 工厂方法模式

接续上面的简单工厂模式, 如果新增 Oracle 类型, 怎么办?

服务端修改 Factory 的代码?

这在 PHP 中很容易实现, 但是在 Java/C++ 中, 就显得并不容易。

因为 Java/C++ 修改以后还要编译, 一个大项目编译十来分钟一小时都是有可能的。

于是, 在面向对象设计法则中, 出现了一个重要的开闭原则 — 对于修改源码是封闭的, 对于功能扩展是开放的。

从这里就引出了**工厂方法模式 (Factory Method)**, 又叫做**多态性工厂模式 (Polymorphic Factory)**

```php
// 删除之前的 Factory 类, 然后定义工厂接口
interface Factory {

  function createDb();

}
```

根据工厂接口定义各个数据库工厂类

```php
class MysqlFactory implements Factory {

  public function createDb() {
    return new DbMysql();
  }

}

class SqliteFactory implements Factory {

  public function createDb() {
    return new DbSqlite();
  }

}
```

之后使用者开始调用

```php
$fact = new MysqlFactory();
$db = $fact->createDb();
$db->conn();

$fact = new SqliteFactory();
$db = $fact->createDb();
$db->conn();
```

此时新增一个 Oracle 数据库连接, 只需添加如下代码, 而无需修改上面代码

```php
class DbOracle implements Db {

  public function conn() {
    echo '我用 Oracle 方式帮你连上了数据库';
  }

}

class OracleFactory implements Factory {

  public function createDb() {
    return new DbOracle();
  }

}
```

至此, 就实现了工厂方法模式。

## 单例模式

单例模式是一种常见的软件设计模式。在它的核心结构中只包含一个被称为单例的特殊类。

通过单例模式可以保证系统中一个类只有一个实例, 即一类只有一个对象实例。

1. 第一步, 普通类实现

    ```php
    <?php
    class Single {

    }

    $s1 = new Single();
    $s2 = new Single();

    echo $s1 === $s2 ? '是一个对象' : '不是一个对象';
    ```

2. 第二步, 封锁 new 操作

    ```php
    class Single {

      protected function __construct() {}

    }

    $s1 = new Single();
    ```

3. 第三步, 预留接口用于 new 对象

    ```php
    class Single {

      public static function getNew() {
          return new self();
      }

      protected function __construct() {}

    }

    $s1 = Single::getNew();
    $s2 = Single::getNew();

    echo $s1 === $s2 ? '是一个对象' : '不是一个对象';
    ```

4. 第四步, getNew() 判断实例, 实现一类只有一个对象实例

    ```php
    class Single {

      protected static $new = null;

      public static function getNew() {
        return self::$new = self::$new ?: new self(); // 这是 PHP7 的语法
        // 相当于 self::$new = self::$new ? self::$new : new self();
      }

      protected function __construct() {}

    }

    $s1 = Single::getNew();
    $s2 = Single::getNew();

    echo $s1 === $s2 ? '是一个对象' : '不是一个对象';
    ```

5. 第五步, 防继承修改权限

    ```php
    class Single {

      protected static $new = null;

      public static function getNew() {
        return self::$new = self::$new ?: new self();
      }

      // 方法前加 final, 则方法继承后不能被重写
      final protected function __construct() {}

    }

    class Demo extends Single {

      public function __construct() {}

    }

    $s1 = new Demo();
    $s2 = new Demo();

    echo $s1 === $s2 ? '是一个对象' : '不是一个对象';
    ```

6. 第六步, 防克隆 (clone)

    ```php
    class Single {

      protected static $new = null;

      public static function getNew() {
          return self::$new = self::$new ?: new self();
      }

      final protected function __construct() {}

      final protected function __clone() {}

    }

    $s1 = Single::getNew();
    $s2 = clone $s1;

    echo $s1 === $s2 ? '是一个对象' : '不是一个对象';
    ```

## 观察者模式

当一个对象的状态发生改变时, 依赖它的对象会全部收到通知, 并自动更新。

场景: 一个事件发生后, 要执行一连串更新操作。传统的编程方式, 就是在事件之后直接加入处理逻辑, 当更新的逻辑增多之后, 代码也将变得难以维护。这种方式具有强烈的耦合性、侵入性, 增加新的逻辑需要改变事件主题的代码。而观察者模式实现了低耦合、非侵入性的通知与更新机制。

1. 被观察对象接口 (该接口 PHP-SPL 标准库中有提供, 无需自定义)

    ```php
    interface SplSubject {

      // 添加 (注册) 一个观察者
      public function attach(SplObserver $observer);
      // 删除一个观察者
      public function detach(SplObserver $observer);
      // 当状态发生改变时, 通知所有观察者
      public function notify();

    }
    ```

2. 观察者对象接口 (该接口 PHP-SPL 标准库中有提供, 无需自定义)

    ```php
    interface SplObserver {

      // 接收到被观察者的 notify 通知时, 调用更新操作
      public function update(SplSubject $subject);

    }
    ```

3. 实现观察者模式

    ```php
    <?php
    /**
     * 观察者1号
    */
    class ObServer1 implements SplObserver {

      public function update(SplSubject $subject) {
        echo "观察者 1 号更新, 当前 name 为 " . $subject->getName() . "\n";
      }

    }

    /**
     * 观察者2号
    */
    class ObServer2 implements SplObserver {

      public function update(SplSubject $subject) {
        echo "观察者 2 号更新, 当前 name 为 " . $subject->getName() . "\n";
      }

    }

    /**
     * 被观察者
    */
    class Subject implements SplSubject {

      // 注册进来的观察者们
      private $_observers;

      private $_name;

      public function __construct($name) {
        $this->_observers = new SplObjectStorage(); // 注册对象容器, 用于存放观察者们
        $this->_name = $name;
      }

      // 添加观察者
      public function attach(SplObserver $observer) {
        $this->_observers->attach($observer);
      }

      // 删除观察者
      public function detach(SplObserver $observer) {
        $this->_observers->detach($observer);
      }

      // 通知观察者
      public function notify() {
        $this->_observers->rewind();
        foreach ($this->_observers as $observer) $observer->update($this);
      }

      // 设置 name
      public function setName($name) {
        return $this->_name = $name;
      }

      // 获取 name
      public function getName() {
        return $this->_name;
      }

    }
    ```

4. 测试

    ```php
    $observer1 = new ObServer1();
    $observer2 = new ObServer2();
    $subject = new Subject('test');

    $subject->attach($observer1);
    $subject->attach($observer2);
    $subject->notify();

    $subject->setName('new');
    $subject->notify();

    $subject->detach($observer1);
    $subject->notify();
    ```

## 责任链模式

责任链模式是一种对象的行为模式。

在责任链模式里, 很多对象由每一个对象对其下家的引用而连接起来形成一条链。

请求在这个链上传递, 直到链上的某一个对象决定处理此请求。

发出这个请求的客户端并不知道链上的哪一个对象最终处理这个请求, 这使得系统可以在不影响客户端的情况下动态的重新组织和分配责任。

1. 用责任链模式来处理举报问题

    ```php
    <?php
    /**
     * 抽象责任类
    */
    abstract class Handle {

      // 权限级别
      private $_power;

      // 后继责任对象
      private $_successor;

      // 设置权限级别
      public function setPower(int $level) {
        $this->_power = $level;
      }

      // 获取权限级别
      public function getPower() {
        return $this->_power;
      }

      // 设置后继责任对象
      public function setSuccessor(Handle $objsuccessor) {
        $this->_successor = $objsuccessor;
      }

      // 获取后继责任对象
      public function getSuccessor() {
        return $this->_successor;
      }

      // 处理请求
      abstract public function handleRequest(int $level);

    }

    /**
     * 具体责任 版主类
    */
    class Board extends Handle {

      // 处理请求
      public function handleRequest(int $level) {
        if ($level <= $this->getPower()) {
          echo '警告级别: ' . $level . " (版主删帖) \n";
        } else {
          $this->getSuccessor()->handleRequest($level);
        }
      }

    }

    /**
     * 具体责任 管理员类
    */
    class Admin extends Handle {

      // 处理请求
      public function handleRequest(int $level) {
        if ($level <= $this->getPower()) {
          echo '警告级别: ' . $level . " (管理员封账号) \n";
        } else {
          $this->getSuccessor()->handleRequest($level);
        }
      }

    }

    /**
     * 具体责任 网警类 最高责任对象
    */
    class Police extends Handle {

      // 处理请求
      public function handleRequest(int $level) {
        echo '警告级别: ' . $level . ' (网警抓起来) ';
      }

    }

    // 组装责任链
    $board = new Board();
    $board->setPower(2);

    $admin = new Admin();
    $admin->setPower(5);

    $police = new Police();
    $police->setPower(10);

    $board->setSuccessor($admin);
    $admin->setSuccessor($police);

    // 提交请求 — 举报级别 1
    $board->handleRequest(1);
    // 提交请求 — 举报级别 5
    $board->handleRequest(5);
    // 提交请求 — 举报级别 10
    $board->handleRequest(10);
    ```

## 策略模式

策略模式 (Strategy), 他定义了算法家族, 分别封装起来, 让他们之间可以互相替换, 此模式让算法的变化不会影响到使用算法的客户。

策略模式是一种定义一系列算法的方法。从概念上来看, 所有这些算法完成的都是相同的工作, 只是实现不同。

它们可以以相同的方式调用所有的算法, 减少了各种算法类与使用算法类之间的耦合。

事实上你可以将一个继承自抽象策略类的类称为具体策略, 就是策略模式中的策略1、策略2 ...

策略模式就是用来封装算法的。但在实践中, 我们发现可以用它来封装几乎任何类型的规则。

只要在分析过程中监听到需要在不同时间应用不同的业务规则, 就可以考虑使用策略模式来处理这种变化的可能性。

1. 用策略模式实现如何去上学

    ```php
    <?php
    /**
     * 抽象策略接口
    */
    interface Strategy {

      public function wayToSchool();

    }

    /**
     * 具体策略1 — 自行车
    */
    class BikeStrategy implements Strategy {

      public function wayToSchool() {
        echo '骑自行车去上学';
      }

    }

    /**
     * 具体策略2 — 公交车
    */
    class BusStrategy implements Strategy {

      public function wayToSchool() {
        echo '乘公交车去上学';
      }

    }

    /**
     * 具体策略3 — 出租车
    */
    class TaxiStrategy implements Strategy {

      public function wayToSchool() {
        echo '乘出租车去上学';
      }

    }

    /**
     * 策略环境
    */
    class StrategyContext {

      private $strategy;

      public function getStrategy($className) {
        try {
          $strategyReflection = new ReflectionClass($className);
          $this->strategy = $strategyReflection->newInstance();
        } catch (ReflectionException $e) {
          $this->strategy = '';
        }
      }

      public function goToSchool() {
        $this->strategy->wayToSchool();
      }

    }

    // 测试
    $context = new StrategyContext();
    $context->getStrategy('BusStrategy');
    $context->goToSchool();
    ```

## 装饰器模式

装饰器模式 (Decorator) 可以动态地添加修改类地功能。

一个类提供了一项功能, 如果要再修改并添加额外地功能。传统的编程模式需要写一个子类继承, 并重新实现类的方法。

使用装饰器模式, 仅需在运行时添加一个装饰器对象即可实现修改, 具有极高的灵活性。

TODO

## 适配器模式

TODO

## 桥接模式

TODO
