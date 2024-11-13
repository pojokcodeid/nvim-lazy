return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "roycrippen4/telescope-treesitter-info.nvim",
  },
  config = function()
    require("telescope").load_extension("treesitter_info")
  end,
  keys = {
    { "<leader>p", "<cmd>Telescope treesitter_info<cr>", desc = "Treesitter Info" },
  },
}
