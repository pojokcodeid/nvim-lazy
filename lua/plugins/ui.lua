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
	-- line info bootom
	{
		"nvim-lualine/lualine.nvim",
		lazy = true,
		event = { "BufRead", "BufNewFile" },
		config = function()
			require("user.lualine_cfg")
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
