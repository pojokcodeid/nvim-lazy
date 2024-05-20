return {
	"SmiteshP/nvim-navic",
	lazy = true,
	dependencies = "neovim/nvim-lspconfig",
	event = "InsertEnter",
	config = function()
		require("user.breadcrumb")
		require("user.winbar")
	end,
}
