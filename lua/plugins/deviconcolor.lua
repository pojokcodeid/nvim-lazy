local M = {}
if pcode.adaptive_color_icon then
  M = {
    "rachartier/tiny-devicons-auto-colors.nvim",
    event = "VeryLazy",
    config = function()
      require("tiny-devicons-auto-colors").setup()
    end,
  }
end
return M
