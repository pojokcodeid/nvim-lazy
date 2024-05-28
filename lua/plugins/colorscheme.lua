local nightfox = false

_G.switch = function(param, case_table)
  local case = case_table[param]
  if case then
    return case()
  end
  local def = case_table["default"]
  return def and def() or nil
end

_G.substring = function(text, key)
  local index, _ = string.find(text, key)
  if index then
    return true
  else
    return false
  end
end

_G.extract = function(text)
  local result = {}
  for substring in string.gmatch(text, "[^_]+") do
    table.insert(result, substring)
  end
  return result
end

local color = vim.g.pcode_colorscheme or "gruvbox-baby"
local materialstyle = extract(color)[2] or "oceanic"
local material_style = (materialstyle == "deepocean") and "deep ocean" or materialstyle
switch(color, {
  ["nightfox"] = function()
    nightfox = true
  end,
  ["dayfox"] = function()
    nightfox = true
  end,
  ["dawnfox"] = function()
    nightfox = true
  end,
  ["duskfox"] = function()
    nightfox = true
  end,
  ["nordfox"] = function()
    nightfox = true
  end,
  ["terafox"] = function()
    nightfox = true
  end,
  ["carbonfox"] = function()
    nightfox = true
  end,
  default = function() end,
})

-- local transparent = false
local transparent_mode = vim.g.pcode_transparent_mode or 0
-- if transparent_mode ~= nil then
--   if transparent_mode == 1 then
--     transparent = true
--   end
-- end

return {
  -- color scheme
  {
    "luisiacc/gruvbox-baby",
    priority = 1000,
    lazy = true,
    enabled = (color == "gruvbox-baby") and true or false,
    config = function()
      local colors = require("gruvbox-baby.colors").config()
      vim.g.gruvbox_baby_highlights = {
        StatusLine = { fg = colors.fg, bg = colors.bg },
        WinBarNC = { fg = colors.fg, bg = colors.bg },
        BufferLineFill = { bg = colors.bg },
        BufferLineFillNC = { bg = colors.bg },
        BufferLineUnfocusedFill = { bg = colors.bg },
        TabLine = { bg = colors.bg, fg = colors.fg },
        NvimTreeNormal = { bg = colors.bg, fg = colors.fg },
        NvimTreeNormalNC = { bg = colors.bg, fg = colors.fg },
        NvimTreeWinSeparator = { fg = colors.fg },
        Pmenu = { fg = colors.fg, bg = colors.bg },
        WhichKeyFloat = { fg = colors.fg, bg = colors.bg },
        WhichKeyBorder = { fg = colors.fg, bg = colors.bg },
        NormalFloat = { fg = colors.fg, bg = colors.bg },
        NormalNC = { fg = colors.fg, bg = colors.bg },
        FloatBorder = { fg = colors.fg, bg = colors.bg },
        LspInfoBorder = { fg = colors.fg, bg = colors.bg },
      }
      vim.g.gruvbox_baby_transparent_mode = transparent_mode
    end,
  },
  {
    "Mofiqul/dracula.nvim",
    priority = 1000,
    enabled = (color == "dracula") and true or false,
    config = function()
      local colors = require("dracula").colors()
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
          -- ["@tag.javascript"] = { fg = colors.cyan, italic = true },
          -- ["@tag.attribute"] = { fg = colors.green, italic = true },
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
          LspReferenceText = { bg = "#3b4261" },
          LspReferenceRead = { bg = "#3b4261" },
          LspReferenceWrite = { bg = "#3b4261" },
        },
        transparent_bg = (transparent_mode == 1) and true or false,
      }
    end,
  },
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    enabled = substring(tostring(color), "tokyonight") and true or false,
    config = function()
      require "user.tokyonight"
    end,
  },
  {
    "shaunsingh/nord.nvim",
    priority = 1000,
    enabled = (color == "nord") and true or false,
    config = function()
      vim.g.nord_disable_background = (transparent_mode == 1) and true or false
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
    priority = 1000,
    enabled = substring(tostring(color), "sonokai") and true or false,
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
      vim.g.sonokai_style = extract(color)[2] or "default"
      vim.g.sonokai_transparent_background = (transparent_mode == 1) and 2 or 0
    end,
  },
  { "lunarvim/lunar.nvim", enabled = (color == "lunar") and true or false },
  {
    "marko-cerovac/material.nvim",
    priority = 1000,
    enabled = substring(tostring(color), "material") and true or false,
    config = function()
      local colors = require "material.colors"
      vim.g.material_style = material_style
      require("material").setup {
        lualine_style = "stealth",
        disable = {
          background = (transparent_mode == 1) and true or false,
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
          CursorLine = { bg = "#333842" },
        },
      }
    end,
  },
  {
    "olimorris/onedarkpro.nvim",
    priority = 1000, -- Ensure it loads first
    enabled = substring(tostring(color), "onedark") and true or false,
    config = function()
      local is_transparent = (transparent_mode == 1) and true or false
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
          bg_statusline = "#282c34",
          onedark = {
            green = "#99c379",
            gray = "#8094b4",
            red = "#e06c75",
            purple = "#c678dd",
            yellow = "#e5c07a",
            blue = "#61afef",
            cyan = "#56b6c2",
            indentline = "#3b4261",
            float_bg = "#282c34",
          },
          onedark_dark = {
            bg_statusline = "#000",
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
          NormalFloat = { fg = "${fg}", bg = is_transparent and "NONE" or "${bg}" },
          Normal = { fg = "${fg}", bg = is_transparent and "NONE" or "${bg}" },
          NormalNC = { fg = "${fg}", bg = is_transparent and "NONE" or "${bg}" },
          FloatBorder = { fg = "${fg}", bg = is_transparent and "NONE" or "${bg}" },
        },
      }
    end,
  },
  {
    "catppuccin/nvim",
    enabled = substring(tostring(color), "catppuccin") and true or false,
    name = "catppuccin",
    priority = 1000,
    config = function()
      local transparent = (transparent_mode == 1) and true or false
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
    priority = 1000,
    enabled = nightfox,
    config = function()
      local palette = require("nightfox.palette").load "nightfox"
      local Color = require "nightfox.lib.color"
      local bg = Color.from_hex(palette.bg1)
      require("nightfox").setup {
        options = {
          terminal_colors = true,
          transparent = (transparent_mode == 1) and true or false,
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
  {
    "projekt0n/github-nvim-theme",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    enabled = substring(tostring(color), "github") and true or false,
    config = function()
      local is_transparent = (transparent_mode == 1) and true or false
      local palette = require("github-theme.palette").load "github_dark_dimmed"
      require("github-theme").setup {
        options = {
          -- Compiled file's destination location
          compile_path = vim.fn.stdpath "cache" .. "/github-theme",
          compile_file_suffix = "_compiled", -- Compiled file suffix
          hide_end_of_buffer = true, -- Hide the '~' character at the end of the buffer for a cleaner look
          hide_nc_statusline = true, -- Override the underline style for non-active statuslines
          transparent = is_transparent, -- Disable setting background
          terminal_colors = true, -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
          dim_inactive = false, -- Non focused panes set to alternative background
          module_default = true, -- Default enable value for modules
          styles = { -- Style to be applied to different syntax groups
            comments = "italic", -- Value is any valid attr-list value `:help attr-list`
            functions = "italic",
            keywords = "NONE",
            variables = "NONE",
            conditionals = "NONE",
            constants = "NONE",
            numbers = "NONE",
            operators = "NONE",
            strings = "NONE",
            types = "NONE",
          },
          inverse = { -- Inverse highlight for different types
            match_paren = false,
            visual = false,
            search = false,
          },
          darken = { -- Darken floating windows and sidebar-like windows
            floats = false,
            sidebars = {
              enabled = true,
              list = {}, -- Apply dark background to specific windows
            },
          },
          modules = { -- List of various plugins and additional options
            -- ...
          },
        },
        palettes = {
          github_dark_dimmed = {
            bg0 = is_transparent and "NONE" or "bg1",
            bg1 = is_transparent and "NONE" or "bg",
          },
        },
        specs = {},
        groups = {
          all = {
            illuminatedWord = { bg = "#3b4261" },
            illuminatedCurWord = { bg = "#3b4261" },
            IlluminatedWordText = { bg = "#3b4261" },
            IlluminatedWordRead = { bg = "#3b4261" },
            IlluminatedWordWrite = { bg = "#3b4261" },
            ["@tag.attribute"] = { fg = "#77bdfb", style = "italic" },
            ["@text.uri"] = { fg = palette.const, style = "italic" },
            ["@keyword.return"] = { fg = "#fa7970", style = "italic" },
            -- ["@tag.attribute.html"] = { fg = "#faa356", style = "italic" },
            -- ["@operator.html"] = { fg = "#faa356" },
            -- ["@tag.html"] = { fg = "#fa7970" },
            -- ["@tag.delimiter.html"] = { fg = "#faa356" },
            -- ["@tag.javascript"] = { fg = "#faa356" },
            -- ["@tag.javascript"] = { fg = "#8ddb8c" },
            -- ["@tag.tsx"] = { fg = "#8ddb8c" },
            ["@string.special.url"] = { fg = palette.const, style = "italic" },
            ["@tag.delimiter.javascript"] = { fg = "fg1" },
            ["@tag.tsx"] = { fg = "#faa356" },
            ["@lsp.type.parameter"] = { fg = "#faa356" },
            ["@property.lua"] = { fg = "#91cbff", bg = is_transparent and "NONE" or "bg1" },
            ["@lsp.type.property.lua"] = { fg = "fg1", bg = is_transparent and "NONE" or "bg1" },
            ["@lsp.type.variable.lua"] = { fg = "#91cbff", bg = is_transparent and "NONE" or "bg1" },
            -- sparator new all
            NvimTreeNormal = { fg = "fg1", bg = is_transparent and "NONE" or "bg1" },
            NvimTreeSpecialFile = { fg = "#faa356", style = "italic" },
            NvimTreeIndentMarker = { fg = "#3E4450" },
            BufferLineFill = { bg = is_transparent and "NONE" or "bg1" },
            BufferLineUnfocusedFill = { bg = is_transparent and "NONE" or "bg1" },
            LualineNormal = { bg = is_transparent and "NONE" or "bg1" },
            StatusLine = { bg = is_transparent and "NONE" or "bg1" },
            StatusLineTerm = { bg = is_transparent and "NONE" or "bg1" },
            Pmenu = { bg = is_transparent and "NONE" or "bg1" },
            PmenuSel = { link = "CursorLine" },
            WhichKeyFloat = { bg = is_transparent and "NONE" or "bg1" },
            LazyNormal = { bg = is_transparent and "NONE" or "bg1" },
            LazyBackground = { bg = is_transparent and "NONE" or "bg1" },
            NormalSB = { fg = "fg1", bg = is_transparent and "NONE" or "bg1" }, -- normal text
            NormalFloat = { fg = "fg1", bg = is_transparent and "NONE" or "bg1" },
            IblIndent = { fg = "#3E4450" },
          },
          github_dark_high_contrast = {
            NvimTreeSpecialFile = { fg = "#faa356", style = "italic" },
          },
          github_dark_dimmed = {
            -- As with specs and palettes, a specific style's value will be used over the `all`'s value.
          },
        },
      }
    end,
  },
  {
    "craftzdog/solarized-osaka.nvim",
    lazy = false,
    priority = 1000,
    enabled = substring(tostring(color), "solarized") and true or false,
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      transparent = (transparent_mode == 1) and true or false, -- Enable this to disable setting the background color
      terminal_colors = true, -- Configure the colors used when opening a `:terminal` in [Neovim](https://github.com/neovim/neovim)
      styles = {
        -- Style to be applied to different syntax groups
        -- Value is any valid attr-list value for `:help nvim_set_hl`
        comments = { italic = true },
        keywords = { italic = true },
        functions = {},
        variables = {},
        -- Background styles. Can be "dark", "transparent" or "normal"
        sidebars = (transparent_mode == 1) and "transparent" or "normal", -- style for sidebars, see below
        floats = "dark", -- style for floating windows
      },
      sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
      day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
      hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
      dim_inactive = false, -- dims inactive windows
      lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold

      --- You can override specific color groups to use other groups or a hex color
      --- function will be called with a ColorScheme table
      --@param colors ColorScheme
      on_colors = function(colors)
        colors.bg_statusline = colors.none
      end,

      --- You can override specific highlights to use other groups or a hex color
      --- function will be called with a Highlights and ColorScheme table
      --@param highlights Highlights
      --@param colors ColorScheme
      on_highlights = function(highlights, colors)
        highlights.NvimTreeWinSeparator = {
          fg = colors.border,
        }
        highlights.Underlined = {
          underline = false,
        }
        highlights.BufferLineFill = { bg = colors.bg }
        highlights.StatusLine = { bg = colors.none, fg = colors.fg }
        highlights.StatusLineNC = { bg = colors.none, fg = colors.fg }
        highlights.NvimTreeSpecialFile = { fg = colors.purple, underline = false }
        highlights["@tag.attribute"] = { fg = colors.green1, italic = true }
      end,
    },
    config = function(_, opts)
      require("solarized-osaka").setup(opts)
    end,
  },
  {
    "pojokcodeid/darcula-dark.nvim",
    enabled = (color == "darcula-dark") and true or false,
    priority = 1000,
    lazy = false,
    config = function() end,
  },
}
