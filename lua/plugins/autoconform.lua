local M = {}
local disable = pcode.disable_null_ls or false
if require("user.utils.cfgstatus").cheack() then
  disable = true
end
if disable then
  M = {
    "pojokcodeid/auto-conform.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "stevearc/conform.nvim",
    },
    event = "VeryLazy",
    config = function()
      require("auto-conform").setup({
        -- formatters config conform
        formatters = {
          -- yamlfix = {
          --   -- Change where to find the command
          --   command = "local/path/yamlfix",
          --   -- Adds environment args to the yamlfix formatter
          --   env = {
          --     YAMLFIX_SEQUENCE_STYLE = "block_style",
          --   },
          -- },
        },
        -- formatters_by_ft conform
        formatters_by_ft = {
          lua = { "stylua" },
        },
        -- install mason formatter
        ensure_installed = {
          "prettier",
        },
        -- mapping masson language vs filetype
        lang_maps = {
          -- ["c++"] = "cpp",
          -- ["c#"] = "cs",
          -- ["jsx"] = "javascriptreact",
        },
        -- mappings conform name vs masonn name if not same
        name_maps = {
          -- ["cmakelang"] = "cmake_format",
          -- ["deno"] = "deno_fmt",
          -- ["elm-format"] = "elm_format",
        },
        -- add new mapping to conform
        add_new = {
          -- ["jsonc"] = "prettier",
          -- ["json"] = "prettier",
          -- ["typescriptreact"] = "prettier",
        },
        -- disable register mason to conform
        ignore = {
          -- ["php"] = "tlint",
          -- ["lua"] = "ast-grep",
          -- ["kotlin"] = "ktlint",
        },
      })
      -- other conform config
      local conform = require("conform")
      conform.setup({
        format_on_save = {
          lsp_fallback = true,
          timeout_ms = pcode.format_timeout_ms or 5000,
        },
      })
      vim.keymap.set({ "n", "v" }, "<leader>lF", function()
        conform.format({
          lsp_fallback = true,
          async = false,
          timeout_ms = pcode.format_timeout_ms or 5000,
        })
      end, { desc = "Format file or range (in visual mode)" })
    end,
  }
end
return M
