return {
	"stevearc/dressing.nvim",
	lazy = true,
	init = function()
		---@diagnostic disable-next-line: duplicate-set-field
		vim.ui.select = function(...)
			require("lazy").load({ plugins = { "dressing.nvim" } })
			return vim.ui.select(...)
		end
		---@diagnostic disable-next-line: duplicate-set-field
		vim.ui.input = function(...)
			require("lazy").load({ plugins = { "dressing.nvim" } })
			return vim.ui.input(...)
		end
	end,
	opts = {
		input = {
			title_pos = "center",
			relative = "editor",
			default_prompt = "➤ ",
			win_options = { winhighlight = "Normal:Normal,NormalNC:Normal" },
			prefer_width = 30,
			max_width = { 140, 0.9 },
			min_width = { 50, 0.2 },
		},
		select = {
			backend = { "telescope", "builtin" },
			builtin = { win_options = { winhighlight = "Normal:Normal,NormalNC:Normal" } },
		},
	},
	config = function(_, opts)
		require("dressing").setup(opts)
	end,
}
