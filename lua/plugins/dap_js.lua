local M = {}
if pcode.nvim_dap_javascript then
  M = {
    {
      "rcarriga/nvim-dap-ui",
      lazy = true,
      event = "BufRead",
      dependencies = {
        { "mfussenegger/nvim-dap", lazy = true },
        { "nvim-neotest/nvim-nio", lazy = true },
        {
          "mxsdev/nvim-dap-vscode-js",
          dependencies = {
            "microsoft/vscode-js-debug",
            version = "1.x",
            build = "npm i && npm run compile vsDebugServerBundle && mv dist out",
          },
          config = function()
            require("dap-vscode-js").setup({
              -- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
              debugger_path = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug",
              -- debugger_cmd = { "extension" }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
              adapters = {
                "chrome",
                "pwa-node",
                "pwa-chrome",
                "pwa-msedge",
                "node-terminal",
                "pwa-extensionHost",
                "node",
                "chrome",
              }, -- which adapters to register in nvim-dap
              -- log_file_path = "(stdpath cache)/dap_vscode_js.log" -- Path for file logging
              -- log_file_level = false -- Logging level for output to file. Set to false to disable file logging.
              -- log_console_level = vim.log.levels.ERROR -- Logging level for output to console. Set to false to disable console output.
            })
          end,
        },
      },
      config = function()
        require("user.dapui")
        local js_based_languages = { "typescript", "javascript", "typescriptreact" }

        for _, language in ipairs(js_based_languages) do
          require("dap").configurations[language] = {
            {
              type = "pwa-node",
              request = "launch",
              name = "Launch file",
              program = "${file}",
              cwd = "${workspaceFolder}",
            },
            {
              type = "pwa-node",
              request = "attach",
              name = "Attach",
              processId = require("dap.utils").pick_process,
              cwd = "${workspaceFolder}",
            },
            {
              type = "pwa-chrome",
              request = "launch",
              name = 'Start Chrome with "localhost"',
              url = "http://localhost:3000",
              webRoot = "${workspaceFolder}",
              userDataDir = "${workspaceFolder}/.vscode/vscode-chrome-debug-userdatadir",
            },
          }
        end
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
