return {
  cmd = { "emmet-ls", "-c", "--stdio" },
  -- add file type support
  -- filetypes = {
  -- 	"javascript",
  -- 	"javascriptreact",
  -- 	"javascript.jsx",
  -- 	"typescript",
  -- 	"typescriptreact",
  -- 	"typescript.tsx",
  -- "astro",
  -- "css",
  -- "eruby",
  -- "html",
  -- "htmldjango",
  -- "less",
  -- "pug",
  -- "sass",
  -- "scss",
  -- "svelte",
  -- "vue"                                                                                                                   -- },
  -- add dynamic root dir support
  root_dir = require("lspconfig.util").root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
}
