return {
	-- dashboard
	{
		"goolord/alpha-nvim",
		lazy = true,
		event = "VimEnter",
		config = function()
			require("user.alpha")
		end,
	},
	-- key mapping
	{
		"folke/which-key.nvim",
		lazy = true,
		keys = { "<leader>", '"', "'", "`", "c", "v" },
		event = "VeryLazy",
		config = function()
			require("user.whichkey")
		end,
	},
}
