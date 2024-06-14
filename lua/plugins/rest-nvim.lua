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
      require("rest-nvim").setup()
    end,
    ft = "http",
    keys = function()
      local rest_nvim = require("rest-nvim")
      return {
        { "<Leader>rh", rest_nvim.run, desc = "Run http request under cursor" },
        { "<Leader>rH", rest_nvim.last, desc = "Run last http request" },
      }
    end,
  }
end
return M
