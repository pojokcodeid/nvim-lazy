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
      keys = {
        { "<leader>d", "", desc = "  Debug" },
        { "<leader>dt", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", desc = "Toggle Breakpoint" },
        { "<leader>db", "<cmd>lua require'dap'.step_back()<cr>", desc = "Step Back" },
        { "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", desc = "Continue" },
        { "<leader>dC", "<cmd>lua require'dap'.run_to_cursor()<cr>", desc = "Run To Cursor" },
        { "<leader>dd", "<cmd>lua require'dap'.disconnect()<cr>", desc = "Disconnect" },
        { "<leader>dg", "<cmd>lua require'dap'.session()<cr>", desc = "Get Session" },
        { "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", desc = "Step Into" },
        { "<leader>do", "<cmd>lua require'dap'.step_over()<cr>", desc = "Step Over" },
        { "<leader>du", "<cmd>lua require'dap'.step_out()<cr>", desc = "Step Out" },
        { "<leader>dp", "<cmd>lua require'dap'.pause()<cr>", desc = "Pause" },
        { "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", desc = "Toggle Repl" },
        { "<leader>ds", "<cmd>lua require'dap'.continue()<cr>", desc = "Start" },
        { "<leader>dq", "<cmd>lua require'dap'.close()<cr>", desc = "Quit" },
        { "<leader>dU", "<cmd>lua require'dapui'.toggle({reset = true})<cr>", desc = "Toggle UI" },
      },
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
