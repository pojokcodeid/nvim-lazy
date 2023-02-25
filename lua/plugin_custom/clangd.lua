return {
	"p00f/clangd_extensions.nvim",
	dependencies = { "mason-lspconfig.nvim" },
	event = "BufRead",
	config = function()
		require("clangd_extensions").setup({
			server = {
				on_attach = require("user.lsp.handlers").on_attach,
				capabilities = {
					offsetEncoding = "utf-8",
					require("user.lsp.handlers").capabilities,
				},
			},
		})
	end,
}
