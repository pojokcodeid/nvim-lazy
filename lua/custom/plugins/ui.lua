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
	-- { "cpea2506/one_monokai.nvim" },
	-- { "luisiacc/gruvbox-baby", lazy = true, enabled = false },
	-- { "projekt0n/github-nvim-theme", version = "v0.0.7" },
}
