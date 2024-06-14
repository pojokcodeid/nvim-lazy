local color = pcode.colorscheme or "gruvbox-baby"
local transparent_mode = pcode.transparent_mode or 0

if substring(tostring(color), "solarized") and true or false then
  return {
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
  }
else
  return {}
end
