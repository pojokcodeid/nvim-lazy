return {
	-- transparant config
	{
		"xiyaowong/transparent.nvim",
		event = "BufWinEnter",
		cmd = { "TransparentToggle", "TransparentEnable", "TransparentDisable" },
		config = function()
			require("transparent").clear_prefix("BufferLine")
			-- clear prefix for which-key
			require("transparent").clear_prefix("WhichKey")
			-- clear prefix for lazy.nvim
			require("transparent").clear_prefix("Lazy")
			-- clear prefix for NvimTree
			require("transparent").clear_prefix("NvimTree")
			-- clear prefix for NeoTree
			require("transparent").clear_prefix("NeoTree")
			-- clear prefix for Lualine
			require("transparent").clear_prefix("Lualine")
			require("transparent").setup({
				extra_groups = {},
				exclude_groups = {
					-- disable active selection backgroun
					"CursorLine",
					"CursorLineNR",
					"CursorLineSign",
					"CursorLineFold",
					-- disable nvimtree CursorLine
					"NvimTreeCursorLine",
					-- disable Neotree CursorLine
					"NeoTreeCursorLine",
				},
			})
		end,
	},
}
