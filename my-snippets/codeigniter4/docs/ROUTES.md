### Alternate Snippets for Routes

### `[ProjectRoot]/app/Config/Routes.php`

### Table of Content
<!-- - [Alternate Snippets for Routes](#alternate-snippets-for-routes)
- [`[ProjectRoot]/app/Config/Routes.php`](#projectrootappconfigroutesphp)
- [Table of Content](#table-of-content) -->
- [Routes](#routes)
  - [Placeholders](#placeholders)
  - [Custom Placeholders](#custom-placeholders)
  - [Presenter](#presenter)
  - [Resource](#resource)

### Routes
<table style="width:100%">
<thead>
<tr>
<th align="center">COMMANDS</th>
<th align="center">RESULTS</th>
</tr>
</thead>
<tbody>
<tr>
<td nowrap style="vertical-align: top;">

```code
ci4:routes:add
```

</td>
<td nowrap>

```php
$routes->add('url', 'ControllerName::index');
```
</td>
</tr>
<!--  -->
<tr>
<td nowrap style="vertical-align: top;">

```code
ci4:routes:cli
```

</td>
<td nowrap>

```php
$routes->cli('migrate', 'App\Database::migrate');
```
</td>
</tr>
<!--  -->
<tr>
<td nowrap style="vertical-align: top;">

```code
ci4:routes:env
```

</td>
<td nowrap>

```php
$routes->environment('development' , function($routes)
{
    $routes->add('builder','Tools\Builder::index');
});
```
</td>
</tr>
<!--  -->
<tr>
<td nowrap style="vertical-align: top;">

```code
ci4:routes:get
```

</td>
<td nowrap>

```php
$routes->get('url', 'ControllerName::index');
```
</td>
</tr>
<!--  -->
<tr>
<td nowrap style="vertical-align: top;">

```code
ci4:routes:group
```

</td>
<td nowrap>

```php
$routes->group('admin', function($routes)
{
    $routes->add('url', 'ControllerName::index');
});
```
</td>
</tr>
<!--  -->
<tr>
<td nowrap style="vertical-align: top;">

```code
ci4:routes:group-filter
```

</td>
<td nowrap>

```php
$routes->group('api' , ['filter' => 'api-auth'], function($routes)
{
    $routes->resource('url');
});
```
</td>
</tr>
<!--  -->
<tr>
<td nowrap style="vertical-align: top;">

```code
ci4:routes:group-multiple
```

</td>
<td nowrap>

```php
$routes->group('admin', function($routes)
{
    $routes->group('users', function($routes)
    {
        //Route
    });
});
```
</td>
</tr>
<!--  -->
<tr>
<td nowrap style="vertical-align: top;">

```code
ci4:routes:group-namespace
```

</td>
<td nowrap>

```php
$routes->group('api' , ['namespace' => 'App\API\v1'], function($routes)
{
    //Route
});
```
</td>
</tr>
<!--  -->
<tr>
<td nowrap style="vertical-align: top;">

```code
ci4:routes:post
```

</td>
<td nowrap>

```php
$routes->post('url', 'ControllerName::index');
```
</td>
</tr>
<!--  -->
<tr>
<td nowrap style="vertical-align: top;">

```code
ci4:routes:subdomain
```

</td>
<td nowrap>

```php
$routes->add('from', 'to', ['subdomain' => '*']);
```
</td>
</tr>
</tbody>
</table>

#### Placeholders
<table style="width:100%">
<thead>
<tr>
<th align="center">COMMANDS</th>
<th align="center">RESULTS</th>
</tr>
</thead>
<tbody>
<tr>
<td nowrap style="vertical-align: top;">

```code
ci4:routes:placeholder
```

</td>
<td nowrap>

```php
$routes->type('url/(:placeholder)', 'ControllerName::index/$1');
```
<small>
<strong>Type : </strong>add, get, post, put, delete<br>
<strong>Placeholder : </strong>any, segment, num, alpha, alphanum, hash<br>
</small>
</td>
</tr>
</tbody>
</table>

#### Custom Placeholders
<table style="width:100%">
<thead>
<tr>
<th align="center">COMMANDS</th>
<th align="center">RESULTS</th>
</tr>
</thead>
<tbody>
<tr>
<td nowrap style="vertical-align: top;">

```code
ci4:routes:placeholder:custom
```

</td>
<td nowrap>

```php
$routes->addPlaceholder('uuid', '[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}');
$routes->type('url/(:uuid)', 'ControllerName::index/$1');
```
<small>
<strong>Type : </strong>add, get, post, put, delete<br>
</small>
</td>
</tr>
<!--  -->
</tbody>
</table>

#### Presenter
<table style="width:100%">
<thead>
<tr>
<th align="center">COMMANDS</th>
<th align="center">RESULTS</th>
</tr>
</thead>
<tbody>
<tr>
<td nowrap style="vertical-align: top;">

```code
ci4:routes:presenter
```

</td>
<td nowrap>

```php
$routes->presenter('url');
```
</td>
</tr>
</tbody>
</table>

#### Resource
<table style="width:100%">
<thead>
<tr>
<th align="center">COMMANDS</th>
<th align="center">RESULTS</th>
</tr>
</thead>
<tbody>
<tr>
<td nowrap style="vertical-align: top;">

```code
ci4:routes:resource
```

</td>
<td nowrap>

```php
$routes->resource('url');
```
</td>
</tr>
</tbody>
</table>
