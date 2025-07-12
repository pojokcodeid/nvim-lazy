return {
  "ellisonleao/gruvbox.nvim",
  priority = 1000,
  opts = function()
    local color = require("gruvbox").palette
    return {
      terminal_colors = true, -- add neovim terminal colors
      undercurl = false,
      underline = false,
      bold = false,
      contrast = "", -- can be "hard", "soft" or empty string
      palette_overrides = {},
      overrides = {
        ["NormalFloat"] = { bg = "NONE" },
        ["NormalNC"] = { bg = "NONE" },
        ["MiniIndentscopeSymbol"] = { fg = color.bright_yellow },
        ["StatusLine"] = { bg = "NONE" },
        ["FoldColumn"] = { bg = "NONE" },
        ["Folded"] = { bg = "NONE" },
        ["SignColumn"] = { bg = "NONE" },
        ["MasonBackdrop"] = { link = "NormalFloat" },
      },
    }
  end,
  config = function(_, opts)
    vim.o.background = "dark"
    require("gruvbox").setup(opts)
  end,
}
