local color = vim.g.pcode_colorscheme or "gruvbox-baby"

if (color == "juliana") and true or false then
  return {
    "pojokcodeid/nvim-juliana",
    lazy = false,
    enabled = (color == "juliana") and true or false,
    priority = 1000,
    opts = {},
    config = function()
      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "*",
        callback = function()
          -- get colors
          local colors = require("nvim-juliana").colors()
          -- custom hilights
          local hi = vim.api.nvim_set_hl
          hi(0, "FoldColumn", { bg = colors.bg2 })
        end,
      })
    end,
  }
else
  return {}
end
