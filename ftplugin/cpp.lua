-- local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
-- if not lspconfig_status_ok then
-- 	return
-- end
--
-- local status_ok, configs = pcall(require, "nvim-treesitter.configs")
-- if not status_ok then
-- 	return
-- end
--
-- local mason_ok, mason_lsp = pcall(require, "mason-lspconfig")
-- if not mason_ok then
-- 	return
-- end
--
-- mason_lsp.setup({
-- 	ensure_installed = { "clangd" },
-- 	automatic_installation = true,
-- })
--
-- lspconfig.clangd.setup({
-- 	on_attach = require("user.lsp.handlers").on_attach,
-- 	capabilities = require("user.lsp.handlers").capabilities,
-- 	root_dir = require("lspconfig.util").root_pattern(
-- 		"build",
-- 		"compile_commands.json",
-- 		".git",
-- 		"mvnw",
-- 		"gradlew",
-- 		"pom.xml",
-- 		"build.gradle"
-- 	) or vim.loop.cwd() or vim.fn.getcwd(),
-- })
--
-- configs.setup({
-- 	ensure_installed = { "cpp" }, -- pastikan parser TypeScript terinstal
-- 	highlight = {
-- 		enable = true, -- aktifkan highlight berbasis treesitter
-- 		additional_vim_regex_highlighting = false,
-- 	},
-- 	rainbow = {
-- 		enable = false,
-- 	},
-- 	incremental_selection = { enable = true },
-- 	indent = { enable = true, disable = { "python", "css" } },
-- 	autopairs = {
-- 		enable = true,
-- 	},
-- })
--
-- require("nvim-ts-autotag").setup()