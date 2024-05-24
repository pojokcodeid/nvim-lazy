local gruvbox = true
local dracula = false
local tokyonight = false
local nord = false
local sonokai = false
local lunar = false
local material = false
local onedark = false
local catppuccin = false
local nightfox = false

local sonokai_style = "default"
local material_style = "oceanic"
local onedark_style = "dark"

_G.switch = function(param, case_table)
  local case = case_table[param]
  if case then
    return case()
  end
  local def = case_table["default"]
  return def and def() or nil
end

local color = vim.g.pcode_colorscheme or "gruvbox-baby"
switch(color, {
  ["tokyonight"] = function()
    gruvbox = false
    tokyonight = true
  end,
  ["tokyonight-night"] = function()
    gruvbox = false
    tokyonight = true
  end,
  ["tokyonight-storm"] = function()
    gruvbox = false
    tokyonight = true
  end,
  ["tokyonight-day"] = function()
    gruvbox = false
    tokyonight = true
  end,
  ["tokyonight-moon"] = function()
    gruvbox = false
    tokyonight = true
  end,
  ["sonokai"] = function()
    gruvbox = false
    sonokai = true
    sonokai_style = "default"
  end,
  ["sonokai_atlantis"] = function()
    gruvbox = false
    sonokai = true
    sonokai_style = "atlantis"
  end,
  ["sonokai_andromeda"] = function()
    gruvbox = false
    sonokai = true
    sonokai_style = "andromeda"
  end,
  ["sonokai_shusia"] = function()
    gruvbox = false
    sonokai = true
    sonokai_style = "shusia"
  end,
  ["sonokai_maia"] = function()
    gruvbox = false
    sonokai = true
    sonokai_style = "maia"
  end,
  ["sonokai_espresso"] = function()
    gruvbox = false
    sonokai = true
    sonokai_style = "espresso"
  end,
  ["material"] = function()
    gruvbox = false
    material = true
  end,
  ["material_deepocean"] = function()
    gruvbox = false
    material = true
    material_style = "deep ocean"
  end,
  ["material_palenight"] = function()
    gruvbox = false
    material = true
    material_style = "palenight"
  end,
  ["material_lighter"] = function()
    gruvbox = false
    material = true
    material_style = "lighter"
  end,
  ["material_darker"] = function()
    gruvbox = false
    material = true
    material_style = "darker"
  end,
  ["onedark"] = function()
    gruvbox = false
    onedark = true
  end,
  ["onedark_darker"] = function()
    gruvbox = false
    onedark = true
    onedark_style = "darker"
  end,
  ["onedark_cool"] = function()
    gruvbox = false
    onedark = true
    onedark_style = "cool"
  end,
  ["onedark_deep"] = function()
    gruvbox = false
    onedark = true
    onedark_style = "deep"
  end,
  ["onedark_warm"] = function()
    gruvbox = false
    onedark = true
    onedark_style = "warm"
  end,
  ["onedark_warmer"] = function()
    gruvbox = false
    onedark = true
    onedark_style = "warmer"
  end,
  ["onedark_light"] = function()
    gruvbox = false
    onedark = true
    onedark_style = "light"
  end,
  ["lunar"] = function()
    gruvbox = false
    lunar = true
  end,
  ["nord"] = function()
    gruvbox = false
    nord = true
  end,
  ["catppuccin"] = function()
    gruvbox = false
    catppuccin = true
  end,
  ["catppuccin-latte"] = function()
    gruvbox = false
    catppuccin = true
  end,
  ["catppuccin-frappe"] = function()
    gruvbox = false
    catppuccin = true
  end,
  ["catppuccin-macchiato"] = function()
    gruvbox = false
    catppuccin = true
  end,
  ["catppuccin-mocha"] = function()
    gruvbox = false
    catppuccin = true
  end,
  ["dracula"] = function()
    gruvbox = false
    dracula = true
  end,
  ["nightfox"] = function()
    gruvbox = false
    nightfox = true
  end,
  ["dayfox"] = function()
    gruvbox = false
    nightfox = true
  end,
  ["dawnfox"] = function()
    gruvbox = false
    nightfox = true
  end,
  ["duskfox"] = function()
    gruvbox = false
    nightfox = true
  end,
  ["nordfox"] = function()
    gruvbox = false
    nightfox = true
  end,
  ["terafox"] = function()
    gruvbox = false
    nightfox = true
  end,
  ["carbonfox"] = function()
    gruvbox = false
    nightfox = true
  end,
  ["gruvbox-baby"] = function()
    gruvbox = true
  end,
  default = function()
    gruvbox = true
  end,
})

local transparent = false
local transparent_mode = vim.g.pcode_transparent_mode or 0
if transparent_mode ~= nil then
  if transparent_mode == 1 then
    transparent = true
  end
end

return {
  -- color scheme
  {
    "luisiacc/gruvbox-baby",
    lazy = true,
    enabled = gruvbox,
    config = function()
      local colors = require("gruvbox-baby.colors").config()
      vim.g.gruvbox_baby_highlights = {
        StatusLine = { fg = colors.fg, bg = colors.bg },
        WinBarNC = { fg = colors.fg, bg = colors.bg },
        BufferLineFill = { bg = colors.bg },
        BufferLineFillNC = { bg = colors.bg },
        BufferLineUnfocusedFill = { bg = colors.bg },
        TabLine = { bg = colors.bg, fg = colors.fg },
      }
    end,
  },
  {
    "Mofiqul/dracula.nvim",
    enabled = dracula,
    config = function()
      local is_transparent = false
      local colors = require("dracula").colors()
      if is_transparent then
        colors = {
          bg = "none",
        }
      end
      require("dracula").setup {
        colors = {
          -- purple = "#FCC76A",
          menu = colors.bg,
        },
        italic_comment = true,
        lualine_bg_color = colors.bg,
        overrides = {
          Keywords = { fg = colors.cyan, italic = true },
          -- Function = { fg = colors.yellow, italic = true },
          ["@keyword"] = { fg = colors.pink, italic = true },
          ["@keyword.function"] = { fg = colors.cyan, italic = true },
          ["@function"] = { fg = colors.green, italic = true },
          ["@tag.javascript"] = { fg = colors.cyan },
          ["@tag.attribute"] = { fg = colors.green, italic = true },
          -- ["@tag.attribute.javascript"] = { fg = colors.orange, italic = true },
          NvimTreeFolderIcon = { fg = "#6776a7" },
          CmpItemAbbr = { fg = "#ABB2BF" },
          CmpItemKind = { fg = "#ABB2BF" },
          CmpItemAbbrDeprecated = { fg = "#ABB2BF" },
          CmpItemAbbrMatch = { fg = "#8BE9FD" },
          htmlLink = { fg = "#BD93F9", underline = false },
          Underlined = { fg = "#8BE9FD" },
          NvimTreeSpecialFile = { fg = "#FF79C6" },
          SpellBad = { fg = "#FF6E6E" },
          illuminatedWord = { bg = "#3b4261" },
          illuminatedCurWord = { bg = "#3b4261" },
          IlluminatedWordText = { bg = "#3b4261" },
          IlluminatedWordRead = { bg = "#3b4261" },
          IlluminatedWordWrite = { bg = "#3b4261" },
          DiffChange = { fg = colors.fg },
          StatusLine = { fg = colors.fg, bg = colors.bg },
          StatusLineTerm = { fg = colors.fg, bg = colors.bg },
          BufferLineFill = { bg = colors.bg },
          Pmenu = { fg = colors.fg, bg = colors.bg },
          WinBarNC = { fg = colors.fg, bg = colors.bg },
          LspInfoBorder = { fg = colors.fg },
        },
        transparent_bg = transparent,
        -- transparent_bg = is_transparent,
      }
    end,
  },
  {
    "folke/tokyonight.nvim",
    enabled = tokyonight,
    config = function()
      require "user.tokyonight"
    end,
  },
  {
    "shaunsingh/nord.nvim",
    enabled = nord,
    config = function()
      vim.g.nord_disable_background = transparent
      require("nord").set()
      local nord = require "nord.colors"
      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "*",
        callback = function()
          vim.api.nvim_set_hl(0, "StatusLine", { bg = "NONE", fg = nord.nord4_gui })
          vim.api.nvim_set_hl(0, "WinBarNC", { bg = nord.nord0_gui, fg = nord.nord4_gui })
          vim.api.nvim_set_hl(0, "WhichKeyFloat", { bg = nord.nord0_gui, fg = nord.nord4_gui })
          -- vim.api.nvim_set_hl(0, "StatusLine", { cterm = "bold", bold = true })
        end,
      })
    end,
  },
  {
    "sainnhe/sonokai",
    enabled = sonokai,
    config = function()
      vim.api.nvim_create_autocmd("ColorScheme", {
        group = vim.api.nvim_create_augroup("custom_highlights_sonokai", {}),
        pattern = "sonokai",
        callback = function()
          local config = vim.fn["sonokai#get_configuration"]()
          local palette = vim.fn["sonokai#get_palette"](config.style, config.colors_override)
          local set_hl = vim.fn["sonokai#highlight"]

          set_hl("StatusLine", palette.fg, palette.none)
          set_hl("StatusLineTerm", palette.fg, palette.none)
          set_hl("StatusLineNC", palette.fg, palette.none)
          set_hl("StatusLineTermNC", palette.fg, palette.none)
          set_hl("LualineNormal", palette.fg, palette.none)
          set_hl("NvimTreeNormal", palette.fg, palette.bg0)
          set_hl("NvimTreeCursorLine", palette.fg, palette.bg1)
          set_hl("NvimTreeEndOfBuffer", palette.fg, palette.bg0)
          set_hl("Pmenu", palette.fg, palette.bg0)
          set_hl("WhichKeyFloat", palette.fg, palette.bg0)
          set_hl("WhichKey", palette.fg, palette.bg0)
          set_hl("WhichKeyBorder", palette.fg, palette.bg0)
          set_hl("NormalFloat", palette.fg, palette.bg0)
          set_hl("Normal", palette.fg, palette.bg0)
          set_hl("NormalNC", palette.fg, palette.bg0)
          set_hl("FloatBorder", palette.fg, palette.bg0)
          set_hl("LspInfoNormal", palette.fg, palette.bg0)
        end,
      })
      vim.g.sonokai_style = sonokai_style
      vim.g.sonokai_transparent_background = 2
    end,
  },
  { "lunarvim/lunar.nvim", enabled = lunar },
  {
    "marko-cerovac/material.nvim",
    enabled = material,
    config = function()
      local colors = require "material.colors"
      vim.g.material_style = material_style
      require("material").setup {
        lualine_style = "stealth",
        disable = {
          background = transparent,
        },
        plugins = { -- Uncomment the plugins that you use to highlight them
          -- Available plugins:
          "dap",
          -- "dashboard",
          -- "eyeliner",
          "fidget",
          -- "flash",
          "gitsigns",
          -- "harpoon",
          -- "hop",
          "illuminate",
          "indent-blankline",
          -- "lspsaga",
          "mini",
          -- "neogit",
          -- "neotest",
          -- "neo-tree",
          -- "neorg",
          "noice",
          "nvim-cmp",
          "nvim-navic",
          "nvim-tree",
          "nvim-web-devicons",
          "rainbow-delimiters",
          -- "sneak",
          "telescope",
          -- "trouble",
          "which-key",
          "nvim-notify",
        },
        custom_highlights = {
          BufferLineFill = { bg = colors.bg },
          StatusLine = { fg = "#f8f8f2", bg = colors.bg },
          StatusLineTerm = { fg = "#f8f8f2", bg = colors.bg },
          WinBarNC = { fg = colors.fg, bg = colors.bg },
        },
      }
    end,
  },
  -- {
  --   "navarasu/onedark.nvim",
  --   enabled = onedark,
  --   priority = 1000,
  --   config = function()
  --     -- Lua
  --     local util = require "onedark.util"
  --     require("onedark").setup {
  --       term_colors = true,
  --       style = onedark_style,
  --       colors = {
  --         bg0 = "#1e222a",
  --         green = "#98c379",
  --         gray = "#abb2bf",
  --         red = "#e06c75",
  --         purple = "#c678dd",
  --         yellow = "#e5c07b",
  --         orange = "#d19a66",
  --         blue = "#61afef",
  --         cyan = "#56b6c2",
  --         bg_d = "$bg",
  --         bg1 = "#1e222a",
  --       },
  --       code_style = {
  --         comments = "italic",
  --         keywords = "italic",
  --         functions = "none",
  --         strings = "none",
  --         variables = "none",
  --       },
  --       highlights = {
  --         NoiceCursor = { fg = "$bg0", bg = "$fg" },
  --         Search = { fg = "$bg0", bg = "$bg_yellow" },
  --         -- BorderBG = { fg = "#333842" }, -- untuk custom brder color cmp
  --         -- overide indent line fill color
  --         NvimTreeNormal = { fg = "$fg", bg = "$bg0" },
  --         NvimTreeIndentMarker = { fg = "#515661" },
  --         -- NvimTreeGitIgnored = { fg = "$gray", bg = "NONE" },
  --         IblIndent = { fg = "#3E4450" },
  --         -- NvimTreeFolderIcon = { bg = "NONE", fg = "$blue" },
  --         ["@markup.link.url"] = { fg = "$cyan", fmt = "italic" },
  --         ["@text.uri"] = { fg = "$cyan", fmt = "none" },
  --         ["@tag.delimiter"] = { fg = "$gray" },
  --         ["@tag.html"] = { fg = "$red" },
  --         ["@tag.attribute"] = { fg = "$orange", fmt = "italic" },
  --         ["@tag.javascript"] = { fg = "$red" },
  --         ["@constructor.javascript"] = { fg = "$red" },
  --         ["@tag.tsx"] = { fg = "$yellow" },
  --         ["@constructor.tsx"] = { fg = "$yellow" },
  --         -- NvimTreeFolderIcon = { fg = "#FCC76A" },
  --         NvimTreeSpecialFile = { fg = "$yellow", fmt = "italic" },
  --         BufferLineFill = { bg = "$bg0" },
  --         BufferLineUnfocusedFill = { bg = "$bg0" },
  --         StatusLine = { fg = "#f8f8f2", bg = "$bg0" },
  --         StatusLineTerm = { fg = "#f8f8f2", bg = "$bg0" },
  --         illuminatedWord = { bg = "#3b4261" },
  --         illuminatedCurWord = { bg = "#3b4261" },
  --         IlluminatedWordText = { bg = "#3b4261" },
  --         IlluminatedWordRead = { bg = "#3b4261" },
  --         IlluminatedWordWrite = { bg = "#3b4261" },
  --         PmenuSel = { fg = "$fg", bg = "#333842" },
  --         -- overide lualine fill color with bg color
  --         LualineNormal = { bg = "$bg0" },
  --         -- overide lualine_c fill color with bg color
  --         LualineC = { bg = "$bg0" },
  --         -- overide lualine_x fill color with bg color
  --         LualineX = { bg = "$bg0" },
  --         -- overide which-key fill color with bg color
  --         WhichKey = { bg = "$bg0" },
  --         -- overide which-key fill color with bg color
  --         WhichKeySeperator = { bg = "$bg0" },
  --         -- overide which-key fill color with bg color
  --         WhichKeyDesc = { bg = "$bg0" },
  --         -- overide which-key fill color with bg color
  --         WhichKeyFloat = { bg = "$bg0" },
  --         -- overide which-key fill color with bg color
  --         WhichKeyValue = { bg = "$bg0" },
  --         -- overide which-key fill color with bg color
  --         WhichKeyBorder = { bg = "$bg0" },
  --         -- overide Lazy fill color with bg color
  --         -- LazyNormal = { bg = "$bg0" },
  --         -- -- overide lazy background color with bg color
  --         -- LazyBackground = { bg = "$bg0" },
  --         -- -- overide Lazy fill color with bg color
  --         -- LazyH1 = { bg = "$bg0" },
  --         -- -- overide Lazy fill color with bg color
  --         -- LazyH2 = { bg = "$bg0" },
  --         -- -- overide Lazy fill color with bg color
  --         -- LazyH3 = { bg = "$bg0" },
  --         -- -- overide Lazy fill color with bg color
  --         -- LazyH4 = { bg = "$bg0" },
  --         -- -- overide Lazy fill color with bg color
  --         -- LazyH5 = { bg = "$bg0" },
  --         -- -- overide Lazy fill color with bg color
  --         -- LazyH6 = { bg = "$bg0" },
  --         -- -- overide Lazy fill color with bg color
  --         -- LazyButton = { bg = "$bg0" },
  --         -- -- overide Lazy fill color with bg color
  --         -- LazyButtonActive = { bg = "$bg0" },
  --         -- -- overide Lazy fill color with bg color
  --         -- LazySpecial = { bg = "$bg0" },
  --         -- -- overide Lazy fill color with bg color
  --         -- LazyProgress = { bg = "$bg0" },
  --         -- Pmenu = { fg = "$fg", bg = "$bg0" },
  --         CursorLine = { bg = "#333842" },
  --         Cursor = { fg = "$bg0", bg = "$fg" }, -- character under the cursor
  --         lCursor = { fg = "$bg0", bg = "$fg" }, -- the character under the cursor when |language-mapping| is used (see 'guicursor')
  --         CursorIM = { fg = "$bg0", bg = "$fg" }, -- like Cursor, but used when in IME mode |CursorIM|
  --         CursorColumn = { bg = "#333842" }, -- Screen-column at the cursor, when 'cursorcolumn' is set.
  --         -- Visual = { bg = "$orange" },
  --         DiffText = { bg = "$orange" },
  --         DiffAdd = { bg = "#595d65" },
  --         MiniIndentscopeSymbol = { fg = "$cyan", nocombine = true },
  --         -- UfoPreviewNormal = { fg = "#373d48", bg = "$bg0" },
  --         -- UfoPreviewBorder = { fg = "#373d48", bg = "$bg0" },
  --         -- UfoPreviewCursorLine = { fg = "#373d48", bg = "$bg0" },
  --         WinBarNC = { fg = "$fg", bg = "NONE" },
  --       },
  --       transparent = transparent,
  --       lualine = {
  --         transparent = true,
  --       },
  --     }
  --     require("onedark").load()
  --   end,
  -- },
  {
    "olimorris/onedarkpro.nvim",
    priority = 1000, -- Ensure it loads first
    enabled = onedark,
    config = function()
      local is_transparent = false
      require("onedarkpro").setup {
        styles = {
          types = "NONE",
          methods = "NONE",
          numbers = "NONE",
          strings = "NONE",
          comments = "italic",
          keywords = "bold,italic",
          constants = "NONE",
          functions = "italic",
          operators = "NONE",
          variables = "NONE",
          parameters = "NONE",
          conditionals = "italic",
          virtual_text = "NONE",
          tags = "italic",
        },
        colors = {
          onedark = {
            green = "#99c379",
            gray = "#8094b4",
            red = "#e06c75",
            purple = "#c678dd",
            yellow = "#e5c07a",
            blue = "#61afef",
            cyan = "#56b6c2",
            bg_statusline = "#282c34",
            indentline = "#3b4261",
            float_bg = "#282c34",
          },
        },
        options = {
          cursorline = true,
          transparency = is_transparent,
          terminal_colors = true,
        },
        highlights = {
          -- overide cursor line fill colors
          LineNr = { fg = "#49505E" }, -- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
          CursorLineNr = { fg = "${blue}" }, -- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
          CursorLine = { bg = "#333842" },
          Cursor = { fg = "${bg}", bg = "${fg}" }, -- character under the cursor
          lCursor = { fg = "${bg}", bg = "${fg}" }, -- the character under the cursor when |language-mapping| is used (see 'guicursor')
          CursorIM = { fg = "${bg}", bg = "${fg}" }, -- like Cursor, but used when in IME mode |CursorIM|
          CursorColumn = { bg = "#333842" }, -- Screen-column at the cursor, when 'cursorcolumn' is set.
          -- overide nvimtree folder icon fill color
          NvimTreeFolderIcon = { fg = "${gray}" },
          -- overide nvimtree text fill color folder opened
          NvimTreeOpenedFolderName = { fg = "${blue}" },
          -- overide nvimtree text fill color root folder
          NvimTreeRootFolder = { fg = "${yellow}" },
          NvimTreeSpecialFile = { fg = "${orange}" },
          NvimTreeWinSeparator = { fg = "#202329" },
          NvimTreeIndentMarker = { fg = "#3E4450" },
          -- overide indenline fill color
          IblIndent = { fg = "#3E4450" },
          -- overide cmp cursorline fill color with #333842
          PmenuSel = { bg = "#333842" },
          illuminatedWord = { bg = "#3b4261" },
          illuminatedCurWord = { bg = "#3b4261" },
          IlluminatedWordText = { bg = "#3b4261" },
          IlluminatedWordRead = { bg = "#3b4261" },
          IlluminatedWordWrite = { bg = "#3b4261" },
          StatusLine = { fg = "#f8f8f2", bg = is_transparent and "NONE" or "${bg}" },
          StatusLineTerm = { fg = "#f8f8f2", bg = "${bg}" },
          BufferLineFill = { bg = is_transparent and "NONE" or "${bg}" },
          ["@string.special.url.html"] = { fg = "${green}" },
          ["@lsp.type.parameter"] = { fg = "${gray}" },
          -- ["@text.uri.html"] = { fg = "${green}" },
          -- ["@tag.javascript"] = { fg = "${red}" },
          -- ["@tag.attribute"] = { fg = "${orange}", style = "italic" },
          -- ["@constructor.javascript"] = { fg = "${red}" },
          -- ["@variable"] = { fg = "${fg}", style = "NONE" }, -- various variable names
          -- ["@variable.builtin"] = { fg = "${red}", style = "NONE" },
          -- ["@variable.member"] = "${cyan}",
          -- ["@variable.parameter"] = "${red}",
          -- ["@property"] = { fg = "${cyan}" }, -- similar to `@field`
          ["@property.lua"] = { fg = "${red}", bg = "NONE" },
          ["@lsp.type.property.lua"] = { fg = "${cyan}", bg = "NONE" },
          ["@lsp.type.variable.lua"] = { fg = "${red}", bg = "NONE" },
          NvimTreeGitDirty = { fg = "${yellow}" },
          Pmenu = { fg = "${fg}", bg = "${bg}" },
          PmenuThumb = { bg = "${gray}" }, -- Popup menu: Thumb of the scrollbar.
          -- overide lualine fill color with bg color
          LualineNormal = { bg = "${bg}" },
          -- overide lualine_c fill color with bg color
          LualineC = { bg = "${bg}" },
          -- overide lualine_x fill color with bg color
          LualineX = { bg = "${bg}" },
          -- overide which-key fill color with bg color
          -- WhichKey = { bg = "${bg}" },
          -- -- overide which-key fill color with bg color
          -- WhichKeySeperator = { bg = "${bg}" },
          -- -- overide which-key fill color with bg color
          -- WhichKeyDesc = { fg = "${red}" },
          -- -- overide which-key fill color with bg color
          -- WhichKeyFloat = { bg = "${bg}" },
          WhichKeyFloat = { bg = is_transparent and "NONE" or "${bg}" },
          -- -- overide which-key fill color with bg color
          -- WhichKeyValue = { bg = "${bg}" },
          -- -- overide which-key fill color with bg color
          -- WhichKeyBorder = { bg = "${bg}" },
          LspInfoBorder = { fg = "${fg}" },
        },
      }
    end,
  },
  {
    "catppuccin/nvim",
    enabled = catppuccin,
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup {
        flavour = "auto", -- latte, frappe, macchiato, mocha
        background = { -- :h background
          light = "latte",
          dark = "mocha",
        },
        transparent_background = transparent, -- disables setting the background color.
        show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
        term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
        dim_inactive = {
          enabled = false, -- dims the background color of inactive window
          shade = "dark",
          percentage = 0.15, -- percentage of the shade to apply to the inactive window
        },
        no_italic = false, -- Force no italic
        no_bold = false, -- Force no bold
        no_underline = false, -- Force no underline
        styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
          comments = { "italic" }, -- Change the style of comments
          conditionals = { "italic" },
          loops = {},
          functions = {},
          keywords = { "italic" },
          strings = {},
          variables = {},
          numbers = {},
          booleans = {},
          properties = {},
          types = {},
          operators = {},
          -- miscs = {}, -- Uncomment to turn off hard-coded styles
        },
        color_overrides = {},
        custom_highlights = function(colors)
          return {
            NvimTreeNormal = { fg = colors.text, bg = transparent and colors.none or colors.base },
            NvimTreeWinSeparator = { fg = colors.mantle, bg = transparent and colors.none or colors.none },
            Pmenu = { fg = colors.text, bg = transparent and colors.none or colors.base },
            WhichKeyFloat = { fg = colors.text, bg = transparent and colors.none or colors.base },
            WhichKey = { fg = colors.text, bg = transparent and colors.none or colors.base },
            WhichKeyBorder = { fg = colors.text, bg = transparent and colors.none or colors.base },
            NormalFloat = { fg = colors.text, bg = transparent and colors.none or colors.base },
            Normal = { fg = colors.text, bg = transparent and colors.none or colors.base },
            NormalNC = { fg = colors.text, bg = transparent and colors.none or colors.base },
            StatusLine = { fg = colors.text, bg = colors.none },
          }
        end,
        highlight_overrides = {
          all = function(colors)
            return {
              ["@markup.link.url"] = { fg = colors.rosewater, style = { "italic" } },
            }
          end,
        },
        default_integrations = true,
        integrations = {
          cmp = true,
          gitsigns = true,
          nvimtree = true,
          treesitter = true,
          notify = false,
          mini = {
            enabled = true,
            indentscope_color = "",
          },
          -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
        },
      }
    end,
  },
  {
    "EdenEast/nightfox.nvim",
    enabled = nightfox,
    config = function()
      local palette = require("nightfox.palette").load "nightfox"
      local Color = require "nightfox.lib.color"
      local bg = Color.from_hex(palette.bg1)
      require("nightfox").setup {
        options = {
          terminal_colors = true,
          transparent = transparent,
          styles = { -- Style to be applied to different syntax groups
            comments = "italic", -- Value is any valid attr-list value `:help attr-list`
            conditionals = "italic",
            constants = "NONE",
            functions = "NONE",
            keywords = "italic",
            numbers = "NONE",
            operators = "NONE",
            strings = "NONE",
            types = "NONE",
            variables = "NONE",
          },
        },
        palettes = {
          all = {
            bg0 = palette.bg1,
            bg = palette.bg1,
          },
        },
        specs = {},
        groups = {
          all = {
            -- overide bufferline fill color
            BufferLineFill = { bg = palette.bg1 },
            BufferLineUnfocusedFill = { bg = palette.bg },
            -- overide nvimtree fill color with bg color
            NvimTreeNormal = { bg = palette.bg },
            NvimTreeWinSeparator = {
              fg = palette.bg0,
            },
            Underlined = { style = "NONE" }, -- overide statusline fill color with bg color
            StatusLine = { bg = "NONE" },
            StatusLineTerm = { bg = palette.bg },
            -- overide lualine fill color with bg color
            LualineNormal = { bg = palette.bg },
            Pmenu = { bg = "bg3" },
            PmenuSel = { bg = "bg3" },
          },
        },
      }
    end,
  },
}
