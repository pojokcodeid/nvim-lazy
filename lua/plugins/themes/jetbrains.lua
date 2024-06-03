local color = vim.g.pcode_colorscheme or "gruvbox-baby"

if (color == "darcula-dark") and true or false then
  return {
    "pojokcodeid/darcula-dark.nvim",
    enabled = (color == "darcula-dark") and true or false,
    priority = 1000,
    lazy = false,
    config = function()
      require("darcula").setup {
        colors = {
          lavender = "#9876AA",
        },
      }
      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "*",
        callback = function()
          local colors = require("darcula").colors()
          local hi = vim.api.nvim_set_hl
          hi(0, "@property.json", { fg = colors.lavender })
        end,
      })
    end,
  }
else
  return {}
end
