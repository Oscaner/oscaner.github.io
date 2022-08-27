---
layout: post
title: "Drupal 配置开发"
date: 2019-06-30 14:02
author: "Oscaner"
header-img: "assets/img/post-bg-alitrip.jpg"
multilingual: false
mathjax: false
no-catalog: false
categories:
  - skill
  - php
  - drupal
tags:
  - Skill
  - PHP
  - Drupal
---

## 基本概念

配置文档见: [Configuration API overview](https://www.drupal.org/docs/8/api/configuration-api/configuration-api-overview)

配置 API 主要做配置数据的管理, 比如网站的站点名称等。

通常配置都是由开发人员创建的, 除了超级管理员可以在后台修改配置, 其它用户是没有操作权限的。

配置 API 有两种:

1. Config API
2. Configuration Entity API

其中, Config API 可以认为是一个单独的配置实例, 一般只保存简单的 Boolean 值、数字、字符串等, 如站点名称(site name)

Configuration Entity API 主要用来存储多个配置集, 例如节点类型、视图、词汇和字段等。

Drupal8 的配置信息默认是保存在数据库中, 配置文件格式是 YAML

## 配置存储

### 基础配置(hello_world.setting.yml)

以下是创建一个简单配置的示例:

```shell
> cd docroot/modules/custom/hello_world
> mkdir -p config/install
> touch config/install/hello_world.settings.yml
```

然后把以下代码写入到 `hello_world.settings.yml` 中

```yaml
some_string: 'Woo kittens!'
some_int: 42
some_bool: true
```

也可以定义一个嵌套的结构, 如:

```yaml
name: thumbnail
label: 'Thumbnail (100*100)'
effects:
  1cfec298-8620-4749-b100-ccb6c4500779:
    id: image_scale
    data:
      width: 100
      height: 100
      upscale: true
    weight: 0
    uuid: 1cfec298-8620-4749-b100-ccb6c4500779
```

也可以动态的去修改 *.setting.yml` 中的配置。

如在 `hello_world/hello_world.install` 中定义如下代码:

```php
/**
 * Implements hook_install().
 */
function hello_world_install() {
  // Set default values for config which require dynamic values.
  \Drupal::configFactory()->getEditable('hello_world.settings')
   ->set('default_form_address', \Drupal::config('system.site')->get('mail'))
   ->save();
}
```

### 可选配置

可选配置一般保存在 `config/optional` 中, 它只在依赖存在的情况下才会生效。

如 A 模块有一个可选配置依赖于 B 模块, A 模块先安装, 当安装 B 模块时, 会自动扫描 A 模块的 `config/optional`, 找到依赖并安装。

如果 B 模块没有安装, 那么 A 模块的可选配置将不会启用

核心模块中有很多的示例, 比如 `block_content` 模块中, `views.view.block_content.yml` 中有如下配置, 只列举一部分:

```yaml
langcode: en
status: true
dependencies:
  module:
    - block_content
    - user
id: block_content
label: 'Custom block library'
module: views
description: 'Find and manage custom blocks.'
tag: default
base_table: block_content_field_data
base_field: id
core: 8.x
```

### 更新配置

可以使用 `drush config-import` 这个命令把配置更新到数据库中。

首先在 `setting.php` 中找到如下配置, 如:

(`setting.php` 是 Drupal8 的配置文件, 一般是在 `sites/default` 下)

```php
$config_directories['sync'] = 'sites/default/files/config_bBkGn-0ZX0fe_fnnlVS3dmxhz7_z6guu819vcYXEpc4NtTBYgr8vB2Tqwp0t8-Oz9j71_los1g/sync';
```

接下来把 `hello_world.setting.yml` 放到这个目录下, 然后执行 `drush cim && drush cr` 命令。

访问数据库 config, 查询配置是否更新成功。

## 覆写系统配置

### 覆写 Global

Drupal8 可以使用 `$config` 这个全局变量来访问配置。

通常通过 `Drupal\Core\Config\COnfigFactory::get()` 这个 API 来获取配置的值。

比如, 我们获取网站维护的 `message`:

```php
$message = \Drupal::config('system.maintenance')->get('message');
```

可以在 `setting.php` 中直接来覆写这个变量:

```php
$config['system.maintenance']['message'] = 'Sorry, our site is down now.';
```

在 `Configuration->Performance->Aggregate CSS files` 这里, 安装完以后 Drupal8 是默认打开的, 关闭代码如下:

```php
$config['system.performance']['css']['preprocess'] = 0;
```

然后通过 drush 命令查看是否覆写成功。

```shell
> drush config-list
> drush config-get system.performance
```

### 获取原值

配置被覆写以后, 怎么获取原值呢？以下是示例代码:

```php
// Get the site name, with overrides.
$site_name = \Drupal::config('system.site')->get('name');

// Get the site name without overrides.
$site_name = \Drupal::config('system.site')->getOriginal('name', FALSE);

// Note that mutable config is always override free.
$site_name = \Drupal::configFactory()->getEditable('system.site')->get('name');
```

### 覆写语言配置

多语言站点中, 要给用户发送邮件, 这时候邮件语言取决于用户的语言配置。代码如下:

```php
// Load the language_manager service
$language_manager = \Drupal::service('language_manager');

// Get the target language object
$langcode = $account->getPerferredLangcode();
$language = $language_manager->getLanguage($langcode);

// Remember original language before this operation.
$original_language = $language_manager->getConfigOverrideLanguage();
// Set the translation target language on the configuration factory.
$language_manager->setConfigOverrideLanguage($language);

$mail_config = \Drupal::config('user.mail');

// Now send email based on $mail_config which is in the proper language.

// Set the configuration language back.
$language_manager->setCOnfigOverrideLanguage($original_language);
```

这段代码主要是把 `user.mail` 这个配置更改为 `language.config.$langcode.user.mail`, 发送邮件的时候就会自动找用户设置的语言, 从而找到跟用户语言相符合的邮件模版。

### 模块中覆写配置

`ConfigFactory` 会扫描所有模块, 并从中找到实现了 `config.factory.override` 的 `service`。

如在 `hello_world.services.yml` 中定义如下:

```yaml
services:
  hello_world.config_example.overrider:
    class: \Drupal\hello_world\ConfigExampleOverrides
    tags:
      - {name: config.factory.override, priority: 5}
```

在 `src/ConfigExampleOverrides.php` 编写如下代码:

```php
<?php
namespace Drupal\hello_world;

use Drupal\Core\Cache\CacheableMetadata;
use Drupal\Core\Config\COnfigFactoryOverrideInterface;
use Drupal\Core\Config\StorageInterface;

/**
 * Example configuration override.
 */
class ConfigExampleOverrides implements ConfigFactoryOverrideInterface {

  public function loadOverrides($names) {
    $overrides = array();
    if (in_array('system.site', $names)) {
      $overrides['system.site'] = ['name' => 'Overridden site name!'];
    }
    return $overrides;
  }

  /**
   * {@inheritdoc}
   */
  public function getCacheSuffix() {
    return 'ConfigExampleOverrider';
  }

  /**
   * {@inheritdoc}
   */
  public function getCacheableMetadata($name) {
    return new CacheableMetadata();
  }

  /**
   * {@inheritdoc}
   */
  public function createConfigObject($name, $collection = StorageInterface::DEFAULT_COLLECTION) {
    return NULL;
  }

}
```

上面代码实现了 `ConfigFactoryOverrideInterface` 的四个方法:

1. `loadOverrides`: 返回配置覆写数组
2. `getCacheSuffix`: 返回 cache 的前缀名称
3. `getCacheableMetadata`: 返回被覆写后的 cache 数据
4. `createConfigObject`: 安装或同步的时候创建一个 config 对象, 这里是覆写, 所以返回 NULL

## 配置 shema / metadata

1. `schema` 描述配置文件的结构
2. `metadata` 配置的元数据

### 一个简单的示例

有如下代码:

```php
$config = \Drupal::config('system.maintenance');
$message = $config->get('message');
$langcode = $config->get('langcode');
```

config 数据结构体的默认值是保存在配置文件 `core/modules/system/config/install/system.maintenance.yml`

代码如下:

```yaml
message: '@site is currently under maintenance. We should be back shortly. Thank you for your patience.''
langcode: en
```

在 `core/modules/system/config/schema/system.schema.yml` 文件中定义数据结构题。

```yaml
system.maintenance:
  type: config_object
  label: 'Maintenance mode'
  mapping:
    message:
      type: text
      label: 'Message to display when in maintenance mode'
```

schema 定义了一个 mapping 数据结构体, 可以认为是一个数组。

注意: 一个 `schema.yml` 文件可以定义多个数据结构体, 每一个数据结构体的机器名必须与 `setting.yml` 文件名一致

### schema 属性

#### Type

有基本类型和派生类型

1. 基本类型 (core.data_types.schema.yml)

    ```yaml
    # Undefined type used by the system to assign to elements at any level where
    # configuration schema is not defined. Using explicitly has the same effect as
    # not defining schema, so there is no point in doing that.
    underfined:
      label: 'Underfined'
      class: '\Drupal\Core\Config\Schema\Underfined'

    # Explicit type to use when no data typing is possible. Instead of using this
    # type, we strongly suggest you use configuration structures that can be
    # described with other structural elements of schema, and describe your schema
    # with those elements.
    ignore:
      label: 'Ignore'
      class: '\Drupal\Core\Config\Schema\Ignore'

    # Basic scalar data types from typed data.
    boolean:
      label: 'Boolean'
      class: '\Drupal\Core\TypedData\Plugin\DataType\BooleanData'
    email:
      label: 'Email'
      class: '\Drupal\Core\TypedData\Plugin\DataType\Email'
    integer:
      label: 'Integer'
      class: '\Drupal\Core\TypedData\Plugin\DataType\IntegerData'
    float:
      label: 'Float'
      class: '\Drupal\Core\TypedData\Plugin\DataType\FloatData'
    string:
      label: 'String'
      class: '\Drupal\Core\TypedData\Plugin\DataType\StringData'
    uri:
      label: 'Uri'
      class: '\Drupal\Core\TypedData\Plugin\DataType\Uri'
    ```

    1. `label`: 短标签
    2. `translatable`: 是否可被翻译
    3. `nullable`: 是否允许空值
    4. `class`: 实现的类名

    另外还有:

    - `config_object`: 默认配置结构
    - `config_entity`: 实体配置结构

2. 派生类型

    `mapping`: 关联数组 (associative array), key/value数据结构, 只支持 string 类型

    `sequence`: 索引数组 (indexed array)

### 动态类型 `[%parent]`

下面的示例我们定义了两个动态类型 `warning` 和 `multiple`, `multiple` 是一个列表, `warning` 是一个当行文本。

1. `config/install/hello_world.message.single.yml`

    ```yaml
    type: warning
    message: 'Hello!'
    langcode: en
    ```

2. `config/install/hello_world.message.multiple.yml`

    ```yaml
    type: multiple
    message:
      - 'Hello!'
      - 'Hi!'
    langcode: en
    ```

3. `config/schema/hello_world.schema.yml`

    ```yaml
    hello_world.message.*:
      type: config_object
      mapping:
        type:
          type: string
          label: 'Message type'
        message:
          type: hello_world_message.[%parent.type]
        langcode:
          type: string
          label: 'Language code'

    hello_world_message.warning:
      type: string

    hello_world.message.multiple:
      type: sequence
      label: 'Messages'
      sequence:
        type: string
        label: 'Message'
    ```

    - `*` 表示通配符, 这里指 single 或 multiple
    - `$parent.type` 指我们在下面定义的数据类型, 注意: 这里定义的机器名要和父节点的机器名不能重名

### 动态类型 `[type]`

如果想要在已有的数据下面定义你自己不同的数据类型, 那么 `[type]` 将会变得非常有用。

1. `config/install/hello_world.message.single.yml`

    ```yaml
    message:
      type: warning
      value: 'Hello!'
    langcode: en
    ```

2. `config/install/hello_world.message.multiple.yml`

    ```yaml
    message:
      type: multiple
      value:
        - 'Hello!'
        - 'Hi !'
    langcode: en
    ```

3. `config/schema/hello_world.schema.yml`

    ```yaml
    hello_world.message.*:
      type: config_object
      mapping:
        message:
          type: hello_world_message.[type]
        [...]

    hello_world_message.warning:
      type: mapping
      [...]

    hello_world_message.multiple:
      type: mapping
      [...]
    ```

    - `[type]` 动态定义了 message 的类型, 并且要求 warning 和 multiple 的类型必须一致, 上面的示例代码都是 mapping 类型

### 动态类型 `[%key]`

1. `config/install/hello_world.messages.yml`

    ```yaml
    message:
      'single:1': 'Hello!'
      'single:2': 'Hi !'
      'multiple:1':
        - 'Good morning!'
        - 'Good night!'
    langcode: en
    ```

    这是一个任意消息元素的列表。

2. `config/schema/hello_world.schema.yml`

    ```yaml
    hello_world_message.messages:
        type: config_object
        mapping:
          message:
            type: sequence
            label: 'Messages'
            sequence:
              type: hello_world_message.[%key]
          langcode:
            type: string
            label: 'Language code'

        hello_world_message.single:*:
          type: string
          label: 'Message'

        hello_world_message.multiple:*:
          type: sequence
          label: 'Messages'
          sequence:
            type: string
            label: 'Message'
    ```

    这里定义了一个序列数组 messages, 而序列数组的类型就是 hello_world_message 定义的动态类型。

## 创建配置实体

### 定义路由

在 `example/example.routing.yml` 中定义四个路由: `list / add / edit / delete`。

代码如下:

```yaml
entity.example.collection:
  path: '/admin/config/system/example'
  defaults:
    _entity_list: 'example'
    _title: 'Example configuration'
  requirements:
    _permission: 'administer site configuration'

entity.example.add_form:
  path: '/admin/config/system/example/add'
  defaults:
    _entity_form: 'example.add'
    _title: 'Add example'
  requirements:
    _permission: 'administer site configuration'

entity.example.edit_form:
  path: '/admin/config/system/example/{example}'
  defaults:
    _entity_form: 'example.edit'
    _title: 'Edit example'
  requirements:
    _permission: 'administer site configuration'

entity.example.delete_form:
  path: '/admin/config/system/example/{example}/delete'
  defaults:
    _entity_form: 'example.delete'
    _title: 'Delete example'
  requirements:
    _permission: 'administer site configuration'
```

### 定义菜单

在 `example/example.links.action.yml` 定义一个添加按钮。

```yaml
entity.example.add_form:
  route_name: 'entity.example.add_form'
  title: 'Add example'
  appears_on:
    - entity.example.collection
```

### 实体类型类

1. `example/src/ExampleInterface.php`

    假设实体里面包含一些属性, 需要在接口实现 `set/get` 方法。如:

    ```php
    <?php
    namespace Drupal\example;

    use Drupal\Core\Config\Entity\Config\EntityInterface;

    /**
     * Provides an interface defining on Example entity.
    */
    interface ExampleInterface extends ConfigEntityInterface {
      // Add get/set methods for your configuration properties here.
    }
    ```

2. `example/src/Entity/Example.php`

    这个文件定义了配置类型的实现类。

    ```php
    <?php
    namespace Drupal\example\Entity;

    use Drupal\Core\Config\Entity\ConfigEntityBase;
    use Drupal\example\ExampleInterface;

    /**
     * Defines the Example entity
    *
    * @ConfigEntityType(
    *   id = "example",
    *   label = @Translation("Example"),
    *   handlers = {
    *     "list_builder" = "Drupal\example\Controller\ExampleListBuilder",
    *     "form" = {
    *       "add" = "Drupal\example\Form\ExampleForm",
    *       "edit" = "Drupal\example\Form\ExampleForm",
    *       "delete" = "Drupal\example\Form\ExampleDeleteForm",
    *     },
    *     config_prefix = "example",
    *     admin_permission = "administer site configuration",
    *     entity_keys = {
    *       "id" = "id",
    *       "label" = "label",
    *     },
    *     links = {
    *       "edit-form" = "/admin/config/system/example/{example}",
    *       "delete-form" = "/admin/config/system/example/{example}/delete",
    *     }
    *   }
    * )
    */
    class Example extends ConfigEntityBase implements ExampleInterface {

      /**
       * The Example ID.
       *
       * @var string
       */
      public $id;

      /**
       * The Example label.
       *
       * @var string
       */
      public $label;

      // Your specific configuration property get/set methods go here,
      // implementing the interface.

    }
    ```

### 配置 schema

文件: `example/config/schema/example.schema.yml`

在 `\Drupal\example\Entity\Example` 中定义的属性添加到这里。

注意: `ConfigEntityType` 注解里的 `config_prefix` 字段必须跟 `schema` 的 `prefix` 一致。

比如你定义的 `config_prefix` 是这样的: `config_prefix = "variable_name"`

那么 `schema` 的格式必须是: `example.variable_name.*`

这里我们定义的 `config_prefix` 是 `example`, 因此

```yaml
example.example.*:
  type: config_entity
  label: 'Example config'
  mapping:
    id:
      type: string
      label: 'ID'
    label:
      type: label
      label: 'Label'
```

### 实体 controller

1. 文件: `example/src/Form/ExampleForm.php`

    ```php
    <?php
    namespace Drupal\example\Form;

    use Drupal\Core\Entity\EntityForm;
    use Drupal\Core\Entity\Query\QueryFactory;
    use Drupal\Core\Form\FormStateInterface;
    use Symfony\Component\DependencyInjection\ContainerInterface;

    /**
     * Form handler for the Example add and edit forms.
    */
    class ExampleForm extends EntityForm {

      /**
       * Constructs on ExampleForm object.
       *
       * @param \Drupal\Core\Entity\Query\QueryFactory $entity_query
       *   The entity query.
       */
      public function __construct(QueryFactory $entity_query) {
        $this->entityQuery = $entity_query;
      }

      /**
       * {@inheritdoc}
       */
      public static function create(ContainerInterface $container) {
        return new static(
          $container->get('entity.query')
        );
      }

      /**
       * {@inheritdoc}
       */
      public function form(array $form, FormStateInterface $form_state) {
        $form = parent::form($form, $form_state);

        $example = $this->entity;

        $form['label'] = [
          '#type' => 'textfield',
          '#title' => $this->t('Label'),
          '#maxlength' => 255,
          '#default_value' => $example->label(),
          '#description' => $this->t('Label for the Example.'),
          '#required' => TRUE,
        ];

        $form['id'] = [
          '#type' => 'machine_name',
          '#default_value' => $example->id(),
          '#machine_name' => [
              'exists' => [$this, 'exist'],
          ],
          '#disabled' => !$example->isNew(),
        ];

        // You will need additional form elements for your custom properties.
        return $form;
      }

      /**
       * {@inheritdoc}
       */
      public function save(array $form, FormStateInterface $form_state) {
        $example = $this->entity;
        $status = $example->save();

        if ($status) {
          drupal_set_message($this->t('Save the %label Example.', [
            '%label' => $example->label(),
          ]));
        } else {
          drupal_set_message(this->t('The %label Example was not saved.', [
            '%label' => $example->label(),
          ]));
        }
        $form_state->setRedirect('entity.example.collection');
      }

      /**
       * Helper function check whether an Example configuration entity exists.
       */
      public function exist($id) {
        $entity = $this->entityQuery->get('example')
          ->condition('id', $id)
          ->execute();
        return (bool)$entity;
      }

    }
    ```

2. 文件: `example/src/Controller/ExampleListBuilder.php`

    ```php
    <?php
    namespace Drupal\example\Controller;

    use Drupal\Core\Config\Entity\ConfigEntityListBuilder;
    use Drupal\Core\Entity\EntityInterface;

    /**
     * Provides a listing of Example.
    */
    class ExampleListBuilder extends ConfigEntityListBuilder {

      /**
       * {@inheritdoc}
       */
      public function buildHeader() {
        $header['label'] = $this->t('Example');
        $header['id'] = $this->t('Machine name');
        return $header + parent::buildHeader();
      }

      /**
       * {@inheritdoc}
       */
      public function buildRow(EntityInterface $entity) {
        $row['label'] = $this->getLabel($entity);
        $row['id'] = $entity->id();

        // You probably want a few more properties here ...

        return $row + parent::buildRow($entity);
      }

    }
    ```

3. 文件: `example/src/Form/ExampleDeleteForm`

    ```php
    namespace Drupal\example\Form;

    use Drupal\Core\Entity\EntityConfirmFormBase;
    use Drupal\Core\Url;
    use Drupal\Core\Form\FormStateInterface;

    /**
     * Builds the form to delete an Example.
    */
    class ExampleDeleteForm extends EntityConfirmFormBase {

      /**
       * {@inheritdoc}
       */
      public function getQuestion() {
        return $this->t('Are you sure you want to delete %name?', [
          '%name' => $this->entity->label(),
        ]);
      }

      /**
       * {@inheritdoc}
       */
      public function getCancelUrl() {
        return new Url('entity.example.collection');
      }

      /**
       * {@inheritdoc}
       */
      public function getConfirmText() {
        return $this->t('Delete');
      }

      /**
       * {@inheritdoc}
       */
      public function submitForm(array &$form, FormStateInterface $form_state) {
        $this->entity->delete();
        drupal_set_message($this->t('Category %label has been deleted.', [
          '%label' => $this->entity->label(),
        ]));
        $form_state->setRedirectUrl($this->getCancelUrl());
      }

    }
    ```

## 配置 API 示例

### 读取配置

```php
// Immutable Config (Read Only)
$config = \Drupal::config('system.performance');
// Mutable Config (Read / Write)
$config = \Drupal::service('config.factory')->getEditable('system.performance');
```

第一个只读, 第二个方法可读写。

配置读取一般使用 `get` 方法, 如:

```php
$config = \Drupal::config('system.maintenance');
$message = $config->get('message');
```

也可以改成链式写法:

```php
$message = \Drupal::config('system.maintenance')->get('message');
```

读取一个嵌套配置, 使用 `.` 号连接起来。如:

```php
$enabled = \Drupal::config('system.performance')->get('cache.page.enabled');
```

### 写入配置

通常使用 `getEditable` 这个方法从 `\Drupal\Core\Config\Config` 中获取。如:

```php
Drupal::service('config.factory')->getEditable('system.performance');
```

#### 覆写单个配置

一般使用 `set` 和 `save` 方法来变更配置。如:

```php
$config = \Drupal::service('config.factory')->getEditable('system.performance');

// Set a scalar value.
$config->set('cache.page.enabled', 1);

// Set an array of values.
$page_cache_data = [
  'enabled' => 1,
  'max_age' => 5,
];
$config->set('cache.page', $page_cache_data);

// Save your data to the file system.
$config->save();
```

也可以写成链式:

```php
Drupal::service('config.factory')
  ->getEditable('system.performance')
  ->set('cache.page.enabled', 1)
  ->save();
```

#### 覆写所有配置

如果要覆盖所有的配置数据, 可以使用 `setData` 方法, 代码如下:

```php
// Set all values.
\Drupal::service('config.factory')
  ->getEditable('system.performance')
  ->setData([
      'cache' => [
        'page' => [
          'enabled' => '0',
          'max_age' => '0',
        ],
      ],
      'preprocess' => [
        'css' => '0',
        'js' => '0',
      ],
      'response' => [
        'gzip' => '0',
      ],
  ])
  ->save();
```

注意: `setData` 会完全改变配置的数据结构, 务必更改的时候对应好键值。

### 删除配置

#### 删除一个单独的配置

代码如下:

```php
$config = \Drupal::service('config.facotry')->getEditable('system.performance');
$config->clear('cache.page.max_age')->save();
$page_cache_data = $config->get('cache.page');
```

这时候打印 `$page_cache_data`, 会发现 `max_age` 已经被删除了。

#### 删除所有配置

通常使用 `delete` 方法, 代码如下:

```php
Drupal::service('config.factory')->getEditable('system.performance')->delete();
```

### 最佳实践

如果要在一个配置里保存多个字段, 我们可能要写多个 `save`, 如下:

```php
Drupal::service('config.factory')->getEditable('foo.bar')->set('foo', 'foo')->save();
\Drupal::service('config.factory')->getEditable('foo.bar')->set('bar', 'bar')->save();
```

这种代码是不合理的, 应该写成:

```php
$config = \Drupal::service('config.factory')->getEditable('foo.bar');
$config
  ->set('foo', 'foo')
  ->set('bar', 'bar')
  ->save();
```

## 如何更改配置

如何更改我们在 `{module.settings.yml}` 定义的配置呢？

通常我们通过 `form` 表单来实现。

1. 文件: `example/config/install/example.settings.yml`

    ```yaml
    things: thingssss
    other_things: other_thingssss
    ```

2. 文件: `example/src/Form/exampleSettingsForm.php`

    ```php
    <?php
    namespace Drupal\example\Form;

    use Drupal\Core\Form\ConfigFormBase;
    use Drupal\Core\Form\FormStateInterface;

    /**
     * Configure example settings for this site.
    */
    class exampleSettingsForm extends ConfigFormBase {

      /**
       * {@inheritdoc}
       */
      public function getFormId() {
        return 'example_admin_settings';
      }

      /**
       * {@inheritdoc}
       */
      protected function getEditableConfigNames() {
        return [
          'example.settings',
        ];
      }

      /**
       * {@inheritdoc}
       */
      public function buildForm(array $form, FormStateInterface $form_state) {
        $config = $this->config('example.settings');

        $form['example_thing'] = [
          '#type' => 'textfield',
          '#title' => $this->t('Things');
          '#default_value' => $config->get('things');
        ];

        $form['other_things'] = [
          '#type' => 'textfield',
          '#title' => $this->t('Other things'),
          '#default_value' => $config->get('other_things'),
        ];

        return parent::buildForm($form, $form_state);
      }

      /**
       * {@inheritdoc}
       */
      public function submitForm(array &$form, FormStateInterface $form_state) {
        // Retrieve the configuration
        $this->config('example.settings')
          // Set the submitted configuration setting
          ->set('things', $form_state->getValue('example_thing'))
          ->set('other_things', $form_state->getValue('other_things'))
          ->save();

        parent::submitForm($form, $form_state);
      }

    }
    ```

3. 文件: example/example.routing.yml

    ```yaml
    example.settings:
      path: '/admin/structure/example/settings'
      defaults:
        _form: '\Drupal\example\Form\exampleSettingsForm'
        _title: 'example'
      requirements:
        _permission: 'administer site configuration'
    ```

以上代码已经很清晰的说明了如何通过 `form` 表单来更改默认的配置。

## 实践

1. 按照讲义进行练习
2. 设计一个配置, 可配置性别、类型（企业、个人、代理等）, 等至少列举5项, 需使用动态 schema
3. 以上配置都可以在 form 表单里更改
4. 更改一个系统配置

以上, 自由发挥。
