<h1 align="center">Nvim-Lazy</h1>

<p align="center">
  <a href="https://github.com/pojokcodeid/nvim-lazy/pulse">
    <img src="https://img.shields.io/github/last-commit/pojokcodeid/nvim-lazy?style=for-the-badge&logo=github&color=7dc4e4&logoColor=D9E0EE&labelColor=302D41"/>
  </a>
  <a href="https://github.com/pojokcodeid/nvim-lazy/latest">
    <img src="https://img.shields.io/github/v/release/pojokcodeid/nvim-lazy?style=for-the-badge&logo=gitbook&color=8bd5ca&logoColor=D9E0EE&labelColor=302D41"/>
  </a>
  <a href="https://github.com/pojokcodeid/nvim-lazy/stargazers">
    <img src="https://img.shields.io/github/stars/pojokcodeid/nvim-lazy?style=for-the-badge&logo=apachespark&color=eed49f&logoColor=D9E0EE&labelColor=302D41"/>
  </a>
  <a href="https://github.com/pojokcodeid/nvim-lazy/blob/main/LICENSE"><img src="https://img.shields.io/github/license/pojokcodeid/nvim-lazy?color=%2361afef&style=for-the-badge"></a>
  <a href="https://github.com/pojokcodeid/nvim-lazy/issues"><img src="https://img.shields.io/github/issues/pojokcodeid/nvim-lazy?color=%23d19a66&style=for-the-badge"></a>
</p>

## HOME

![home!](img/home.png)

## Plugins Manager

![PlugManaget!](img/plugins_manager.png)
## Layout

![PlugManaget!](img/coding.png)


## PHP

![LARAVEL!](img/laravel.jpeg)

# Panduan Install Dan Konfigurasi NeoVim
# Daftar Isi
-   [Kebutuhan Dasar](#Kebutuhan-Dasar)
-   [Panduan Windows](#Panduan-Windows)
-   [Panduan Linux Debian Based](#Panduan-Linux-Debian-Based)
-   [Configurasi](#Configurasi)
    -   [KeyMap](#KeyMap)
    -   [Config LSP](#Config-LSP)
    -   [Comfig Treesitter](#Comfig-Treesitter)
    -   [Ubah Dashboard](#Ubah-Dashboard)
    -   [Custom Null-ls](#Custom-Null-ls)
    -   [Register LSP](#Register-LSP)
    -   [Whichkey](#Whichkey)
    -   [Format On Save](#Format-On-Save)
    -   [Custom Autocommand](#Custom-Autocommand)
    -   [Cutom Default Option](#Cutom-Default-Option)
    -   [Custom Key Mapping](#Custom-Key-Mapping)
    -   [Custom Plugins](#Custom-Plugins)
    -   [Custom Sippets](#Custom-Snippets)
-   [List Plugins](#List-Plugins)


## Kebutuhan Dasar

1. Install Neovim 8.0+ https://github.com/neovim/neovim/releases/tag/v0.8.2
2. C++ (windows) Compiler https://www.msys2.org/
3. GIT https://git-scm.com/download/win
4. NodeJs https://nodejs.org/en/
5. Ripgrep https://github.com/BurntSushi/ripgrep
6. Lazygit https://github.com/jesseduffield/lazygit
7. Nerd Font https://github.com/ryanoasis/nerd-fonts
8. Windows Terminal (Windows) https://apps.microsoft.com/store/detail/windows-terminal/9N0DX20HK701?hl=en-id&gl=id
9. Powershell (windows) https://apps.microsoft.com/store/detail/powershell/9MZ1SNWT0N5D?hl=en-id&gl=id

# Panduan Windows

- Pastikan sudah menginstall kebutuhan dasar diatas
- Jalankan Script Dibawah pada Powershell

```
git clone https://github.com/pojokcodeid/nvim-lazy-basic.git "$env:LOCALAPPDATA\nvim"
nvim
```

# Panduan Linux Debian Based

1.  Pastikan Acess Administrator

```
visudo
[nama user] ALL=(ALL:ALL) ALL
[nama user] ALL=(ALL) NOPASSWD:ALL
```

2. Install Neovim

```bash
sudo apt-get install wget
mkdir download
cd download
wget https://github.com/neovim/neovim/releases/download/v0.8.1/nvim-linux64.deb
sudo apt-get install ./nvim-linux64.deb
nvim --version
```

3. Check G++

```bash
g++ --version
```

4. Install NodeJS

```bash
sudo apt-get install curl
sudo apt install build-essential libssl-dev
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
source ~/.bashrc
nvm install 18.13.0
node --version
npm --version
```

5. Install unzip, ripgrep

```bash
sudo apt-get install unzip
sudo apt-get install ripgrep
```

6. Install lazygit

```bash
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep '"tag_name":' |  sed -E 's/.*"v*([^"]+)".*/\1/')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
sudo tar xf lazygit.tar.gz -C /usr/local/bin lazygit
lazygit --version
```

7. Install Git

```bash
sudo apt-get install git
git --version
```

8.  Clone Config

```bash
git clone https://github.com/pojokcodeid/nvim-lazy-basic.git ~/.config/nvim
```

# Configurasi

- Struktur File <br>

```
  .
  ├── init.lua
  ├── lazy-lock.json
  ├── lua
  │   ├── custom
  │   │   ├── dashboard.lua
  │   │   ├── format_onsave.lua
  │   │   ├── lsp_installer.lua
  │   │   ├── null-ls.lua
  │   │   └── register_lsp.lua
  │   ├── default
  │   │   ├── autocommands.lua
  │   │   ├── init.lua
  │   │   ├── keymaps.lua
  │   │   ├── lazy.lua
  │   │   └── options.lua
  │   └── plugin
  │       ├── dapui.lua
  │       ├── init.lua
  │       └── lualine.lua
```

| Link                           | Keterangan                                                          |
|--------------------------------|---------------------------------------------------------------------|
| init.lua                       | (ini pintu masuk untuk config)                                      |
| lua/custom/dashborad.lua       | (ini digunkaan untuk custom dashboard)                              |
| lua/custom/format_onsave.lua   | (ini digunakan untuk setting ketika save mau di format atau tidak)  |
| lua/custom/lsp_installer.lua   | (ini digunakan untuk install LSP yang tidak  support mason)         |
| lua/custom/null-ls.lua         | (ini digunakan untuk registrasi formater dan linter)                |
| lua/custom/register_lsp.lua    | (ini untuk registrasi LSP yang tidak terbaca  langsung)             |
| lua/default/init.lua           | (pintu masuk acess config)                                          |
| lua/default/autocommands.lua   | (ini digunakan untuk custom autocommands)                           |
| lua/default/keymaps.lua        | (ini digunakan untuk custom key maps)                               |
| lua/default/lazy.lua           | (ini untuk plugin manager, jangan di ubah)                          |
| lua/default/options.lua        | (ini digunakan untuk overide default config nvim)                   |
| lua/plugin/\*                  | (ini digunakan untuk custom plugins, tambah dan override)           |

## KeyMap
- leader  = space bar
- n       = normal mode
- i       = insert mode 
- v       = visual mode
<table>
<tr>
  <td>Mode</td>
	<td>Key</td>
	<td>Keterangan</td>
</tr>
<tr>
  <td>n</td>
	<td>leader</td>
	<td>Membuka Wich Key</td>
</tr>
<tr>
  <td>n</td>
	<td>leader + /</td>
	<td>Comment String</td>
</tr>
<tr>
  <td>n</td>
	<td>leader + a</td>
	<td>Alpha dashboard</td>
</tr>
<tr>
  <td>n</td>
	<td>leader + b</td>
	<td>Buffer</td>
</tr>
<tr>
  <td>n</td>
	<td>leader + c</td>
	<td>Close Buffer</td>
</tr>
<tr>
  <td>n</td>
	<td>leader + e</td>
	<td>Exploler (Nvim Tree)</td>
</tr>
<tr>
  <td>n</td>
	<td>leader + e</td>
	<td>Exploler (Nvim Tree)</td>
</tr>
<tr>
  <td>n</td>
	<td>leader + F</td>
	<td>Pencarian Text</td>
</tr>
<tr>
  <td>n</td>
	<td>leader + f</td>
	<td>Pencarian File</td>
</tr>
<tr>
  <td>n</td>
	<td>leader + h</td>
	<td>Tidak ada hilight</td>
</tr>
<tr>
  <td>n</td>
	<td>leader + o</td>
	<td>Symbol Outline</td>
</tr>
<tr>
  <td>n</td>
	<td>leader + q</td>
	<td>Keluar Neovim</td>
</tr>
<tr>
  <td>n</td>
	<td>leader + w</td>
	<td>Simpan File</td>
</tr>
<tr>
  <td>n</td>
	<td>leader + g</td>
	<td>git</td>
</tr>
<tr>
  <td>n</td>
	<td>leader + l</td>
	<td>LSP</td>
</tr>
<tr>
  <td>n</td>
	<td>leader + p</td>
	<td>Plugin (Lazy)</td>
</tr>
<tr>
  <td>n</td>
	<td>leader + r</td>
	<td>Run Program</td>
</tr>
<tr>
  <td>n</td>
	<td>leader + s</td>
	<td>Pencarian</td>
</tr>
<tr>
  <td>n</td>
	<td>leader + t</td>
	<td>Terminal</td>
</tr>
<tr>
  <td>v</td>
	<td>leader + /</td>
	<td>Comment Blok String</td>
</tr>
</table>

## Config LSP

- Jalankan dengan commond mode

```
:MasonInstall html-lsp css-lsp typescript-language-server
```

- jika tidak terbaca lspnya tambahkan pada file lua/custom/register_lsp.lua
- Rujukan Lnguage Support <br>
  https://github.com/williamboman/mason.nvim/blob/main/PACKAGES.md

## Comfig Treesitter

- Jalankan Code Berikut pada command

```lua
:TSInstall html css javascript ..... dst
```

- Rujukan Language Support <br>
  https://github.com/nvim-treesitter/nvim-treesitter#supported-languages

## Ubah Dashboard

### Cari File lua/custom/dashboard.lua

- Edit Bagian ini

```lua
M.dashboard = {
	[[                               __                ]],
	[[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
	[[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
	[[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
	[[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
	[[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
}

```
- Link Generate Dasboard
  https://patorjk.com/software/taag/

## Custom Null-ls
### cari file lua/custom/null-ls.lua
- tambahkan pada bagian berikut 
```lua
local m = {
	sources = {
		formatting.stylua, -- tambahkan di bawah sini
		diagnostics.flake8, -- tambahkan di bawah sini
	},
}
```
## Register LSP
### Cari file lua/custom/register_lsp.lua
- ini dilakukan jika LSP tidak terbaca 
```lua
local m = {
	lspreg = {
		"yamlls",
		"jdtls",
		"intelephense",
		"marksman",
		"csharp_ls",
		"clangd",
		"dartls",
		"kotlin_language_server",
		-- tambahkan di bawah sini setelah melakukan :masoninstall
	},
}
```
## Whichkey
### cari file lua/custom/whichkey.lua
-- file ini digunakan untuk registrasi key mapping 
```lua
["k"] = {
	name = "Example",
	k = { '<cmd>lua print("Testing")<cr>', "Example" },
},
```
## Format On Save
### cari file lua/custom/format_onsave.lua
- lakukan enable atau disable 
```lua
local M = {
	disable = 0, -- 0 ( format jalan)  1 (fromat off)
}
```
## Custom Autocommand
### cari file lua/default/autocommand.lua
- Lakukan config sesuai kebutuhan
## Cutom Default Option
### cari file lua/default/options.lua
```
-- custom oprion disini

vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt
opt.cmdheight = 0
```
## Custom Key Mapping
### cari file lua/dafault/keymaps.lua
```
-- custom key maps disini
local function map(mode, l, r, desc)
	vim.keymap.set(mode, l, r, { desc = desc })
end
-- ini adalah contoh
map("n", "]h", '<cmd>lua print("Testing")<cr>', "Testing Mapping")
```
## Custom Plugins
### cari file lua/plugin/*
- masukan semua plugin pada folder tersebut
- disable plugins
```
{ "folke/trouble.nvim", enabled = false }, -- ini untuk disable plugin
```
- tambah plugins
```
{"nvim-treesitter/nvim-treesitter"},
```
untuk panduan silahkan cek <br>
https://github.com/folke/lazy.nvim#Examples
## Custom-Snippets
### Cari File nvim/my-snippet/package.json
- tambahkan custom snippets pada bagian berikut
```json
"contributes": {
  "snippets": [
    {
      "language": "html",
      "path": "./html/snippets/javascript.json"
    },
    {
      "language": "html",
      "path": "./html/javascript/javascript.json"
    },
  ]
}
```
## Seting Bahasa Pemprograman

- https://youtube.com/playlist?list=PLhzwHCJWMbnvhPy0wqZGVBRUEAgS93iuk

## List Plugins
<table>
<tr><td>Link</td><td>Keterangan</td></tr>
<tr><td>https://github.com/folke/lazy.nvim</td><td>Lazy</td></tr>
<tr><td>https://github.com/nvim-lua/plenary.nvim</td><td>Plenary </td></tr>
<tr><td>https://github.com/windwp/nvim-autopairs</td><td>Nvim-Autopairs </td></tr>
<tr><td>https://github.com/numToStr/Comment.nvim</td><td>Comment.nvim</td></tr>
<tr><td>https://github.com/JoosepAlviste/nvim-ts-context-commentstring</td><td>nvim-ts-context-commentstring</td></tr>
<tr><td>https://github.com/nvim-tree/nvim-web-devicons</td><td>nvim-web-devicons</td></tr>
<tr><td>https://github.com/nvim-tree/nvim-tree.lua</td><td>nvim-tree.lua</td></tr>
<tr><td>https://github.com/akinsho/bufferline.nvim</td><td>bufferline.nvim</td></tr>
<tr><td>https://github.com/moll/vim-bbye</td><td>vim-bbye</td></tr>
<tr><td>https://github.com/akinsho/toggleterm.nvim</td><td>toggleterm.nvim</td></tr>
<tr><td>https://github.com/lewis6991/impatient.nvim</td><td>impatient.nvim</td></tr>
<tr><td>https://github.com/lukas-reineke/indent-blankline.nvim</td><td>indent-blankline.nvim</td></tr>
<tr><td>https://github.com/goolord/alpha-nvim</td><td>alpha-nvim</td></tr>
<tr><td>https://github.com/folke/which-key.nvim</td><td>which-key.nvim</td></tr>
<tr><td>https://github.com/folke/tokyonight.nvim</td><td>tokyonight.nvim</td></tr>
<tr><td>https://github.com/hrsh7th/nvim-cmp</td><td>nvim-cmp</td></tr>
<tr><td>https://github.com/hrsh7th/cmp-buffer</td><td>cmp-buffer</td></tr>
<tr><td>https://github.com/nvim-treesitter/nvim-treesitter</td><td>nvim-treesitter</td></tr>
<tr><td>https://github.com/L3MON4D3/LuaSnip</td><td>LuaSnip</td></tr>
<tr><td>https://github.com/windwp/nvim-autopairs</td><td>nvim-autopairs</td></tr>
<tr><td>https://github.com/hrsh7th/cmp-nvim-lua</td><td>cmp-nvim-lua</td></tr>
<tr><td>https://github.com/neovim/nvim-lspconfig</td><td>nvim-lspconfig</td></tr>
<tr><td>https://github.com/williamboman/mason-lspconfig.nvim</td><td>mason-lspconfig.nvim</td></tr>
<tr><td>https://github.com/williamboman/mason.nvim</td><td>williamboman/mason.nvim</td></tr>
<tr><td>https://github.com/jose-elias-alvarez/null-ls.nvim</td><td>null-ls.nvim</td></tr>
<tr><td>https://github.com/jayp0521/mason-null-ls.nvim</td><td>mason-null-ls.nvim</td></tr>
</table>

## key lazygit

<a href="https://github.com/jesseduffield/lazygit/blob/master/docs/keybindings/Keybindings_en.md?fbclid=IwAR3BogewbYeP0PbPY1pewCkq2c3PKua3eHi-00rHpdSdz9gSKrY71Pv10u4" target="_blank">Key Lazygit</a>

## Terima Kasih

https://github.com/LunarVim/Neovim-from-scratch <br>
https://github.com/AstroNvim/AstroNvim
