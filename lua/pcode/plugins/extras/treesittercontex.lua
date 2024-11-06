return {
  "nvim-treesitter/nvim-treesitter-context",
  lazy = true,
  event = { "BufRead", "VeryLazy" },
  opts = {},
  keys = {
    { "<leader>T", "", desc = "  TS Context" },
    { "<leader>Tt", "<cmd>TSContextToggle<cr>", desc = "Toggle Context" },
  },
}
