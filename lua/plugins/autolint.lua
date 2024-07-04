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
    config = function()
      require("auto-lint").setup({
        map_lang = {
          -- ["c++"] = "cpp",
          -- ["c#"] = "cs",
        },
        map_name = {
          -- ["actionlint"] = "actionlint",
          -- ["ansible_lint"] = "ansible_lint",
        },
        add_new = {
          -- ["typescriptreact"] = { "eslint_d" },
          -- ["javascriptreact"] = { "eslint_d" },
        },
        ignore = {
          -- ["php"] = { "tlint" },
        },
        ensure_installed = {
          -- "eslint_d",
        },
      })
    end,
  }
end
return M
