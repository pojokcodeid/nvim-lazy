# Alternate Snippets for Migrations

## `[ProjectRoot]/app/Database/Migrations/`

# Table of Content

- [Create Migration](#create-migration)
  - [Migration Up](#migration-up)
  - [Migration Down](#migration-down)
- [Create Table](#create-table)
  - [Add Column](#add-column) [new]
    - [BIGINT](#bigint) [new]
    - [CHAR](#char) [new]
    - [DATETIME](#datetime) [new]
    - [INT](#int) [new]
    - [VARCHAR](#varchar) [new]
  - [ID](#id) [new]
  - [Timestamp](#timestamp)

## Create Migration

**Command**

```bash
ci4:migration
```

**Output**

```php
<?php

namespace App\Database\Migrations;

use CodeIgniter\Database\Migration;

class AddBlog extends Migration
{
    public function up()
    {
        //
    }

    public function down()
    {
        //
    }
}
```

- ### Migration Up

  **Command**

  ```bash
  ci4:migration:up
  ```

  **Output**

  ```php
  public function up()
  {
    $this->forge->addField([
        'id' => [
            'type' => 'INT',
            'constraint' => 11,
            'unsigned' => true,
            'auto_increment' => true,
        ],
        'name' => [
            'type' => 'VARCHAR',
            'constraint' => 255,
        ],
        'created_at' => [
            'type' => 'DATETIME',
            'null' => true,
        ],
        'updated_at' => [
            'type' => 'DATETIME',
            'null' => true,
        ],
        'deleted_at' => [
            'type' => 'DATETIME',
            'null' => true,
        ],
    ]);
    $this->forge->addKey('id', true);
    $this->forge->createTable('tableName');
  }
  ```

- ### Migration Down

  **Command**

  ```bash
  ci4:migration:down
  ```

  **Output**

  ```php
  public function down()
  {
    $this->forge->dropTable('tableName');
  }
  ```

## Create Table

- ### Add Column

  - #### BIGINT

    **Command**

    ```bash
    ci4:migration:bigint
    ```

    **Output**

    ```php
    'columnName' => [
      'type' => 'BIGINT',
      'constraint' => '20',
      'null' => true,
    ],
    ```

  - #### CHAR

    **Command**

    ```bash
    ci4:migration:char
    ```

    **Output**

    ```php
    'columnName' => [
      'type' => 'CHAR',
      'constraint' => '10',
      'null' => true,
    ],
    ```

  - #### DATETIME

    **Command**

    ```bash
    ci4:migration:datetime
    ```

    **Output**

    ```php
    'columnName' => [
      'type' => 'DATETIME',
      'null' => true,
    ],
    ```

  - #### INT

    **Command**

    ```bash
    ci4:migration:int
    ```

    **Output**

    ```php
    'columnName' => [
      'type' => 'INT',
      'constraint' => '11',
      'null' => true,
    ],
    ```

  - #### VARCHAR

    **Command**

    ```bash
    ci4:migration:varchar
    ```

    **Output**

    ```php
    'columnName' => [
      'type' => 'VARCHAR',
      'constraint' => '255',
      'null' => true,
    ],
    ```

- ### ID

  **Command :**

  ```bash
  ci4:migration:id
  ```

  **Output :**

  ```php
  'id' => [
    'type' => 'INT',
    'constraint' => 11,
    'unsigned' => true,
    'auto_increment' => true,
  ],
  ```

- ### Timestamp

  **Command :**

  ```bash
  ci4:migration:timestamp
  ```

  **Output :**

  ```php
  'created_at' => [
    'type' => 'DATETIME',
    'null' => true,
  ],
  'updated_at' => [
    'type' => 'DATETIME',
    'null' => true,
  ],
  'deleted_at' => [
    'type' => 'DATETIME',
    'null' => true,
  ],
  ```
