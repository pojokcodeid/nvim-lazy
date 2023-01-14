### Alternate Snippets for Controllers

### `[ProjectRoot]/app/Controllers/**.php`

### Table of Content
  - [Controllers](#controllers)
    - [Presenter](#presenter)
    - [Resources](#resources)
    - [Request Class](#request-class) <sup style="color:red">New</sup>

#### Controllers

<table style="width:100%">
<thead>
<tr>
<th align="center">COMMANDS</th>
<th align="center">RENDERS</th>
</tr>
</thead>
<tbody>
<tr>
<td nowrap style="vertical-align: top;">

```code
ci4:controller
```
</td>
<td nowrap>

```php
public function index()
{
    // code
}
```
</td>
</tr>
</tbody>
</table>

##### Presenter

<table style="width:100%">
<thead>
<tr>
<th align="center">COMMANDS</th>
<th align="center">RENDERS</th>
</tr>
</thead>
<tbody>
<tr>
<td nowrap style="vertical-align: top;">

```code
ci4:controller:presenter
```

</td>
<td nowrap>

```php
public function __construct()
{
    // __construct code
}

public function index()
{
    // index code
}

public function show($id = null)
{
    // show code
}

public function new()
{
    // new code
}

public function create()
{
    // create code
}

public function edit($id = null)
{
    // edit code
}

public function update($id = null)
{
    // update code
}

public function remove($id = null)
{
    // remove code
}

public function delete($id = null)
{
    // delete code
}
```
</td>
</tr>
</tbody>
</table>

##### Resources

<table style="width:100%">
<thead>
<tr>
<th align="center">COMMANDS</th>
<th align="center">RENDERS</th>
</tr>
</thead>
<tbody>
<tr>
<td nowrap style="vertical-align: top;">

```code
ci4:controller:resources
```

</td>
<td nowrap>

```php
public function __construct()
{
    // __construct code
}

public function index()
{
    // index code
}

public function show($id = null)
{
    // show code
}

public function new()
{
    // new code
}

public function create()
{
    // create code
}

public function edit($id = null)
{
    // edit code
}

public function update($id = null)
{
    // update code
}

public function delete($id = null)
{
    // delete code
}
```
</td>
</tr>
</tbody>
</table>

##### Request Class

<table style="width:100%">
<thead>
<tr>
<th align="center">COMMANDS</th>
<th align="center">RENDERS</th>
</tr>
</thead>
<tbody>
<tr>
<td nowrap style="vertical-align: top;">

```code
ci4:controller:request
```

</td>
<td nowrap>

```php
$this->request->Type('field name');
```

<small>
<strong>Type : </strong>getVar, getGet, getPost, getMethod, isAjax, isCLI, isSecure<br>
</small>
</td>
</tr>
</tbody>
</table>