local M = {}
if pcode.active_kotlin_config or false then
  M = {
    -- install treesitter
    {
      "nvim-treesitter/nvim-treesitter",
      opts = function(_, opts)
        opts.ensure_installed = opts.ensure_installed or {}
        vim.list_extend(opts.ensure_installed, { "kotlin" })
      end,
    },
    {
      "williamboman/mason-lspconfig.nvim",
      opts = function(_, opts)
        opts.ensure_installed = opts.ensure_installed or {}
        vim.list_extend(opts.ensure_installed, { "kotlin_language_server" })
      end,
    },
    {
      "stevearc/conform.nvim",
      event = "VeryLazy",
      opts = function(_, opts)
        opts.formatters_by_ft = opts.formatters_by_ft or {}
        local package = "ktfmt"
        require("user.utils.masoncfg").try_install(package)
        opts.formatters_by_ft.kotlin = { package }
      end,
    },
    {
      "mfussenegger/nvim-lint",
      optional = true,
      opts = function(_, opts)
        opts.linters_by_ft = opts.linters_by_ft or {}
        require("user.utils.masoncfg").try_install("ktlint")
        opts.linters_by_ft.kotlin = { "ktlint" }
      end,
    },
    {
      "rcarriga/nvim-dap-ui",
      lazy = true,
      event = "BufRead",
      dependencies = {
        { "mfussenegger/nvim-dap", lazy = true },
        { "nvim-neotest/nvim-nio", lazy = true },
      },
      opts = function()
        require("user.utils.masoncfg").try_install("kotlin-debug-adapter")
        require("user.dapui")
        local dap = require("dap")
        if not dap.adapters.kotlin then
          dap.adapters.kotlin = {
            type = "executable",
            command = "kotlin-debug-adapter",
            options = { auto_continue_if_many_stopped = false },
          }
        end

        dap.configurations.kotlin = {
          {
            type = "kotlin",
            request = "launch",
            name = "This file",
            -- may differ, when in doubt, whatever your project structure may be,
            -- it has to correspond to the class file located at `build/classes/`
            -- and of course you have to build before you debug
            mainClass = function()
              local root = vim.fs.find("src", { path = vim.uv.cwd(), upward = true, stop = vim.env.HOME })[1] or ""
              local fname = vim.api.nvim_buf_get_name(0)
              -- src/main/kotlin/websearch/Main.kt -> websearch.MainKt
              return fname:gsub(root, ""):gsub("main/kotlin/", ""):gsub(".kt", "Kt"):gsub("/", "."):sub(2, -1)
            end,
            projectRoot = "${workspaceFolder}",
            jsonLogFile = "",
            enableJsonLogging = false,
          },
          {
            -- Use this for unit tests
            -- First, run
            -- ./gradlew --info cleanTest test --debug-jvm
            -- then attach the debugger to it
            type = "kotlin",
            request = "attach",
            name = "Attach to debugging session",
            port = 5005,
            args = {},
            projectRoot = vim.fn.getcwd,
            hostName = "localhost",
            timeout = 2000,
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
        -- setting cek 
        -- https://stackoverflow.com/questions/9356543/logging-while-testing-through-gradle
        { "<leader>T", "", desc = " Test" },
        { "<leader>Ta", "<cmd>terminal ./gradlew test<cr>", desc = "Run All" },
        {
          "<leader>Tu",
          function()
            local current_word = vim.fn.expand("<cword>")
            vim.cmd("terminal ./gradlew test --tests *." .. current_word)
          end,
          desc = "Run Under Cursor",
        },
      },
    },
  }
end
return M