local color = vim.g.pcode_colorscheme or "gruvbox-baby"
local transparent_mode = vim.g.pcode_transparent_mode or 0

if (color == "nord") and true or false then
  return {
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
  }
else
  return {}
end
