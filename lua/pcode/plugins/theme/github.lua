return {
  "projekt0n/github-nvim-theme",
  lazy = false, -- make sure we load this during startup if it is your main colorscheme
  priority = 1000, -- make sure to load this before all the other start plugins
  config = function()
    local is_transparent = false
    local palette = require("github-theme.palette").load(pcode.themes.github or "github_dark_dimmed")
    require("github-theme").setup({
      options = {
        -- Compiled file's destination location
        compile_path = vim.fn.stdpath("cache") .. "/github-theme",
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
            enable = true,
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
          MasonBackdrop = { link = "NormalFloat" },
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
          ["@tag.builtin.javascript"] = { fg = "#8ddb8c" },
          -- ["@tag.tsx"] = { fg = "#8ddb8c" },
          ["@string.special.url"] = { fg = palette.const, style = "italic" },
          ["@tag.delimiter.javascript"] = { fg = "fg1" },
          ["@tag.tsx"] = { fg = "#faa356" },
          ["@lsp.type.parameter"] = { fg = "#91cbff" },
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
          WinBar = { bg = is_transparent and "NONE" or "bg1" },
          WinBarNC = { bg = is_transparent and "NONE" or "bg1" },
        },
        github_dark_high_contrast = {
          NvimTreeSpecialFile = { fg = "#faa356", style = "italic" },
        },
        github_dark_dimmed = {
          -- As with specs and palettes, a specific style's value will be used over the `all`'s value.
        },
      },
    })
  end,
}
