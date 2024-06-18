local M = {}
if pcode.nvim_dap_python then
  M = {
    {
      "mfussenegger/nvim-dap",
      event = "BufReadPre",
      dependencies = {
        "rcarriga/nvim-dap-ui",
        "theHamsta/nvim-dap-virtual-text",
        "nvim-neotest/nvim-nio",
        "williamboman/mason.nvim",
        "jay-babu/mason-nvim-dap.nvim",
        "mfussenegger/nvim-dap-python",
      },
      config = function()
        require("nvim-dap-virtual-text").setup({
          virt_text_pos = "eol",
          commented = true,
        })
        local dap_python = require("dap-python")

        require("mason-nvim-dap").setup({
          automatic_installation = true,
          automatic_setup = true,
          handlers = {},
          ensure_installed = { "python" },
        })
        local mason_path = vim.fn.glob(vim.fn.stdpath("data") .. "/mason/")
        local debugpy_path = mason_path .. "packages/debugpy/venv/Scripts/python"

        dap_python.setup(debugpy_path)
        dap_python.default_port = 38000

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
  }
end
return M
