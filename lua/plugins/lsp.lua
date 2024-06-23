return {
  {
    "neovim/nvim-lspconfig",
    lazy = true,
    event = "BufRead",
    cmd = {
      "LspInfo",
      "LspInstall",
      "LspUninstall",
    },
    config = function()
      require("lspconfig.ui.windows").default_options.border = "rounded"
    end,
  },
  {
    "williamboman/mason.nvim",
    lazy = true,
    dependencies = { "williamboman/mason-lspconfig.nvim" },
    cmd = {
      "Mason",
      "MasonInstall",
      "MasonUninstall",
      "MasonUninstallAll",
      "MasonLog",
    },
    config = function()
      require("user.lsp")
    end,
  },
}
