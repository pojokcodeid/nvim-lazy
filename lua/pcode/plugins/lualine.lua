return {
	{
		"pojokcodeid/auto-lualine.nvim",
		event = { "InsertEnter", "BufRead", "BufNewFile" },
		dependencies = { "nvim-lualine/lualine.nvim" },
		opts = {
			setColor = "auto",
			setOption = "roundedall",
			setMode = 5,
		},
		config = function(_, opts)
			require("auto-lualine").setup(opts)
		end,
	},
}
