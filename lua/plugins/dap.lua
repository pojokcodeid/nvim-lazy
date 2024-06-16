local M = {}
if vim.fn.has("win32") == 0 and pcode.nvim_dap then
  M = {
    {
      "rcarriga/nvim-dap-ui",
      lazy = true,
      event = "BufRead",
      dependencies = {
        { "mfussenegger/nvim-dap", lazy = true },
        { "nvim-neotest/nvim-nio", lazy = true },
        {
          "theHamsta/nvim-dap-virtual-text",
          opts = {
            virt_text_win_col = 80,
          },
        },
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
