return {
  "karb94/neoscroll.nvim",
  event = "VeryLazy",
  lazy = true,
  config = function()
    require("neoscroll").setup({})
  end,
}
