return {
	"mrjones2014/smart-splits.nvim",
	lazy = true,
	event = { "BufRead", "InsertEnter", "BufNewFile" },
	opts = {
		ignored_filetypes = {
			"nofile",
			"quickfix",
			"qf",
			"prompt",
		},
		ignored_buftypes = { "nofile" },
	},
	config = function(_, opts)
		require("smart-splits").setup(opts)
		vim.keymap.set("n", "<C-Left>", require("smart-splits").resize_left)
		vim.keymap.set("n", "<C-Down>", require("smart-splits").resize_down)
		vim.keymap.set("n", "<C-Up", require("smart-splits").resize_up)
		vim.keymap.set("n", "<C-Right>", require("smart-splits").resize_right)
	end,
}
