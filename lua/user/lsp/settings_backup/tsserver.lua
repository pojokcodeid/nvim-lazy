return {
  -- add cmd
  cmd = { "typescript-language-server", "--stdio" },
  -- add file type support
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
  },
  -- add dynamic root dir support
  root_dir = require("lspconfig.util").root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
  init_options = {
    hostInfo = "neovim",
  },
}
