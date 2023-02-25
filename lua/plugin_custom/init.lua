-- custom plugins disini
return {
	{ "nvim-treesitter/nvim-treesitter" },
	--- masukan plugin tambahan disini
	{ "folke/trouble.nvim", enabled = false }, -- ini untuk disable plugin
	-- contoh custom color scheme
	-- {
	-- 	"folke/tokyonight.nvim",
	-- 	event = "BufWinEnter",
	-- 	config = function()
	-- 		vim.cmd([[colorscheme tokyonight-night]])
	-- 	end,
	-- },
}
