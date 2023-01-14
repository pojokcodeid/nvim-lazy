### Alternate Snippets for View Files

### `[ProjectRoot]/app/Views/**.php`

<table>
<thead>
<tr>
<th align="center">Command</th>
<th align="center">Description</th>
<th align="center">Output</th>
</tr>
</thead>
<tbody>
<tr>
<td nowrap>ci4:views:endSection</td>
<td>Make end Section in View files</td>
<td>

```php
<?= $this->endSection() ;?>
```

</td>
</tr>
<!--  -->
<tr>
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
<td nowrap>ci4:views:foreach</td>
<td>Make <code>foreach</code> in View files</td>
<td>

```php
<?php foreach ($items as $item) : ?>
  <li><?= $item ?></li>
<?php endforeach ?>
```

</td>
</tr>
<!--  -->
<tr>
<td nowrap>ci4:views:if</td>
<td>Make <code>if</code> in View files</td>
<td>

```php
<?php if (condition) : ?>
<!-- TRUE -->
<?php endif ?>
```

</td>
</tr>
<!--  -->
<tr>
<td nowrap>ci4:views:if-else</td>
<td>Make <code>if else</code> in View files</td>
<td>

```php
<?php if (condition) : ?>
<!-- TRUE -->
<?php else : ?>
<!-- FALSE -->
<?php endif ?>
```

</td>
</tr>
<!--  -->
<tr>
<td nowrap>ci4:views:if-elseif</td>
<td>Make <code>if elseif</code> in View files</td>
<td>

```php
<?php if (condition) : ?>
<!-- TRUE -->
<?php elseif (condition) : ?>
<!-- FALSE -->
<?php endif ?>
```

</td>
</tr>
<!--  -->
<tr>
<td nowrap>ci4:views:if-elseif-else</td>
<td>Make <code>if elseif else</code> in View files</td>
<td>

```php
<?php if (condition) : ?>
<!-- TRUE 1 -->
<?php elseif (condition) : ?>
<!-- TRUE 2 -->
<?php else : ?>
<!-- FALSE -->
<?php endif ?>
```

</td>
</tr>
<!--  -->
<tr>
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
<td nowrap>ci4:views:php</td>
<td>Make php tag in View files</td>
<td>

```php
<?php code ;?>
```

</td>
</tr>
<!--  -->
<tr>
<td nowrap>ci4:views:php-echo</td>
<td>Make php echo tag in View files</td>
<td>

```php
<?= code ;?>
```

</td>
</tr>
<!--  -->
<tr>
<td nowrap>ci4:views:renderSection</td>
<td>Make render Section in View files</td>
<td>

```php
<?= $this->renderSection('content') ;?>
```

</td>
</tr>
<!--  -->
<tr>
<td nowrap>ci4:views:section</td>
<td>Make Section in View files</td>
<td>

```php
<?= $this->section('content') ;?>
```

</td>
</tr>
<!--  -->
<tr>
<td nowrap>ci4:views:section-endSection</td>
<td>Make Section with end Section in View files</td>
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
