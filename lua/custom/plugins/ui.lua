return {
	-- { "RRethy/nvim-base16" },
	-- -- simbol outline
	-- {
	-- 	"simrat39/symbols-outline.nvim",
	-- 	lazy = true,
	-- 	event = "BufRead",
	-- 	config = function()
	-- 		require("symbols-outline").setup()
	-- 	end,
	-- },
	-- {
	-- 	"nvim-lualine/lualine.nvim",
	-- 	lazy = true,
	-- 	event = "BufWinEnter",
	-- 	config = function()
	-- 		require("user.lualine")
	-- 	end,
	-- },
	{ "RRethy/vim-illuminate", event = "BufRead", enabled = true },
}
