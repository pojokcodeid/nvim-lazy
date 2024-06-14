local map_opts = { silent = true, noremap = true }
local merge = function(tableA, tableB, ...)
  return vim.tbl_deep_extend("force", tableA, tableB, ...)
end
local nmap = function(lhs, rhs, opts)
  opts = opts or {}
  vim.keymap.set("n", lhs, rhs, merge(map_opts, opts))
end
local M = {}
if pcode.rest_client then
  M = {
    "rest-nvim/rest.nvim",
    -- NOTE: Follow https://github.com/rest-nvim/rest.nvim/issues/306
    commit = "91badd46c60df6bd9800c809056af2d80d33da4c",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      local rest_nvim = require("rest-nvim")
      rest_nvim.setup()

      nmap("<Leader>rh", rest_nvim.run, { desc = "Run http request under cursor" })
      nmap("<Leader>rH", rest_nvim.last, { desc = "Run last http request" })
    end,
    ft = "http",
  }
end
return M
