local color = vim.g.pcode_colorscheme or "gruvbox-baby"
local transparent_mode = vim.g.pcode_transparent_mode or 0

if (color == "dracula") and true or false then
  return {
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
          ["@keyword"] = { fg = colors.pink, italic = true },
          ["@keyword.function"] = { fg = colors.cyan, italic = true },
          ["@function"] = { fg = colors.green, italic = true },
          ["@tag.builtin.javascript"] = { fg = colors.pink },
          ["@tag.delimiter.javascript"] = { fg = colors.fg },
          ["@type.javascript"] = { fg = colors.fg },
          ["@property.css"] = { fg = colors.cyan },
          ["@type.css"] = { fg = colors.green },
          ["@tag.css"] = { fg = colors.pink },
          ["@keyword.css"] = { fg = colors.fg },
          ["@string.css"] = { fg = colors.pink },
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
  }
else
  return {}
end
