local M = {}
local disable = pcode.disable_null_ls or false
if require("user.utils.cfgstatus").cheack() then
  disable = true
end
if disable then
  M = {
    "pojokcodeid/auto-conform.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "stevearc/conform.nvim",
    },
    event = "VeryLazy",
    opts = function(_, opts)
      opts.formatters = opts.formatters or {}
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      opts.ensure_installed = opts.ensure_installed or {}
      opts.lang_maps = opts.lang_maps or {}
      opts.name_maps = opts.name_maps or {}
      opts.add_new = opts.add_new or {}
      opts.ignore = opts.ignore or {}
    end,
    config = function(_, opts)
      require("auto-conform").setup(opts)
      -- other conform config
      local conform = require("conform")
      conform.setup({
        format_on_save = {
          lsp_fallback = true,
          timeout_ms = pcode.format_timeout_ms or 5000,
        },
      })
      vim.keymap.set({ "n", "v" }, "<leader>lF", function()
        conform.format({
          lsp_fallback = true,
          async = false,
          timeout_ms = pcode.format_timeout_ms or 5000,
        })
      end, { desc = "Format file or range (in visual mode)" })
    end,
  }
end
return M
