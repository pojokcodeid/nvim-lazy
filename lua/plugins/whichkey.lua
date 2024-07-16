return {
  "folke/which-key.nvim",
  lazy = true,
  keys = { "<leader>", '"', "'", "`", "c", "v" },
  event = "VeryLazy",
  opts = function()
    local icons = pcode.icons
    return {
      plugins = {
        marks = false, -- shows a list of your marks on ' and `
        registers = false, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
        spelling = {
          enabled = true,
          suggestions = 20,
        }, -- use which-key for spelling hints
        -- the presets plugin, adds help for a bunch of default keybindings in Neovim
        -- No actual key bindings are created
        presets = {
          operators = false, -- adds help for operators like d, y, ...
          motions = false, -- adds help for motions
          text_objects = false, -- help for text objects triggered after entering an operator
          windows = false, -- default bindings on <c-w>
          nav = false, -- misc bindings to work with windows
          z = false, -- bindings for folds, spelling and others prefixed with z
          g = false, -- bindings for prefixed with g
        },
      }, -- add operators that will trigger motion and text object completion
      -- to enable all native operators, set the preset / operators plugin above
      -- operators = { gc = "Comments" },
      replace = {
        key = {
          function(key)
            return require("which-key.view").format(key)
          end,
          -- { "<Space>", "SPC" },
        },
        desc = {
          { "<Plug>%((.*)%)", "%1" },
          { "^%+", "" },
          { "<[cC]md>", "" },
          { "<[cC][rR]>", "" },
          { "<[sS]ilent>", "" },
          { "^lua%s+", "" },
          { "^call%s+", "" },
          { "^:%s*", "" },
        },
      },
      icons = {
        rules = false,
        breadcrumb = icons.ui.DoubleChevronRight, -- symbol used in the command line area that shows your active key combo
        separator = icons.ui.BoldArrowRight, -- symbol used between a key and it's label
        group = icons.ui.Plus, -- symbol prepended to a group
        keys = {
          Up = " ",
          Down = " ",
          Left = " ",
          Right = " ",
          C = "󰘴 ",
          M = "󰘵 ",
          S = "󰘶 ",
          CR = "󰌑 ",
          Esc = "󱊷 ",
          ScrollWheelDown = "󱕐 ",
          ScrollWheelUp = "󱕑 ",
          NL = "󰌑 ",
          BS = "⌫ ",
          Space = "󱁐 ",
          Tab = "󰌒 ",
          F1 = "󱊫",
          F2 = "󱊬",
          F3 = "󱊭",
          F4 = "󱊮",
          F5 = "󱊯",
          F6 = "󱊰",
          F7 = "󱊱",
          F8 = "󱊲",
          F9 = "󱊳",
          F10 = "󱊴",
          F11 = "󱊵",
          F12 = "󱊶",
        },
      },
      win = {
        -- width = 1,
        -- height = { min = 4, max = 25 },
        -- col = 0,
        row = -1,
        border = "rounded", -- none, single, double, shadow
        padding = { 1, 2 }, -- extra window padding [top/bottom, right/left]
        title = true,
        title_pos = "center",
        zindex = 1000,
        -- Additional vim.wo and vim.bo options
        bo = {},
        wo = {
          -- winblend = 10, -- value between 0-100 0 for fully opaque and 100 for fully transparent
        },
      },
      layout = {
        height = { min = 4, max = 25 }, -- min and max height of the columns
        width = { min = 20, max = 50 }, -- min and max width of the columns
        spacing = 3, -- spacing between columns
        align = "left", -- align columns left, center or right
      },
      show_help = true, -- show help message on the command line when the popup is visible
      show_keys = true, -- show the currently pressed key and its label as a message in the command line
      triggers = "auto", -- automatically setup triggers
      -- Disabled by default for Telescope
      disable = {
        buftypes = {},
        filetypes = { "TelescopePrompt" },
      },
      ---@type false | "classic" | "modern" | "helix"
      preset = "classic",
    }
  end,
  config = function(_, opts)
    local which_key = require("which-key")
    which_key.setup(opts)
    which_key.add({
      { "<leader>a", "<cmd>Alpha<cr>", desc = "󰕮 Alpha", mode = "n" },
      { "<leader>w", "<cmd>w!<CR>", desc = "󰆓 Save", mode = "n" },
      { "<leader>q", "<cmd>q!<CR>", desc = "󰿅 Quit", mode = "n" },
      {
        "<leader>o",
        function()
          require("user.utils.whichkey")._OPEN_EXPLORER()
        end,
        desc = "󱏒 Open Explorer",
        mode = "n",
      },
      { "<leader>h", "<cmd>nohlsearch<CR>", desc = "󱪿 No Highlight", mode = "n" },
      { "<leader>f", "<cmd>Telescope find_files<CR>", desc = " Find files", mode = "n" },
      { "<leader>F", "<cmd>Telescope live_grep<cr>", desc = " Find Text", mode = "n" },
      { "<leader>z", "", desc = " 󱑠 Plugins(Lazy)", mode = "n" },
      { "<leader>zi", "<cmd>Lazy install<cr>", desc = "Install", mode = "n" },
      { "<leader>zs", "<cmd>Lazy sync<cr>", desc = "Sync", mode = "n" },
      { "<leader>zS", "<cmd>Lazy clear<cr>", desc = "Status", mode = "n" },
      { "<leader>zc", "<cmd>Lazy clean<cr>", desc = "Clean", mode = "n" },
      { "<leader>zu", "<cmd>Lazy update<cr>", desc = "Update", mode = "n" },
      { "<leader>zp", "<cmd>Lazy profile<cr>", desc = "Profile", mode = "n" },
      { "<leader>zl", "<cmd>Lazy log<cr>", desc = "Log", mode = "n" },
      { "<leader>zd", "<cmd>Lazy debug<cr>", desc = "Debug", mode = "n" },
    })
    which_key.add(pcode.whichkey or {})
  end,
}
