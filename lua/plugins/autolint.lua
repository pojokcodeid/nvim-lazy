local M = {}
local disable = pcode.disable_null_ls or false
if require("user.utils.cfgstatus").cheack() then
  disable = true
end
if disable then
  M = {
    "pojokcodeid/auto-lint.nvim",
    dependencies = {
      "mfussenegger/nvim-lint",
    },
    event = "VeryLazy",
    opts = function(_, opts)
      opts.map_lang = opts.map_lang or {}
      opts.map_name = opts.map_name or {}
      opts.add_new = opts.add_new or {}
      opts.ignore = opts.ignore or {}
      opts.ensure_installed = opts.ensure_installed or {}
    end,
    config = function(_, opts)
      require("auto-lint").setup(opts)
    end,
  }
end
return M
