-- rujukan
-- https://github.com/fredrikaverpil/neotest-golang
local M = {}
if pcode.active_golang_config then
  M = {
    {
      "nvim-neotest/neotest",
      event = "VeryLazy",
      dependencies = {
        "nvim-lua/plenary.nvim",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-treesitter/nvim-treesitter",

        "nvim-neotest/neotest-plenary",
        "nvim-neotest/neotest-vim-test",

        "nvim-neotest/nvim-nio",

        {
          "fredrikaverpil/neotest-golang",
          dependencies = {
            {
              "leoluz/nvim-dap-go",
              opts = {},
            },
          },
          branch = "main",
        },
      },
      opts = function(_, opts)
        opts.adapters = opts.adapters or {}
        opts.adapters["neotest-golang"] = {
          go_test_args = {
            "-v",
            "-race",
            "-count=1",
            "-timeout=60s",
            "-coverprofile=" .. vim.fn.getcwd() .. "/coverage.out",
          },
          dap_go_enabled = true,
        }
      end,
      config = function(_, opts)
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
        { "<leader>Ta", function() require("neotest").run.attach() end, desc = "[t]est [a]ttach" },
        { "<leader>Tf", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "[t]est run [f]ile" },
        { "<leader>TA", function() require("neotest").run.run(vim.uv.cwd()) end, desc = "[t]est [A]ll files" },
        { "<leader>TS", function() require("neotest").run.run({ suite = true }) end, desc = "[t]est [S]uite" },
        { "<leader>Tn", function() require("neotest").run.run() end, desc = "[t]est [n]earest" },
        { "<leader>Tl", function() require("neotest").run.run_last() end, desc = "[t]est [l]ast" },
        { "<leader>Ts", function() require("neotest").summary.toggle() end, desc = "[t]est [s]ummary" },
        { "<leader>To", function() require("neotest").output.open({ enter = true, auto_close = true }) end, desc = "[t]est [o]utput" },
        { "<leader>TO", function() require("neotest").output_panel.toggle() end, desc = "[t]est [O]utput panel" },
        { "<leader>Tt", function() require("neotest").run.stop() end, desc = "[t]est [t]erminate" },
        { "<leader>Td", function() require("neotest").run.run({ suite = false, strategy = "dap" }) end, desc = "Debug nearest test" },
      },
    },
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
      config = function()
        require("mason-nvim-dap").setup({
          automatic_installation = true,
          automatic_setup = true,
          handlers = {},
          ensure_installed = { "delve" },
        })
      end,
    },
    {
      "mfussenegger/nvim-lint",
      events = { "BufWritePost", "BufReadPost", "InsertLeave" },
      opts = function(_, opts)
        opts.linters_by_ft = opts.linters_by_ft or {}
        opts.linters_by_ft.go = { "golangcilint" }
        return opts
      end,
      config = function(_, opts)
        require("lint").linters_by_ft = opts.linters_by_ft
      end,
    },
    {
      "stevearc/conform.nvim",
      event = { "BufReadPre", "BufNewFile" },
      opts = function(_, opts)
        local psave = pcode.format_on_save or 0
        opts.formatters_by_ft = opts.formatters_by_ft or {}
        opts.formatters_by_ft.go = { "gofmt" }
        if psave == 1 then
          opts.format_on_save = {
            timeout_ms = pcode.format_timeout_ms or 500,
            lsp_fallback = true,
          }
        end
        return opts
      end,
      config = function(_, opts)
        local conform = require("conform")
        conform.setup(opts)
        vim.keymap.set({ "n", "v" }, "<leader>lF", function()
          conform.format({
            lsp_fallback = true,
            async = false,
            timeout_ms = pcode.format_timeout_ms or 500,
          })
        end, { desc = "Format file or range (in visual mode)" })
      end,
    },
  }
end

return M
