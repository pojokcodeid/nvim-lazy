## Change Command Snippets

---

### Alternate Snippets for View Files

### `[ProjectRoot]/app/Views/**.php`

<table>
<thead>
<tr>
<th align="center" colspan="2">Command</th>
<th align="center" rowspan="2">Description</th>
<th align="center" rowspan="2">Output</th>
</tr>
<tr>
<th align="center">Lates</th>
<th align="center">News</th>
</tr>
</thead>
<tbody>
<tr>
<td>ci4_endsection</td>
<td nowrap>ci4:views:endSection</td>
<td>Make end Section </td>
<td>

```php
<?= $this->endSection() ;?>
```

</td>
</tr>
<!--  -->
<tr>
<td>ci4_extend</td>
<td nowrap>ci4:views:extend</td>
<td>Using Layouts in Views</td>
<td>

```php
<?= $this->extend('layouts') ;?>
```

</td>
</tr>
<!--  -->
<tr>
<td>ci4_include</td>
<td nowrap>ci4:views:include</td>
<td>Including View Partials</td>
<td>

```php
<?= $this->include('sidebar') ;?>
```

</td>
</tr>
<!--  -->
<tr>
<td>ci4_php</td>
<td nowrap>ci4:views:php</td>
<td>Make php tag</td>
<td>

```php
<?php code ;?>
```

</td>
</tr>
<!--  -->
<tr>
<td>ci4_php_echo</td>
<td nowrap>ci4:views:php-echo</td>
<td>Make php echo tag</td>
<td>

```php
<?= code ;?>
```

</td>
</tr>
<!--  -->
<tr>
<td>ci4_rendersection</td>
<td nowrap>ci4:views:renderSection</td>
<td>Make render Section</td>
<td>

```php
<?= $this->renderSection('content') ;?>
```

</td>
</tr>
<!--  -->
<tr>
<td>ci4_section</td>
<td nowrap>ci4:views:section</td>
<td>Make Section</td>
<td>

```php
<?= $this->section('content') ;?>
```

</td>
</tr>
<!--  -->
<tr>
<td>ci4_sectionend</td>
<td nowrap>ci4:views:section-endSection</td>
<td>Make Section with end Section</td>
<td>

```php
<?= $this->section('content') ;?>
<!-- CODE HERE -->
<?= $this->endSection() ;?>
```

</td>
</tr>
</tbody>
</table>

---

### Alternate Snippets for Routes

### `[ProjectRoot]/app/Config/Routes.php`

<table>
<thead>
<tr>
<th align="center" colspan="2">Command</th>
<th align="center" rowspan="2">Description</th>
<th align="center" rowspan="2">Output</th>
</tr>
<tr>
<th align="center">Lates</th>
<th align="center">News</th>
</tr>
</thead>
<tbody>
<tr>
<td>ci4_routes_add</td>
<td nowrap>ci4:routes:add</td>
<td>Make Routes add() </td>
<td>

```php
$routes->add('url', 'ControllerName::index');
```

</td>
</tr>
<!--  -->
<tr>
<td>ci4_routes_cli</td>
<td nowrap>ci4:routes:cli</td>
<td>Make Command-Line only Routes</td>
<td>

```php
$routes->cli('migrate', 'App\Database::migrate');
```

</td>
</tr>
<!--  -->
<tr>
<td>ci4_routes_env</td>
<td nowrap>ci4:routes:env</td>
<td>Make Routes Environment</td>
<td>

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
<td>ci4_routes_get</td>
<td nowrap>ci4:routes:get</td>
<td>Make Routes get()</td>
<td>

```php
$routes->get('url', 'ControllerName::index');
```

</td>
</tr>
<!--  -->
<tr>
<td>ci4_routes_group</td>
<td nowrap>ci4:routes:group</td>
<td>Make Routes group()</td>
<td>

```php
$routes->group('admin', function($routes)
{
    //Route
});
```

</td>
</tr>
<!--  -->
<tr>
<td>ci4_routes_group_filter</td>
<td nowrap>ci4:routes:group-filter</td>
<td>Make Routes group() filter</td>
<td>

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
<td>ci4_routes_group_multiple</td>
<td nowrap>ci4:routes:group-multiple</td>
<td>Make Routes group() multiple</td>
<td>

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
<td>ci4_routes_group_namespace</td>
<td nowrap>ci4:routes:group-namespace</td>
<td>Make Routes group() namespace</td>
<td>

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
<td>ci4_routes_post</td>
<td nowrap>ci4:routes:post</td>
<td>Make Routes post()</td>
<td>

```php
$routes->post('url', 'ControllerName::index');
```

</td>
</tr>
<!--  -->
<tr>
<td>ci4_routes_subdomain</td>
<td nowrap>ci4:routes:subdomain</td>
<td>Make Routes Limit to Subdomains</td>
<td>

```php
$routes->add('from', 'to', ['subdomain' => '*']);
```

</td>
</tr>
<!--  -->
</tbody>
</table>
