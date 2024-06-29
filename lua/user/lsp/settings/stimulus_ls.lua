return {
  filetypes = { "blade" },
  root_dir = require("lspconfig.util").root_pattern("composer.json", ".git") or vim.loop.cwd() or vim.fn.getcwd(),
  singe_file_support = true,
}
