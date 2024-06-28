return {
  {
    "nvimtools/none-ls.nvim",
    lazy = true,
    enabled = not (pcode.disable_null_ls or false),
    dependencies = {
      {
        "jayp0521/mason-null-ls.nvim",
        event = "VeryLazy",
        opts = {
          ensure_installed = pcode.null_ls_ensure_installed or {},
          automatic_setup = true,
          handlers = {},
        },
        config = function(_, opts)
          require("mason-null-ls").setup(opts)
        end,
      },
      "nvimtools/none-ls-extras.nvim",
    },
    event = "InsertEnter",
    opts = {},
    config = true,
  },
}
