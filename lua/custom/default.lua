-- custom colorscheme
-- colorscheme ready :
-- tokyonight, tokyonight-night, tokyonight-storm, tokyonight-day, tokyonight-moon
-- gruvbox-baby (default)
-- sonokai, sonokai_atlantis,
-- sonokai_andromeda,sonokai_shusia,sonokai_maia,sonokai_espresso
-- material, material_deepocean, material_palenight, material_lighter, material_darker
-- onedark, onedark_vivid, onedark_dark
-- nord
-- catppuccin, catppuccin-latte, catppuccin-frappe, catppuccin-macchiato, catppuccin-mocha
-- dracula
-- nightfox, dayfox, dawnfox, duskfox, nordfox, terafox, carbonfox
-- github_dark, github_dark_default, github_dark_colorblind, github_dark_dimmed
-- solarized-osaka
-- darcula-dark
-- juliana
pcode.colorscheme = "dracula"
-- 0 =off   1= on
pcode.transparent_mode = 0

-- https://github.com/nvim-lualine/lualine.nvim
-- rounded
-- roundedall
-- square
-- triangle
-- parallelogram
-- transparent
-- default
pcode.lualinetheme = "roundedall"
-- 0 disable progress
-- 1 lualine lsp progress
-- 2 fidget progress
pcode.progress = 1
-- 0 = on full text mode info,
-- 1 = on initial mode + logo
-- 2 = logo only
-- 3 = initial only
-- 4 = off
pcode.show_mode = 3

-- true or false
pcode.format_on_save = true
pcode.format_timeout_ms = 5000

-- https://github.com/mfussenegger/nvim-lint
-- https://github.com/stevearc/conform.nvim
-- use conform and nvim-lint if set true
pcode.disable_null_ls = false

pcode.treesitter_ensure_installed = {}
pcode.tscontext = false
-- ini hanya untuk lsp yg tidak support masson
-- untuk referesi support language kunjungi link dibawah
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
pcode.lsp_installer = {
  -- "yamlls",
  -- tambahkan di bawah sini setelah melakukan :masoninstall
}

-- use for lsp diagnostics virtual text
pcode.lsp_virtualtext = true

-- use for lsp ghost text config
pcode.lspghost_text = false

-- untuk referesi support language kunjungi link dibawah
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
pcode.mason_ensure_installed = { -- sebelumnya register_lsp
  -- "yamlls",
  -- tambahkan di bawah sini setelah melakukan :masoninstall
}
pcode.unregister_lsp = {
  -- "jdtls", -- tambahkan di bawah ini
}

-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
pcode.null_ls_ensure_installed = {
  "stylua",
}

-- dap instal hanya support linux dan mac
-- https://github.com/jay-babu/mason-nvim-dap.nvim/blob/main/lua/mason-nvim-dap/mappings/source.lua
-- atau gunakan :MasonInstall
pcode.dap_ensure_installed = {
  -- "python",
}

-- https://github.com/folke/which-key.nvim
pcode.whichkey = {
  -- contoh penambahan
  ["r"] = {
    name = "  Run",
    j = { "<cmd>Jaq float<CR>", "Run With Jaq" },
  },
}

-- https://github.com/CRAG666/code_runner.nvim
-- ready default java, python, typescript, javascript, rust, cpp, scss
pcode.coderunner = {
  go = "go run $fileName",
  html = "live-server $dir/$fileName",
}

-- https://github.com/nvim-tree/nvim-tree.lua
-- 0 = normal
-- 1 = float
pcode.nvimtree_isfloat = 0

-- https://github.com/roobert/tailwindcss-colorizer-cmp.nvim
pcode.tailwindcolorizer = false

-- https://github.com/Exafunction/codeium.vim
pcode.codeium = false

-- https://github.com/Exafunction/codeium.nvim
pcode.codeium_nvim = true

-- https://github.com/kevinhwang91/nvim-ufo
pcode.nvimufo = false

-- https://github.com/echasnovski/mini.indentscope
pcode.indentscope = true

-- https://github.com/echasnovski/mini.animate
pcode.minianimate = false

-- https://github.com/hrsh7th/nvim-cmp
pcode.disable_cmpdoc = false

-- https://github.com/rachartier/tiny-devicons-auto-colors.nvim
pcode.adaptive_color_icon = true

-- https://github.com/lukas-reineke/virt-column.nvim
pcode.columnline = true

-- https://github.com/okuuva/auto-save.nvim
pcode.auto_save = false

-- https://github.com/folke/todo-comments.nvim
pcode.todo_comment = false

-- https://github.com/nvim-telescope/telescope.nvim
---@alias telescope_themes
---| "cursor"   # see `telescope.themes.get_cursor()`
---| "dropdown" # see `telescope.themes.get_dropdown()`
---| "ivy"      # see `telescope.themes.get_ivy()`
---| "center"   # retain the default telescope theme
pcode.telescope_theme_find_file = "center"
pcode.telescope_theme_live_grep = "dropdown"

-- https://github.com/ThePrimeagen/refactoring.nvim
pcode.refactoring = false

-- https://github.com/kristijanhusak/vim-dadbod-ui
pcode.database = false

-- https://github.com/rest-nvim/rest.nvim
pcode.rest_client = true

-- https://github.com/mfussenegger/nvim-dap
pcode.nvim_dap = true -- not support for windows os (auto config mason-nvim-dap)

-- conefig special support test & dap
pcode.active_rust_config = false
pcode.active_javascript_config = {
  active = true,
  jest_command = "npm test -- ",
  jest_config = "jest.config.mjs",
}
pcode.active_php_config = false
pcode.active_golang_config = false
pcode.active_python_config = false
pcode.active_cpp_config = false
pcode.active_java_config = {
  active = false,
  project = "gradle", -- gradle or maven
}
