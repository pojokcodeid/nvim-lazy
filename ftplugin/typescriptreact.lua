local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	return
end

configs.setup({
	ensure_installed = { "typescript", "tsx" }, -- pastikan parser TypeScript terinstal
	highlight = {
		enable = true, -- aktifkan highlight berbasis treesitter
		additional_vim_regex_highlighting = false,
	},
	rainbow = {
		enable = false,
	},
	incremental_selection = { enable = true },
	indent = { enable = true, disable = { "python", "css" } },
	autopairs = {
		enable = true,
	},
})

require("nvim-ts-autotag").setup()

-- local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
-- if not lspconfig_status_ok then
-- 	return
-- end

-- local function idxOf(array, value)
-- 	for i, v in ipairs(array) do
-- 		if v == value then
-- 			return i
-- 		end
-- 	end
-- 	return nil
-- end

-- local unregis_lsp = {}
-- local data_ok, unregis = pcall(require, "core.config")
-- if data_ok then
-- 	if unregis.unregister_lsp ~= nil then
-- 		unregis_lsp = unregis.unregister_lsp
-- 	end
-- end

-- local idxts = idxOf(unregis_lsp, "tsserver")
-- if idxts ~= nil then
-- 	lspconfig.tsserver.setup({
-- 		on_attach = require("user.lsp.handlers").on_attach,
-- 		capabilities = require("user.lsp.handlers").capabilities,
-- 		-- add cmd
-- 		cmd = { "typescript-language-server", "--stdio" },
-- 		-- add file type support
-- 		filetypes = {
-- 			"javascript",
-- 			"javascriptreact",
-- 			"javascript.jsx",
-- 			"typescript",
-- 			"typescriptreact",
-- 			"typescript.tsx",
-- 		},
-- 		-- add dynamic root dir support
-- 		root_dir = require("lspconfig.util").root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
-- 		init_options = {
-- 			hostInfo = "neovim",
-- 		},
-- 	})
-- end

-- local idxemmet = idxOf(unregis_lsp, "emmet_ls")
-- if idxemmet ~= nil then
-- 	lspconfig.emmet_ls.setup({
-- 		on_attach = require("user.lsp.handlers").on_attach,
-- 		capabilities = require("user.lsp.handlers").capabilities,
-- 		-- add cmd
-- 		cmd = { "emmet-ls", "-c", "--stdio" },
-- 		-- add file type support
-- 		filetypes = {
-- 			"javascript",
-- 			"javascriptreact",
-- 			"javascript.jsx",
-- 			"typescript",
-- 			"typescriptreact",
-- 			"typescript.tsx",
-- 		},
-- 		-- add dynamic root dir support
-- 		root_dir = require("lspconfig.util").root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
-- 	})
-- end

-- local idxeslint = idxOf(unregis_lsp, "eslint")
-- if idxeslint ~= nil then
-- 	lspconfig.eslint.setup({
-- 		on_attach = require("user.lsp.handlers").on_attach,
-- 		capabilities = require("user.lsp.handlers").capabilities,
-- 		-- add cmd
-- 		cmd = { "vscode-eslint-language-server", "--stdio" }, -- add file type support
-- 		filetypes = {
-- 			"javascript",
-- 			"javascriptreact",
-- 			"javascript.jsx",
-- 			"typescript",
-- 			"typescriptreact",
-- 			"typescript.tsx",
-- 		},
-- 		-- add dynamic root dir support
-- 		root_dir = require("lspconfig.util").root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
-- 	})
-- end
