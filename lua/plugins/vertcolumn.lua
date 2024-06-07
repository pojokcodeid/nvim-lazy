local M = {}
if vim.g.pcode_columnline then
  M = {
    {
      "lukas-reineke/virt-column.nvim",
      event = "BufRead",
      opts = {},
      config = function()
        local icons = vim.g.pcode_icons
        require("virt-column").overwrite {
          exclude = {
            filetypes = { "help", "text", "markdown" },
          },
          char = icons.ui.LineMiddle,
        }
      end,
    },
  }
end

return M
