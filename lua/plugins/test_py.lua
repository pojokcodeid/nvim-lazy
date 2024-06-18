local M = {}
if pcode.pytest then
  M = {
    "nvim-neotest/neotest",
    dependencies = {
      "mfussenegger/nvim-dap-python",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-neotest/nvim-nio",
      "nvim-neotest/neotest-python",
    },
    config = function()
      local mason_path = vim.fn.glob(vim.fn.stdpath("data") .. "/mason/")
      pcall(function()
        require("dap-python").setup(mason_path .. "packages/debugpy/venv/bin/python")
      end)
      require("neotest").setup({
        adapters = {
          require("neotest-python")({
            dap = { justMyCode = false },
            args = { "--log-level", "DEBUG" },
            runner = "pytest",
            python = "python",
          }),
        },
      })
    end,
  -- stylua: ignore
  keys = {
    { "<leader>T","",desc="  Test"},
    { "<leader>Tt", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run File" },
    { "<leader>Tr", function() require("neotest").run.run() end, desc = "Run Nearest" },
    { "<leader>TT", function() require("neotest").run.run(vim.loop.cwd()) end, desc = "Run All Test Files" },
    { "<leader>Tl", function() require("neotest").run.run_last() end, desc = "Run Last" },
    { "<Leader>Ts", function() require("neotest").summary.toggle() end, desc = "Toggle Summary" },
    { "<leader>To", function() require("neotest").output.open({ enter = true, auto_close = true }) end, desc = "Show Output" },
    { "<Leader>TO", function() require("neotest").output_panel.toggle() end, desc = "Toggle Output Panel" },
    { "<Leader>TS", function() require("neotest").run.stop() end, desc = "Stop" },
  },
  }
end

return M
