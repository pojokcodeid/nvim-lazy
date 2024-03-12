local servers = {
	"lua_ls",
}

local function idxOf(array, value)
	for i, v in ipairs(array) do
		if v == value then
			return i
		end
	end
	return nil
end

local data_exists, custom_lsp = pcall(require, "core.config")
if data_exists then
	for _, client in pairs(custom_lsp.mason_ensure_installed) do
		table.insert(servers, client)
	end
end

local unregis_lsp = {}
local data_ok, unregis = pcall(require, "core.config")
if data_ok then
	if unregis.unregister_lsp ~= nil then
		unregis_lsp = unregis.unregister_lsp
	end
end

local settings = {
	ui = {
		-- border = "none",
		border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
		icons = {
			-- package_installed = "◍",
			-- package_pending = "◍",
			-- package_uninstalled = "◍",
			package_pending = " ",
			package_installed = " ",
			package_uninstalled = " ",
		},
		keymaps = {
			-- Keymap to expand a server in the UI
			toggle_server_expand = "<CR>",
			-- Keymap to install the server under the current cursor position
			install_server = "i",
			-- Keymap to reinstall/update the server under the current cursor position
			update_server = "u",
			-- Keymap to check for new version for the server under the current cursor position
			check_server_version = "c",
			-- Keymap to update all installed servers
			update_all_servers = "U",
			-- Keymap to check which installed servers are outdated
			check_outdated_servers = "C",
			-- Keymap to uninstall a server
			uninstall_server = "X",
		},
	},
	log_level = vim.log.levels.INFO,
	max_concurrent_installers = 4,
}

require("mason").setup(settings)
-- * buka remark ini jika akan menggunakan list serverrs diatas dan remark config dibawah
require("mason-lspconfig").setup({
	ensure_installed = servers,
	automatic_installation = true,
})
--
-- * buka remark ini jika ingin menjalankan dengan cara install dan remark config diatas (pilih satu)
-- require("mason-lspconfig").setup()

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
	return
end

local opts = {}

require("mason-lspconfig").setup_handlers({
	function(server_name) -- default handler (optional)
		local is_skip = false
		local my_index = idxOf(unregis_lsp, server_name)
		if my_index ~= nil then
			is_skip = true
		end
		if not is_skip then
			-- if server_name == "lua_ls" then
			-- 	server_name = "sumneko_lua"
			-- end
			opts = {
				on_attach = require("user.lsp.handlers").on_attach,
				capabilities = require("user.lsp.handlers").capabilities,
			}

			server_name = vim.split(server_name, "@")[1]

			local require_ok, conf_opts = pcall(require, "user.lsp.settings." .. server_name)
			if require_ok then
				opts = vim.tbl_deep_extend("force", conf_opts, opts)
			end
			lspconfig[server_name].setup(opts)
		end
	end,
	-- Next, you can provide targeted overrides for specific servers.
	-- ["rust_analyzer"] = function()
	-- 	require("rust-tools").setup({})
	-- end,
	-- ["lua_ls"] = function()
	-- 	lspconfig.sumneko_lua.setup({
	-- 		settings = {
	-- 			Lua = {
	-- 				diagnostics = {
	-- 					globals = { "vim" },
	-- 				},
	-- 			},
	-- 		},
	-- 	})
	-- end,
	-- ["tsserver"] = function()
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
	-- end,
	-- ["emmet_ls"] = function()
	--   lspconfig.emmet_ls.setup({
	--     on_attach = require("user.lsp.handlers").on_attach,
	--     capabilities = require("user.lsp.handlers").capabilities,
	--     -- add cmd
	--     cmd = { "emmet-ls", "-c", "--stdio" },
	--     -- add file type support
	--     -- filetypes = {
	--     -- 	"javascript",
	--     -- 	"javascriptreact",
	--     -- 	"javascript.jsx",
	--     -- 	"typescript",
	--     -- 	"typescriptreact",
	--     -- 	"typescript.tsx",
	--     -- "astro",
	--     -- "css",
	--     -- "eruby",
	--     -- "html",
	--     -- "htmldjango",
	--     -- "less",
	--     -- "pug",
	--     -- "sass",
	--     -- "scss",
	--     -- "svelte",
	--     -- "vue"                                                                                                                   -- },
	--     -- add dynamic root dir support
	--     root_dir = require("lspconfig.util").root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
	--   })
	-- end,
	-- ["eslint"] = function()
	--   lspconfig.eslint.setup({
	--     on_attach = require("user.lsp.handlers").on_attach,
	--     capabilities = require("user.lsp.handlers").capabilities,
	--     -- add cmd
	--     cmd = { "vscode-eslint-language-server", "--stdio" }, -- add file type support
	--     filetypes = {
	--       "javascript",
	--       "javascriptreact",
	--       "javascript.jsx",
	--       "typescript",
	--       "typescriptreact",
	--       "typescript.tsx",
	--     },
	--     -- add dynamic root dir support
	--     root_dir = require("lspconfig.util").root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
	--   })
	-- end,
	-- ["kotlin_language_server"] = function()
	--   lspconfig.kotlin_language_server.setup({
	--     on_attach = require("user.lsp.handlers").on_attach,
	--     capabilities = require("user.lsp.handlers").capabilities,
	--     cmd = { "kotlin-language-server" },
	--     filetypes = { "kotlin" },
	--     root_dir = require("lspconfig.util").root_pattern(
	--       "build.gradle.kts",
	--       "build.gradle",
	--       "settings.gradle",
	--       "gradlew",
	--       "pom.xml",
	--       "build.gradle.kts",
	--       "build.kts",
	--       ".git"
	--     ),
	--   })
	-- end,
	-- ["clangd"] = function()
	--   lspconfig.clangd.setup({
	--     on_attach = require("user.lsp.handlers").on_attach,
	--     capabilities = require("user.lsp.handlers").capabilities,
	--     root_dir = require("lspconfig.util").root_pattern(
	--       "build",
	--       "compile_commands.json",
	--       ".git",
	--       "mvnw",
	--       "gradlew",
	--       "pom.xml",
	--       "build.gradle"
	--     ) or vim.loop.cwd() or vim.fn.getcwd(),
	--   })
	-- end,
})
