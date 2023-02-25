return {
	{ "dracula/vim" },
	-- { "folke/tokyonight.nvim" },
	-- { "arcticicestudio/nord-vim" },
	-- { "sainnhe/sonokai" },
	-- { "RRethy/nvim-base16" },
	-- {
	-- 	"navarasu/onedark.nvim",
	-- 	priority = 1000,
	-- 	config = function()
	-- 		-- Lua
	-- 		require("onedark").setup({
	-- 			style = "darker",
	-- 		})
	-- 		require("onedark").load()
	-- 	end,
	-- },
	{
		"marko-cerovac/material.nvim",
		config = function()
			vim.g.material_style = "palenight"
			require("material").setup({
				lualine_style = "stealth",
			})
		end,
	},
}
