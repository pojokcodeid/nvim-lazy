return {
	"akinsho/flutter-tools.nvim",
	dependencies = { "mason-lspconfig.nvim", "nvim-lua/plenary.nvim" },
	event = "BufRead",
	config = function()
		require("flutter-tools").setup({
			server = {
				color = {
					enabled = true,
				},
				settings = {
					showTodos = true,
					completeFunctionCalls = true,
				},
				on_attach = require("user.lsp.handlers").on_attach,
				capabilities = {
					require("user.lsp.handlers").capabilities,
				},
			},
		})
	end,
}
