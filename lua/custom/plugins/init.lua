return {
	--- masukan plugin tambahan disini
	{ "folke/trouble.nvim", enabled = false }, -- ini untuk disable plugin
	{ "dracula/vim" },
	-- { "folke/tokyonight.nvim" },
	-- { "arcticicestudio/nord-vim" },
	-- { "sainnhe/sonokai" },
	-- { "RRethy/nvim-base16" },
	{
		"navarasu/onedark.nvim",
		priority = 1000,
		config = function()
			-- Lua
			require("onedark").setup({
				style = "darker",
			})
			require("onedark").load()
		end,
	},
}
