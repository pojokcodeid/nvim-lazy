# Change Log

All notable changes to the "codeigniter4-snippets" extension will be documented in this file.

Check [Keep a Changelog](https://github.com/adereksisusanto/codeigniter4-snippets/releases/tag/0.1.1) for recommendations on how to structure this file.

## Donate
If this project help you reduce time to develop, you can give me a cup of coffee :)

[![Donate](https://img.shields.io/badge/Donate-PayPal-green.svg)](https://paypal.me/adereksisusanto?locale.x=id_ID) [![Donate](https://img.shields.io/badge/Donate-trakteer.id-red)](https://trakteer.id/adereksisusanto)

## [Released - 0.1.1] - 2021-10-18

- #### Fixed Bugs Snippets.
- #### Add New Snippets.
  - [Controllers](https://github.com/adereksisusanto/codeigniter4-snippets/blob/main/docs/CONTROLLERS.md)
    - [Request Class](https://github.com/adereksisusanto/codeigniter4-snippets/blob/main/docs/CONTROLLERS.md#controller-request-class)
  - [Routes](https://github.com/adereksisusanto/codeigniter4-snippets/blob/main/docs/ROUTES.md)
    - [Presenter](https://github.com/adereksisusanto/codeigniter4-snippets/blob/main/docs/ROUTES.md#presenter)
    - [Resource](https://github.com/adereksisusanto/codeigniter4-snippets/blob/main/docs/ROUTES.md#resource)

## [Released - 0.1.0] - 2021-09-21

- #### Fixed Bugs Snippets.
- #### Update Snippets.
  - [Controllers](https://github.com/adereksisusanto/codeigniter4-snippets/blob/main/docs/CONTROLLERS.md)
    - [Controller Resources](https://github.com/adereksisusanto/codeigniter4-snippets/blob/main/docs/CONTROLLERS.md#controller-resources)
- #### Add New Snippets.
  - [Controllers](https://github.com/adereksisusanto/codeigniter4-snippets/blob/main/docs/CONTROLLERS.md)
    - [Controller Presenter](https://github.com/adereksisusanto/codeigniter4-snippets/blob/main/docs/CONTROLLERS.md##controller-presenter)
  - [Routes](https://github.com/adereksisusanto/codeigniter4-snippets/blob/main/docs/ROUTES.md)
    - [Placeholders](https://github.com/adereksisusanto/codeigniter4-snippets/blob/main/docs/ROUTES.md#placeholders)
    - [Custom Placeholders](https://github.com/adereksisusanto/codeigniter4-snippets/blob/main/docs/ROUTES.md#custom-placeholders)

## [Released - 0.0.9] - 2021-09-20

- #### Fixed Bugs Snippets.
- #### Add New Snippets.
  - ##### [Validations](https://github.com/adereksisusanto/codeigniter4-snippets/blob/main/docs/VALIDATIONS.md)
    - ##### [Validation in Controller](https://github.com/adereksisusanto/codeigniter4-snippets/blob/main/docs/VALIDATIONS.md#validation-in-controller)

## [Released - 0.0.8] - 2021-04-18

- #### Add New Snippets.
  - ##### [Migrations](https://github.com/adereksisusanto/codeigniter4-snippets/blob/main/docs/MIGRATIONS.md)

## [Released - 0.0.7] - 2021-04-06

- #### Add New Snippets.
  - ##### [Migrations](https://github.com/adereksisusanto/codeigniter4-snippets/blob/main/docs/MIGRATIONS.md)

## [Released - 0.0.6] - 2021-04-05

- #### Fixed Bugs Snippets.
- #### Add New Snippets.
  - ##### [Controllers](https://github.com/adereksisusanto/codeigniter4-snippets/blob/main/docs/CONTROLLERS.md)
  - ##### [Models](https://github.com/adereksisusanto/codeigniter4-snippets/blob/main/docs/MODELS.md)

## [Released - 0.0.5]

- #### Fixed Bugs Links.

## [Released - 0.0.4]

- #### Fixed Bugs.
- #### Change Command ( [read](https://github.com/adereksisusanto/codeigniter4-snippets/blob/main/docs/CHANGE.md) ).
- #### Add Docs.
  - ##### [Routes](https://github.com/adereksisusanto/codeigniter4-snippets/blob/main/docs/ROUTES.md)
  - ##### [Views](https://github.com/adereksisusanto/codeigniter4-snippets/blob/main/docs/VIEWS.md)
- #### Add New Snippets {`[ProjectRoot]/app/Views/**.php`}

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
  </tbody>
  </table>

## License & Download

[![GitHub license](https://img.shields.io/github/license/adereksisusanto/codeigniter4-snippets.svg)](https://github.com/adereksisusanto/codeigniter4-snippets) ![Visual Studio Marketplace Downloads](https://img.shields.io/visual-studio-marketplace/d/adereksisusanto.codeigniter4-snippets)
