return {
	"sigmasd/deno-nvim",
	event = "BufRead",
	dependencies = { "mason-lspconfig.nvim" },
	config = function()
		require("deno-nvim").setup({
			server = {
				on_attach = require("user.lsp.handlers").on_attach,
				capabilities = require("user.lsp.handlers").capabilities,
			},
		})
	end,
}
