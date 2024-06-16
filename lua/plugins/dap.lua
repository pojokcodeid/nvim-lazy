local M = {}
if vim.fn.has("win32") == 0 then
  M = {
    {
      "rcarriga/nvim-dap-ui",
      lazy = true,
      event = "BufRead",
      dependencies = {
        { "mfussenegger/nvim-dap", lazy = true },
        { "nvim-neotest/nvim-nio", lazy = true },
      },
      enabled = vim.fn.has("win32") == 0,
      config = function()
        require("user.dapui")
      end,
    },
    {
      "jay-babu/mason-nvim-dap.nvim",
      lazy = true,
      event = "BufRead",
      dependencies = { "williamboman/mason.nvim", "mfussenegger/nvim-dap" },
      enabled = vim.fn.has("win32") == 0,
      config = function()
        require("user.mason_dap")
      end,
    },
  }
end

return M
