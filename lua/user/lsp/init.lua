local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
	return
end

require("user.lsp.mason_cfg")
--require("user.lsp.config") -- ini hanya untuk windows supaya jdtls jalan, kalau pakai linu x remark saja
require("user.lsp.handlers").setup()
--require("user.lsp.null-lscfg")
