local M = {}
local disable = pcode.disable_null_ls or false
if not require("user.utils.cfgstatus").cheack() then
  disable = true
end
if disable then
  M = {
    {
      "nvimtools/none-ls.nvim",
      lazy = true,
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
end
return M
