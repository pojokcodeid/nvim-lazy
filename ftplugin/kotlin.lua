-- vim.opt_local.expandtab = true
-- vim.opt_local.shiftwidth = 4
-- vim.opt_local.tabstop = 4
-- vim.opt_local.softtabstop = 4

-- local status_ok, configs = pcall(require, "nvim-treesitter.configs")
-- if not status_ok then
-- 	return
-- end

-- local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
-- if not lspconfig_status_ok then
-- 	return
-- end

-- local mason_ok, mason_lsp = pcall(require, "mason-lspconfig")
-- if not mason_ok then
-- 	return
-- end

-- mason_lsp.setup({
-- 	ensure_installed = { "kotlin_language_server" },
-- 	automatic_installation = true,
-- })

-- lspconfig.kotlin_language_server.setup({
-- 	on_attach = require("user.lsp.handlers").on_attach,
-- 	capabilities = require("user.lsp.handlers").capabilities,
-- 	cmd = { "kotlin-language-server" },
-- 	filetypes = { "kotlin" },
-- 	root_dir = require("lspconfig.util").root_pattern(
-- 		"build.gradle.kts",
-- 		"build.gradle",
-- 		"settings.gradle",
-- 		"gradlew",
-- 		"pom.xml",
-- 		"build.gradle.kts",
-- 		"build.kts",
-- 		".git"
-- 	),
-- })

-- configs.setup({
-- 	ensure_installed = { "kotlin" }, -- pastikan parser TypeScript terinstal
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
