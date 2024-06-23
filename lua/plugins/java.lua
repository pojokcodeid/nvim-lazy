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
      "stevearc/conform.nvim",
      event = { "BufReadPre", "BufNewFile" },
      opts = function(_, opts)
        local psave = pcode.format_on_save or 0
        opts.formatters_by_ft = opts.formatters_by_ft or {}
        opts.formatters_by_ft.java = { "google-java-format" }
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
            timeout_ms = 500,
          })
        end, { desc = "Format file or range (in visual mode)" })
      end,
    },
  }
end
return M
