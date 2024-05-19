return {
	"lukas-reineke/indent-blankline.nvim",
	-- version = "3.5.4",
	event = { "BufRead", "InsertEnter", "BufNewFile" },
	lazy = true,
	opts = {
		indent = {
			char = "│",
			tab_char = "│",
		},
		scope = { enabled = false },
		exclude = {
			buftypes = {
				"nofile",
				"prompt",
				"quickfix",
				"terminal",
			},
			filetypes = {
				"help",
				"alpha",
				"dashboard",
				"neo-tree",
				"Trouble",
				"trouble",
				"lazy",
				"mason",
				"notify",
				"toggleterm",
				"lazyterm",
				"NvimTree",
				"aerial",
				"neogitstatus",
				"startify",
			},
		},
	},
	main = "ibl",
}
