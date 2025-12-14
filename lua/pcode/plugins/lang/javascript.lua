local config_file = "jest.config.ts"
-- set tabsize 4 if file type php
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "javascript", "typescript" },
  callback = function()
    vim.opt.tabstop = 4
    vim.opt.shiftwidth = 4
  end,
})
local M = {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "html", "javascript", "typescript", "tsx", "css", "json", "jsonc" })
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "html", "eslint", "cssls", "emmet_ls", "jsonls", "ts_ls" })
    end,
  },
  {
    "pojokcodeid/auto-conform.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      local package = "prettier"
      vim.list_extend(opts.ensure_installed, { package })
      opts.formatters_by_ft.javascript = { package }
    end,
  },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "antoinemadec/FixCursorHold.nvim",
      "nvim-neotest/neotest-jest",
      "nvim-neotest/nvim-nio",
      -- "marilari88/neotest-vitest",
    },
    ft = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
    opts = {
      adapters = {
        ["neotest-jest"] = {
          jestCommand = "npm test -- ",
          jestConfigFile = function()
            local file = vim.fn.expand("%:p")
            if string.find(file, "/packages/") then
              return string.match(file, "(.-/[^/]+/)src") .. config_file
            end
            return vim.fn.getcwd() .. "/" .. config_file
          end,
          cwd = function()
            local file = vim.fn.expand("%:p")
            if string.find(file, "/packages/") then
              return string.match(file, "(.-/[^/]+/)src")
            end
            return vim.fn.getcwd()
          end,
        },
        -- ["neotest-vitest"] = {},
      },
      status = { virtual_text = true },
      output = { open_on_run = true },
    },
    config = function(_, opts)
      local neotest_ns = vim.api.nvim_create_namespace("neotest")
      vim.diagnostic.config({
        virtual_text = {
          format = function(diagnostic)
            -- Replace newline and tab characters with space for more compact diagnostics
            local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
            return message
          end,
        },
      }, neotest_ns)

      opts.consumers = opts.consumers or {}
      if opts.adapters then
        local adapters = {}
        for name, config in pairs(opts.adapters or {}) do
          if type(name) == "number" then
            if type(config) == "string" then
              config = require(config)
            end
            adapters[#adapters + 1] = config
          elseif config ~= false then
            local adapter = require(name)
            if type(config) == "table" and not vim.tbl_isempty(config) then
              local meta = getmetatable(adapter)
              if adapter.setup then
                adapter.setup(config)
              elseif meta and meta.__call then
                adapter(config)
              else
                error("Adapter " .. name .. " does not support setup")
              end
            end
            adapters[#adapters + 1] = adapter
          end
        end
        opts.adapters = adapters
      end

      require("neotest").setup(opts)
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
    "pojokcodeid/npm-runner.nvim",
    event = "VeryLazy",
    dependencies = {
      "rcarriga/nvim-notify",
    },
    -- your opts go here
    opts = {
      command = {
        dev = {
          start = "NpmRunDev",
          stop = "NpmStopDev",
          cmd = "npm run dev",
        },
        prod = {
          start = "NpmStart",
          stop = "NpmStop",
          cmd = "npm start",
        },
      },
      opt = {
        show_mapping = "<leader>nm",
        hide_mapping = "<leader>nh",
        width = 70,
        height = 20,
      },
    },
    keys = {
      { "<leader>n", "", desc = "  Npm" },
    },
    config = function(_, opts)
      require("npm-runner").setup(opts.command, opts.opt)
    end,
  },
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
      require("pcode.user.dapui")
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

return M
