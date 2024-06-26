return {
  {
    "nvimtools/none-ls.nvim",
    lazy = true,
    enabled = not (pcode.disable_null_ls or false),
    dependencies = {
      {
        "jayp0521/mason-null-ls.nvim",
        opts = {
          ensure_installed = pcode.null_ls_ensure_installed or {},
          automatic_setup = true,
          handlers = {},
        },
        config = function(_, opts)
          require("mason-null-ls").setup(opts)
        end,
      },
      "nvimtools/none-ls-extras.nvim",
    },
    event = "InsertEnter",
    opts = function()
      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
      local sources = {}
      local data_ok, data_sources = pcall(require, "custom.null-ls")
      if data_ok then
        for _, cfg in pairs(data_sources.sources) do
          table.insert(sources, cfg)
        end
      end
      local on_save = pcode.format_on_save or 0
      if on_save == 1 then
        return {
          debug = false,
          sources = sources,
          on_attach = function(client, bufnr)
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            local filetype = vim.bo.filetype
            local n = require("null-ls")
            local s = require("null-ls.sources")
            local method = n.methods.FORMATTING
            local available_formatters = s.get_available(filetype, method)

            if
              (#available_formatters > 0 and client.name == "null-ls")
              or client.supports_method("textDocument/formatting")
            then
              vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                  vim.lsp.buf.format({ bufnr = bufnr, timeout_ms = pcode.format_timeout_ms or 5000 })
                end,
              })
            else
              vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                  vim.lsp.buf.format({ bufnr = bufnr, timeout_ms = pcode.format_timeout_ms or 5000, filter = nil })
                end,
              })
            end
          end,
        }
      else
        vim.schedule(function()
          pcall(function()
            vim.api.nvim_clear_autocmds({ group = "LspFormatting" })
          end)
        end)

        return {
          debug = false,
          sources = sources,
        }
      end
    end,
    config = function(_, opts)
      require("null-ls").setup(opts)
    end,
  },
}
