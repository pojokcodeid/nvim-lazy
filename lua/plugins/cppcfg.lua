local M = {}
-- local file_name = vim.fn.expand("%:t")
-- local file_name_no_ext = vim.fn.expand("%:t:r")
if pcode.active_cpp_config then
  M = {
    {
      "nvimtools/none-ls.nvim",
      optional = true,
      opts = function(_, opts)
        local nls = require("null-ls")
        opts.sources = opts.sources or {}
        table.insert(opts.sources, nls.builtins.formatting.clang_format.with({ filetypes = { "cpp", "c" } }))
      end,
    },
    {
      "nvim-neotest/neotest",
      ft = { "cpp" },
      dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-neotest/nvim-nio",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-lua/plenary.nvim",
        "alfaix/neotest-gtest",
      },
      config = function()
        require("neotest").setup({
          adapters = {
            require("neotest-gtest").setup({}),
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
        { "<leader>rc", "<cmd>terminal<cr>g++ --debug main.cpp -o main<cr>", desc = "Compile Debug main.cpp" },
      },
    },
    {
      "stevearc/conform.nvim",
      event = { "BufReadPre", "BufNewFile" },
      opts = function(_, opts)
        local psave = pcode.format_on_save or 0
        opts.formatters_by_ft = opts.formatters_by_ft or {}
        opts.formatters_by_ft.cpp = { "clang-format" }
        if psave == 1 then
          opts.format_on_save = {
            timeout_ms = 500,
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
