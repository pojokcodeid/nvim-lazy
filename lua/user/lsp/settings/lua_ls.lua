return {
	settings = {

		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.stdpath("config") .. "/lua"] = true,
					[vim.fn.expand("$VIMRUNTIME")] = true,
					["${3rd}/busted/library"] = true,
					["${3rd}/luassert/library"] = true,
					["${3rd}/luv/library"] = true,
				},
				maxPreload = 5000,
				preloadFileSize = 10000,
			},
		},
	},
}
