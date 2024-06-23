local M = {}
if pcode.active_java_config.active then
  M = {
    {
      "mfussenegger/nvim-jdtls",
    },
    {
      "nvim-neotest/neotest",
      dependencies = {
        "nvim-neotest/nvim-nio",
        "nvim-lua/plenary.nvim",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-treesitter/nvim-treesitter",
        "andy-bell101/neotest-java",
      },
      config = function()
        require("neotest").setup({
          adapters = {
            require("neotest-java")({
              -- function to determine which runner to use based on project path
              determine_runner = function(project_root_path)
                -- return should be "maven" or "gradle"
                return pcode.active_java_config.project or "gradle"
              end,
              -- override the builtin runner discovery behaviour to always use given
              -- tool. Default is "nil", so no override
              force_runner = nil,
              -- if the automatic runner discovery can't uniquely determine whether
              -- to use Gradle or Maven, fallback to using this runner. Default is
              -- "gradle"
              fallback_runner = pcode.active_java_config.project or "gradle",
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
    },
    {
      "mfussenegger/nvim-dap",
      event = "BufReadPre",
      dependencies = {
        "rcarriga/nvim-dap-ui",
        "theHamsta/nvim-dap-virtual-text",
        "nvim-neotest/nvim-nio",
        "williamboman/mason.nvim",
        "jay-babu/mason-nvim-dap.nvim",
      },
      config = function()
        require("user.dapui")
        local dap = require("dap")
        local util = require("jdtls.util")
        dap.adapters.java = function(callback)
          util.execute_command({ command = "vscode.java.startDebugSession" }, function(err0, port)
            if err0 ~= nil then
              return
            end
            callback({ type = "server", host = "127.0.0.1", port = port })
          end)
        end
        dap.configurations.java = {
          {
            type = "java",
            request = "launch",
            name = "Debug Java",
            program = "${file}",
            args = {},
            cwd = vim.fn.getcwd(),
            stopOnEntry = false,
            console = "integratedTerminal",
            internalConsoleOptions = "neverOpen",
            sourceMaps = true,
            outDir = "${workspaceFolder}/out",
          },
        }
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
