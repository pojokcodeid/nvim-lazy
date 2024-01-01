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

<table>
<tr><td>:q  or :quit    </td><td>-> untuk keluar dari form</td></tr>
<tr><td>:w  or :write   </td><td>-> untuk menulis hasil ketik kedalam file (simpan)</td></tr>
<tr><td>:wq				      </td><td>-> simpan dan keluar</td></tr>
<tr><td>:q!				      </td><td>-> Keluar dan jangan simpan</td></tr>
<tr><td>escape		      </td><td>-> normalmode</td></tr>
<tr><td>i				        </td><td>-> insert mode</td></tr>
<tr><td>v				        </td><td>-> visual mode yaratnya harus normal mode dulu, ini unutk block dengan panah ke bawah dan tekan d untuk deletenya</td></tr>
<tr><td>H 				      </td><td>-> kiri</td></tr>
<tr><td>j 				      </td><td>-> bawah</td></tr>
<tr><td>k 				      </td><td>-> atas</td></tr>
<tr><td>l 				      </td><td>-> Kanan</td></tr>
<tr><td>:ter			      </td><td>-> untuk membuka terminal</td></tr>
<tr><td>0 atau home		  </td><td>-> memindahkan kursor keawal line</td></tr>
<tr><td>$ atau end		  </td><td>-> cursor ke end of line</td></tr>
<tr><td>gg				      </td><td>-> memindahkan kursor ke paling atas</td></tr>
<tr><td>G				        </td><td>-> memindahkan kursor ke akhir dari halaman</td></tr>
<tr><td>w				        </td><td>-> memindahkan kursor ke kata berikutnya tanpa sepasi</td></tr>
<tr><td>3w				      </td><td>-> memindahkan kursor ke 3 kata berikutnya</td></tr>
<tr><td>b				        </td><td>-> memindahkan kursor ke kata sebelumnya</td></tr>
<tr><td>3b				      </td><td>-> memindahkan kursor ke 3 kata sebelunya</td></tr>
<tr><td>(				        </td><td>-> memindahkankursor ke paragraf seblumnya</td></tr>
<tr><td>)				        </td><td>-> memindahkan kursor ke pararaf berikutnya</td></tr>
<tr><td>dd				      </td><td>-> menghapus text 1 baris</td></tr>
<tr><td>dw				      </td><td>-> menghapus 1 kata</td></tr>
<tr><td>d$				      </td><td>-> menghapus kata sampai akhir line dari posisi cursor</td></tr>
<tr><td>d0				      </td><td>-> menghapus kata sampai awal line dari psosi cursor</td></tr>
<tr><td>U				        </td><td>-> untuk undo</td></tr>
<tr><td>CTRL + r		    </td><td>-> Rendo</td></tr>
<tr><td>Yp				      </td><td>-> duplicate line code</td></tr>
<tr><td>yyp				      </td><td>-> sama duplicate line code</td></tr>
<tr><td>:m+1			      </td><td>-> pindah 1 baris kebawah</td></tr>
<tr><td>:m-1			      </td><td>-> pindah 1 baris keatas</td></tr>
<tr><td>d				        </td><td>-> delete file, delete code yang di seleksi dengan view mode</td></tr>
<tr><td>:e newfolder/newfile.ext    </td><td>-> membuat file baru di folder baru</td></tr>
<tr><td>:f newfolder/newfile.ext 	</td><td>-> untuk mengcopy file dari file yang terbuka</td></tr>
<tr><td>bdw				      </td><td>-> menghapus 1 kata</td></tr>
<tr><td>dw				      </td><td>-> menghapus ke kanan dalam 1 kata pada posisi cursor</td></tr>
</table>


## Thanks To

https://github.com/LunarVim/Neovim-from-scratch <br>
https://github.com/AstroNvim/AstroNvim
