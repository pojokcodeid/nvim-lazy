return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
    local transparent = false
    require("catppuccin").setup({
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
      color_overrides = {
        all = {
          mantle = "#1e1e2e",
        },
      },
      custom_highlights = function(colors)
        return {
          NvimTreeNormal = { fg = colors.text, bg = transparent and colors.none or colors.base },
          NvimTreeWinSeparator = { fg = "#181825", bg = transparent and colors.none or colors.none },
          Pmenu = { fg = colors.text, bg = transparent and colors.none or colors.base },
          WhichKeyFloat = { fg = colors.text, bg = transparent and colors.none or colors.base },
          WhichKey = { fg = colors.text, bg = transparent and colors.none or colors.base },
          WhichKeyBorder = { fg = colors.text, bg = transparent and colors.none or colors.base },
          NormalFloat = { fg = colors.text, bg = transparent and colors.none or colors.base },
          Normal = { fg = colors.text, bg = transparent and colors.none or colors.base },
          NormalNC = { fg = colors.text, bg = transparent and colors.none or colors.base },
          TabLine = { fg = colors.text, bg = transparent and colors.none or colors.base },
          StatusLine = { fg = colors.text, bg = transparent and colors.none or colors.base },
          MasonBackdrop = { link = "NormalFloat" },
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
        bufferline = true,
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
    })
  end,
}
