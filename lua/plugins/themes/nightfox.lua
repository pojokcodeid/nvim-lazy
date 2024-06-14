local nightfox = false
local color = pcode.colorscheme or "gruvbox-baby"
local transparent_mode = pcode.transparent_mode or 0
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

if nightfox then
  return {
    "EdenEast/nightfox.nvim",
    priority = 1000,
    enabled = nightfox,
    config = function()
      local palette = require("nightfox.palette").load "nightfox"
      -- local Color = require "nightfox.lib.color"
      -- local bg = Color.from_hex(palette.bg1)
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
  }
else
  return {}
end
