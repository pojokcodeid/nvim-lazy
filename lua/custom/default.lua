-- custom colorscheme
-- colorscheme ready :
-- tokyonight, tokyonight-night, tokyonight-storm, tokyonight-day, tokyonight-moon
-- gruvbox-baby (default)
-- sonokai, sonokai_atlantis,
-- sonokai_andromeda,sonokai_shusia,sonokai_maia,sonokai_espresso
-- material, material_deepocean, material_palenight, material_lighter, material_darker
-- onedark, onedark_vivid, onedark_dark
-- lunar
-- nord
-- catppuccin, catppuccin-latte, catppuccin-frappe, catppuccin-macchiato, catppuccin-mocha
-- dracula
-- nightfox, dayfox, dawnfox, duskfox, nordfox, terafox, carbonfox
-- github_dark, github_dark_default, github_dark_colorblind, github_dark_dimmed
-- solarized-osaka
vim.g.pcode_colorscheme = "solarized-osaka"

-- 0 =off   1= on
vim.g.pcode_transparent_mode = 0
-- rounded
-- roundedall
-- square
-- triangle
-- parallelogram
-- transparent
-- default
vim.g.pcode_lualinetheme = "roundedall"
-- 0 disable progress
-- 1 lualine lsp progress
-- 2 fidget progress
vim.g.pcode_progress = 1

-- 1 ( format jalan)  0 (fromat off)
vim.g.pcode_format_on_save = 1

-- ini hanya untuk lsp yg tidak support masson
-- untuk referesi support language kunjungi link dibawah
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
vim.g.pcode_lsp_installer = {
  -- "yamlls",
  -- tambahkan di bawah sini setelah melakukan :masoninstall
}

-- use for lsp diagnostics virtual text
vim.g.pcode_lsp_virtualtext = true

-- use for lsp ghost text config
vim.g.pcode_lspghost_text = false

-- untuk referesi support language kunjungi link dibawah
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
vim.g.pcode_mason_ensure_installed = { -- sebelumnya register_lsp
  -- "yamlls",
  -- "intelephense",
  -- "marksman",
  -- "csharp_ls",
  -- "clangd",
  -- "dartls",
  -- "kotlin_language_server",
  -- tambahkan di bawah sini setelah melakukan :masoninstall
}
vim.g.pcode_unregister_lsp = {
  "jdtls", -- tambahkan di bawah ini
}

-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
vim.g.pcode_null_ls_ensure_installed = {
  "stylua",
}

-- dap instal hanya support linux dan mac
-- https://github.com/jay-babu/mason-nvim-dap.nvim/blob/main/lua/mason-nvim-dap/mappings/source.lua
-- atau gunakan :MasonInstall
vim.g.pcode_dap_ensure_installed = {
  -- "python",
}

-- https://github.com/folke/which-key.nvim
vim.g.pcode_whichkey = {
  -- contoh penambahan
  ["k"] = {
    name = "Example",
    k = { '<cmd>lua print("Testing")<cr>', "Example" },
  },
  ["r"] = {
    name = "Run",
    j = { "<cmd>Jaq float<CR>", "Run With Jaq" },
  },
}

-- https://github.com/CRAG666/code_runner.nvim
-- ready default java, python, typescript, javascript, rust, cpp, scss
vim.g.pcode_coderunner = {
  go = "go run $fileName",
  html = "live-server $dir/$fileName",
}

-- config for optional cmp
vim.g.pcode_cmprg = false --https://github.com/lukas-reineke/cmp-rg
vim.g.pcode_cmpcalc = false --https://github.com/hrsh7th/cmp-calc
vim.g.pcode_cmptag = false --https://github.com/quangnguyen30192/cmp-nvim-tags
