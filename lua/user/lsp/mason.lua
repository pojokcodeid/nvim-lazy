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
		border = "none",
		icons = {
			-- package_installed = "◍",
			-- package_pending = "◍",
			-- package_uninstalled = "◍",
			package_pending = " ",
			package_installed = " ",
			package_uninstalled = "◍",
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
			if server_name == "lua_ls" then
				server_name = "sumneko_lua"
			end
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
})
