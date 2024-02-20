vim.opt_local.expandtab = true
vim.opt_local.shiftwidth = 4
vim.opt_local.tabstop = 4
vim.opt_local.softtabstop = 4

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
	return
end

lspconfig.kotlin_language_server.setup({
	on_attach = require("user.lsp.handlers").on_attach,
	capabilities = require("user.lsp.handlers").capabilities,
	cmd = { "kotlin-language-server" },
	filetypes = { "kotlin" },
	root_dir = require("lspconfig.util").root_pattern(
		"build.gradle.kts",
		"build.gradle",
		"settings.gradle",
		"gradlew",
		"pom.xml",
		"build.gradle.kts",
		"build.kts",
		".git"
	),
})
