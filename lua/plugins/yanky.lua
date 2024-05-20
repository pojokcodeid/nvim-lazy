return {
	"gbprod/yanky.nvim",
	event = "BufReadPre",
	opts = {
		ring = {
			history_length = 50,
			storage = "memory",
		},
		preserve_cursor_position = {
			enabled = false,
		},
	},
	config = function(_, opts)
		require("yanky").setup(opts)
		-- cycle through the yank history, only work after paste
		vim.keymap.set("n", "[y", "<Plug>(YankyCycleForward)")
		vim.keymap.set("n", "]y", "<Plug>(YankyCycleBackward)")
	end,
}
