return {
	-- transparant config
	{
		"xiyaowong/transparent.nvim",
		lazy = true,
		event = "BufWinEnter",
		cmd = { "TransparentToggle", "TransparentEnable", "TransparentDisable" },
		config = function()
			require("transparent").setup({
				extra_groups = {
					"Normal",
					"NormalNC",
					"NormalFloat",
					"FloatBorder",
					"Comment",
					"Folded",
					"GitSignsAdd",
					"GitSignsDelete",
					"GitSignsChange",
					"FoldColumn",
					"WinBar",
					"WinBarNC",
					"NotifyBackground",
				},
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
					-- disable Telescope active selection background
					"TelescopeSelection",
					-- disable lualine background color
					"LualineNormal",
				},
			})
			require("transparent").clear_prefix("BufferLine")
			-- clear prefix for which-key
			require("transparent").clear_prefix("WhichKey")
			-- clear prefix for lazy.nvim
			require("transparent").clear_prefix("Lazy")
			-- clear prefix for NvimTree
			require("transparent").clear_prefix("NvimTree")
			-- clear prefix for NeoTree
			require("transparent").clear_prefix("NeoTree")
			-- clear prefix for Telescope
			require("transparent").clear_prefix("Telescope")
			require("transparent").clear_prefix("mason")
			-- create auto command to set transparent
			vim.cmd("TransparentDisable")
			vim.cmd("TransparentEnable")
		end,
	},
	{
		"rcarriga/nvim-notify",
		opts = function(_, opts)
			opts.background_colour = "#00000000"
		end,
	},
}
