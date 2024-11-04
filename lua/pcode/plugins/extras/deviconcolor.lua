return {
	"rachartier/tiny-devicons-auto-colors.nvim",
	event = "VeryLazy",
	config = function()
		require("tiny-devicons-auto-colors").setup()
	end,
}
