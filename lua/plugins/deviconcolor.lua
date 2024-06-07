local M = {}
if vim.g.pcode_adaptive_color_icon then
  M = {
    "rachartier/tiny-devicons-auto-colors.nvim",
    event = "BufReadPre",
    config = function()
      require("tiny-devicons-auto-colors").setup()
    end,
  }
end
return M
