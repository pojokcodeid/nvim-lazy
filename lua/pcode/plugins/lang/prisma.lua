return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "prisma" })
    end,
  },
  -- overide formatting
  {
    "pojokcodeid/auto-conform.nvim",
    opts = function(_, opts)
      opts.formatters.prisma_fmt = {
        command = "npx",
        args = { "prisma", "format", "--schema", "$FILENAME" },
        stdin = false,
      }
      opts.formatters_by_ft.prisma = { "prisma_fmt" }
      return opts
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
    keys = {
      { "<leader>p", "", desc = "  Prisma" },
      {
        "<leader>pf",
        function()
          vim.cmd("execute '!npx prisma format'")
        end,
        desc = "Prisma Format",
      },
      {
        "<leader>pm",
        function()
          vim.cmd("execute '!npx prisma init --datasource-provider mysql'")
        end,
        desc = "init MySQL",
      },
      {
        "<leader>pp",
        function()
          vim.cmd("execute '!npx prisma init --datasource-provider postgresql'")
        end,
        desc = "init postgresql",
      },
      {
        "<leader>pe",
        function()
          vim.cmd("execute '!npx prisma migrate dev --name init'")
        end,
        desc = "Migrate",
      },
      {
        "<leader>ps",
        function()
          vim.cmd("terminal npx prisma studio")
        end,
        desc = "npx prisma Studio",
      },
    },
  },
}
