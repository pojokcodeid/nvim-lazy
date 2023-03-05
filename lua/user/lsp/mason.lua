local servers = {
	"sumneko_lua",
	"cssls",
	"html",
	"tsserver",
	"pyright",
	"jsonls",
	"emmet_ls",
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
	for _, client in pairs(custom_lsp.register_lsp) do
		table.insert(servers, client)
	end
end

local data_ok, unregis = pcall(require, "core.config")
if data_ok then
	if unregis.unregister_lsp ~= nil then
		for _, unreg in pairs(unregis.unregister_lsp) do
			local my_index = idxOf(servers, unreg)
			if my_index ~= nil then
				table.remove(servers, my_index)
			end
		end
	end
end

local settings = {
	ui = {
		border = "none",
		icons = {
			package_installed = "◍",
			package_pending = "◍",
			package_uninstalled = "◍",
		},
	},
	log_level = vim.log.levels.INFO,
	max_concurrent_installers = 4,
}

require("mason").setup(settings)
-- * buka remark ini jika akan menggunakan list serverrs diatas dan remark config dibawah
-- require("mason-lspconfig").setup({
-- 	ensure_installed = servers,
-- 	automatic_installation = true,
-- })
--
-- * buka remark ini jika ingin menjalankan dengan cara install dan remark config diatas (pilih satu)
require("mason-lspconfig").setup()

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
	return
end

local opts = {}

for _, server in pairs(servers) do
	opts = {
		on_attach = require("user.lsp.handlers").on_attach,
		capabilities = require("user.lsp.handlers").capabilities,
	}

	server = vim.split(server, "@")[1]

	local require_ok, conf_opts = pcall(require, "user.lsp.settings." .. server)
	if require_ok then
		opts = vim.tbl_deep_extend("force", conf_opts, opts)
	end

	lspconfig[server].setup(opts)
end
