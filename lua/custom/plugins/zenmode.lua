return {
  "folke/zen-mode.nvim",
  event = "VeryLazy",
  opts = {
    plugins = {
      options = {
        laststatus = 0,
      },
    },
    on_open = function(win)
      require("notify")("Zen Mode ON")
    end,
    on_close = function()
      require("notify")("Zen Mode OFF")
    end,
  },
  keys = {
    { "<leader>zz", "<cmd>ZenMode<cr>", desc = "Toggle Zen Mode" },
  },
}
