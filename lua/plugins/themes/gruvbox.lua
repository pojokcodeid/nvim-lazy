local color = pcode.colorscheme or "gruvbox-baby"
local transparent_mode = pcode.transparent_mode or 0
if (color == "gruvbox-baby") and true or false then
  return {
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
  }
else
  return {}
end
