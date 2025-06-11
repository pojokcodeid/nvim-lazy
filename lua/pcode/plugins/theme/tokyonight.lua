return {
  "folke/tokyonight.nvim",
  priority = 1000,
  config = function()
    local status_ok, tokyonight = pcall(require, "tokyonight")
    if not status_ok then
      return
    end
    local transp = false
    local sidebar = "normal" --"dark , transparent, normal"
    local hilight = "#292e42"
    local tras = pcode.transparent_mode or 0
    if tras == 1 then
      transp = true
      sidebar = "transparent"
      -- hilight = "#3E4254"
      -- hilight = "#353a56"
      hilight = "#292e42"
    end

    tokyonight.setup({
      -- your configuration comes here
      -- or leave it empty to use the default settings
      style = "night", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
      light_style = "day", -- The theme is used when the background is set to light
      transparent = transp, -- Enable this to disable setting the background color
      terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
      styles = {
        -- Style to be applied to different syntax groups
        -- Value is any valid attr-list value for `:help nvim_set_hl`
        -- comments = { italic = true },
        comments = { italic = true },
        keywords = {},
        functions = {},
        variables = {},
        -- Background styles. Can be "dark", "transparent" or "normal"
        sidebars = sidebar, -- style for sidebars, see below
        floats = sidebar, -- style for floating windows
      },
      sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
      day_brightness = 0.2, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
      hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
      dim_inactive = false, -- dims inactive windows
      lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold

      --- You can override specific color groups to use other groups or a hex color
      --- function will be called with a ColorScheme table
      -- @param colors ColorScheme
      on_colors = function(colors)
        colors.bg_highlight = hilight
        colors.bg_statusline = colors.none
      end,

      --- You can override specific highlights to use other groups or a hex color
      --- function will be called with a Highlights and ColorScheme table
      --@param highlights Highlights
      -- @param colors ColorScheme
      on_highlights = function(highlights, colors)
        highlights.NvimTreeFolderIcon = {
          bg = colors.none,
          fg = "#e0af68",
        }
        highlights.Underlined = {
          underline = false,
        }
        highlights.NvimTreeWinSeparator = {
          fg = colors.border,
        }
        highlights.BufferLineFill = { bg = colors.bg }
        highlights.NvimTreeSpecialFile = { fg = colors.purple, underline = false }
        highlights["@tag.attribute"] = { fg = colors.green1, italic = true }
        -- highlights["@keyword.function"] = { fg = colors.blue, italic = true }
        -- highlights["@function"] = { fg = colors.blue, italic = true }
        highlights.MasonBackdrop = { link = "NormalFloat" }
      end,
    })
  end,
}
