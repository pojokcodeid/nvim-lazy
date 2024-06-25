local M = {}
if pcode.active_php_config then
  M = {
    {
      "rcarriga/nvim-dap-ui",
      lazy = true,
      event = "BufRead",
      dependencies = {
        { "mfussenegger/nvim-dap", lazy = true },
        { "nvim-neotest/nvim-nio", lazy = true },
        {
          "xdebug/vscode-php-debug",
          version = "1.x",
          build = "npm install && npm run build",
          config = function()
            require("dap.ext.vscode").load_launchjs()
          end,
        },
      },
      config = function()
        require("user.dapui")
        local dap = require("dap")
        dap.adapters.php = {
          type = "executable",
          command = "node",
          -- change this to where you build vscode-php-debug
          args = { vim.fn.stdpath("data") .. "/lazy/vscode-php-debug/out/phpDebug.js" },
        }

        dap.configurations.php = {
          -- to run php right from the editor
          {
            name = "run current script",
            type = "php",
            request = "launch",
            port = 9003,
            cwd = "${fileDirname}",
            program = "${file}",
            runtimeExecutable = "php",
          },
          -- to listen to any php call
          {
            name = "listen for Xdebug local",
            type = "php",
            request = "launch",
            port = 9003,
          },
          -- to listen to php call in docker container
          {
            name = "listen for Xdebug docker",
            type = "php",
            request = "launch",
            port = 9003,
            -- this is where your file is in the container
            pathMappings = {
              ["/opt/project"] = "${workspaceFolder}",
            },
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
    {
      "nvim-neotest/neotest",
      dependencies = {
        "antoinemadec/FixCursorHold.nvim",
        "olimorris/neotest-phpunit",
        "nvim-neotest/nvim-nio",
      },
      config = function()
        require("neotest-phpunit")({
          filter_dirs = { "vendor" },
        })
        require("neotest").setup({
          adapters = {
            require("neotest-phpunit"),
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
      "mfussenegger/nvim-lint",
      opts = function(_, opts)
        opts.linters_by_ft = opts.linters_by_ft or {}
        opts.linters_by_ft.php = { "phpcs" }
      end,
      config = function(_, opts)
        require("lint").linters_by_ft = opts.linters_by_ft
      end,
    },
    {
      "adalessa/laravel.nvim",
      dependencies = {
        "nvim-telescope/telescope.nvim",
        -- "tpope/vim-dotenv",
        "MunifTanjim/nui.nvim",
        "nvimtools/none-ls.nvim",
      },
      cmd = { "Sail", "Artisan", "Composer", "Npm", "Yarn", "Laravel" },
      keys = {
        { "<leader>L", "", desc = " 󰫐 Laravel" },
        { "<leader>La", ":Laravel artisan<cr>", desc = "Artisan" },
        { "<leader>Lr", ":Laravel routes<cr>", desc = "Routes" },
        { "<leader>Lm", ":Laravel related<cr>", desc = "Related" },
      },
      event = { "VeryLazy" },
      config = true,
    },
  }
end

return M
