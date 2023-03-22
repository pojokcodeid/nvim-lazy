local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
	return
end

local lspconfig = require("lspconfig")

-- local servers = { "jsonls", "sumneko_lua","html","cssls","tsserver"}
-- local servers = { "jdtls", "yamlls" }
local servers = {}

local data_exists, custom_lsp = pcall(require, "core.config")
if data_exists then
	for _, client in pairs(custom_lsp.lsp_installer) do
		table.insert(servers, client)
	end
end

lsp_installer.setup({
	ensure_installed = servers,
})

for _, server in pairs(servers) do
	local opts = {
		on_attach = require("user.lsp.handlers").on_attach,
		capabilities = require("user.lsp.handlers").capabilities,
	}
	local has_custom_opts, server_custom_opts = pcall(require, "user.lsp.settings." .. server)
	if has_custom_opts then
		opts = vim.tbl_deep_extend("force", opts, server_custom_opts)
	end
	lspconfig[server].setup(opts)
end

-- lspconfig.yamlls.setup({
-- 	fletype = { "yaml", "yaml.docker-compose" },
-- })
