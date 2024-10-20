return {
	cmd = { "intelephense", "--stdio" },
	filetypes = { "php" },
	root_dir = require("lspconfig.util").root_pattern("composer.json", ".git") or vim.loop.cwd() or vim.fn.getcwd(),
	single_file_support = true,
}
