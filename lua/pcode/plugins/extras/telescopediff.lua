return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "jemag/telescope-diff.nvim",
  },
  config = function()
    require("telescope").load_extension("diff")
  end,
  keys = {
    {
      "<leader>sd",
      function()
        require("telescope").extensions.diff.diff_files({ hidden = true })
      end,
      desc = "Diff 2 Files",
    },
    {
      "<leader>sD",
      function()
        require("telescope").extensions.diff.diff_current({ hidden = true })
      end,
      desc = "Diff Current File",
    },
  },
}
