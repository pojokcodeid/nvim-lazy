<div align="center">

# Nvim-Lazy

![Neovim](https://img.shields.io/badge/NeoVim-%2358A143.svg?&style=for-the-badge&logo=neovim&logoColor=white)
![Lua](https://img.shields.io/badge/lua-%233C2D72.svg?style=for-the-badge&logo=lua&logoColor=white)

<p align="center">
  <a href="https://github.com/pojokcodeid/nvim-lazy/pulse">
    <img src="https://img.shields.io/github/last-commit/pojokcodeid/nvim-lazy?style=for-the-badge&logo=github&color=8dc4e4&logoColor=D9E0EE&labelColor=302D41"/>
  </a>
  <a href="https://github.com/pojokcodeid/nvim-lazy/latest">
    <img src="https://img.shields.io/github/v/release/pojokcodeid/nvim-lazy?style=for-the-badge&logo=gitbook&color=9bd5ca&logoColor=D9E0EE&labelColor=302D41"/>
  </a>
  <a href="https://github.com/pojokcodeid/nvim-lazy/stargazers">
    <img src="https://img.shields.io/github/stars/pojokcodeid/nvim-lazy?style=for-the-badge&logo=apachespark&color=eed50f&logoColor=D9E0EE&labelColor=302D41"/>
  </a>
  <a href="https://github.com/pojokcodeid/nvim-lazy/blob/main/LICENSE"><img src="https://img.shields.io/github/license/pojokcodeid/nvim-lazy?color=%2362afef&style=for-the-badge"></a>
  <a href="https://github.com/pojokcodeid/nvim-lazy/issues">
  <img
        alt="Issues"
        src="https://img.shields.io/github/issues-raw/pojokcodeid/nvim-lazy?colorA=364A4f&colorB=F5A97F&logo=github&logoColor=D9E0EE&style=for-the-badge">
    </a>
  </a>
  <a href="https://github.com/pojokcodeid/nvim-lazy">
      <img alt="Repo Size" src="https://img.shields.io/github/repo-size/pojokcodeid/nvim-lazy?color=%24DDB6F2&label=SIZE&logo=codesandbox&style=for-the-badge&logoColor=D9E0EE&labelColor=302D41" />
    </a>
    <a href="https://twitter.com/intent/follow?screen_name=pojokcodeid_">
      <img alt="follow on Twitter" src="https://img.shields.io/twitter/follow/pojokcodeid_?style=for-the-badge&logo=twitter&color=9aadf3&logoColor=D9E0EE&labelColor=302D41" />
    </a>
</p>

</div>

## HOME

![home!](img/home.png)

## Demo

![demo!](img/demo.gif)

## Treesitter dan LSP

![demo!](img/ts_lsp.gif)

## Plugins Manager

![PlugManaget!](img/plugins_manager.png)

## Javascript Project

![PlugManaget!](img/node.png)

<!-- ## Layout -->

<!-- ![PlugManaget!](img/coding.png) -->

# NeoVim Install & Configuration Guide

## Visit <a href="https://github.com/pojokcodeid/nvim-lazy/wiki/">Wiki</a>

## Basic Requirement

2. Install Neovim 9.0+ https://github.com/neovim/neovim/releases/tag/stable
3. C++ (windows) Compiler https://www.msys2.org/
4. GIT https://git-scm.com/download/win
5. NodeJs https://nodejs.org/en/
6. Ripgrep https://github.com/BurntSushi/ripgrep
7. Lazygit https://github.com/jesseduffield/lazygit
8. Nerd Font https://github.com/ryanoasis/nerd-fonts
9. Windows Terminal (Windows) https://apps.microsoft.com/store/detail/windows-terminal/9N0DX20HK701?hl=en-id&gl=id
10. Powershell (windows) https://apps.microsoft.com/store/detail/powershell/9MZ1SNWT0N5D?hl=en-id&gl=id

# Windows

```
git clone https://github.com/pojokcodeid/nvim-lazy-basic.git "$env:LOCALAPPDATA\nvim"
nvim
```

# Linux

```bash
git clone https://github.com/pojokcodeid/nvim-lazy-basic.git ~/.config/nvim
```

# Shortcut Most-Used

```text
:q  or :quit    -> untuk keluar dari form
:w  or :write   -> untuk menulis hasil ketik kedalam file (simpan)
:wq				-> simpan dan keluar
:q!				-> Keluar dan jangan simpan
escape			-> normalmode
i				-> insert mode
v				-> visual mode yaratnya harus normal mode dulu, ini unutk block dengan panah ke bawah dan tekan d untuk deletenya
H 				-> kiri
j 				-> bawah
k 				-> atas
l 				-> Kanan
:ter			-> untuk membuka terminal
0 atau home		-> memindahkan kursor keawal line
$ atau end		-> cursor ke end of line
gg				-> memindahkan kursor ke paling atas
G				-> memindahkan kursor ke akhir dari halaman
w				-> memindahkan kursor ke kata berikutnya tanpa sepasi
3w				-> memindahkan kursor ke 3 kata berikutnya
b				-> memindahkan kursor ke kata sebelumnya
3b				-> memindahkan kursor ke 3 kata sebelunya
(				-> memindahkankursor ke paragraf seblumnya
)				-> memindahkan kursor ke pararaf berikutnya
dd				-> menghapus text 1 baris
dw				-> menghapus 1 kata
d$				-> menghapus kata sampai akhir line dari posisi cursor
d0				-> menghapus kata sampai awal line dari psosi cursor
U				-> untuk undo
CTRL + r		-> Rendo
Yp				-> duplicate line code
yyp				-> sama duplicate line code
:m+1			-> pindah 1 baris kebawah
:m-1			-> pindah 1 baris keatas
d				-> delete file, delete code yang di seleksi dengan view mode
:e newfolder/newfile.ext    -> membuat file baru di folder baru
:f newfolder/newfile.ext 	-> untuk mengcopy file dari file yang terbuka
bdw				-> menghapus 1 kata
dw				-> menghapus ke kanan dalam 1 kata pada posisi cursor
```

## Thanks To

https://github.com/LunarVim/Neovim-from-scratch <br>
https://github.com/AstroNvim/AstroNvim
