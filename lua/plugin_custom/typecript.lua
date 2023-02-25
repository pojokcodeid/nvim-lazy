return {
	"jose-elias-alvarez/typescript.nvim",
	event = "BufRead",
	dependencies = { "mason-lspconfig.nvim" },
	config = function()
		require("typescript").setup({
			disable_commands = false, -- prevent the plugin from creating Vim commands
			debug = false, -- enable debug logging for commands
			go_to_source_definition = {
				fallback = true, -- fall back to standard LSP definition on failure
			},
			server = { -- pass options to lspconfig's setup method
				on_attach = require("user.lsp.handlers").on_attach,
				capabilities = require("user.lsp.handlers").capabilities,
			},
		})
	end,
}
