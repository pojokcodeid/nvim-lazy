local M = {}
if pcode.active_prisma_config then
  M = {
    {
      "nvim-treesitter/nvim-treesitter",
      opts = function(_, opts)
        opts.ensure_installed = opts.ensure_installed or {}
        vim.list_extend(opts.ensure_installed, { "prisma" })
      end,
    },
    {
      "williamboman/mason-lspconfig.nvim",
      opts = function(_, opts)
        opts.ensure_installed = opts.ensure_installed or {}
        vim.list_extend(opts.ensure_installed, { "prismals" })
        vim.cmd([[
        autocmd BufWritePost *.prisma silent! execute "!npx prisma format"
      ]])
      end,
    },
  }
end
return M
