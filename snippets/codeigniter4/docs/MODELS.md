### Alternate Snippets for Models

### `[ProjectRoot]/app/Models/*.php`

### Table of Content

- [Model Config](#model-config) [new]

#### Model Config

- Command
  ```bash
    ci4:model:config
  ```
- Output

  ```php
    protected $table      = 'tableName';
    protected $primaryKey = 'id';

    protected $useAutoIncrement = true;

    protected $returnType     = 'array';
    protected $useSoftDeletes = true;

    protected $allowedFields = ['name'];

    protected $useTimestamps = false;
    protected $createdField  = 'created_at';
    protected $updatedField  = 'updated_at';
    protected $deletedField  = 'deleted_at';

    protected $validationRules    = [];
    protected $validationMessages = [];
    protected $skipValidation     = false;
  ```
