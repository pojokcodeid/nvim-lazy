### Alternate Snippets for Validation

### Table of Content

- [Alternate Snippets for Validation](#alternate-snippets-for-validation)
- [Table of Content](#table-of-content)
- [Validation](#validation)
  - [Validation in Controller](#validation-in-controller)

### Validation

#### Validation in Controller

- Command
  ```code
  ci4:validation:controller
  ```
- Output

  ```php
  $validation = \Config\Services::validation();
  $rules = [
    'field_1' => [
			'label'	=> 'Field 1 Custom Name',
			'rules' => 'required',
			'errors' => [
				'required' => '{field} is required.'
			]
		],
  ];
  if (!$this->validate($rules)) {
    return redirect()->to('/route')->withInput()->with('validation', $validation);
  }
  ```