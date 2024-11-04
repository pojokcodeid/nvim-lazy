return {
	"akinsho/bufferline.nvim",
	branch = "main",
	event = { "BufRead", "InsertEnter", "BufNewFile" },
	dependencies = "pojokcodeid/auto-bufferline.nvim",
	config = function()
		vim.opt.termguicolors = true
		local config = require("auto-bufferline").config()
		require("bufferline").setup(config)
	end,
	keys = {
		{ "<leader>b", "", desc = "  Buffers", mode = "n" },
		{
			"<leader>bb",
			function()
				require("telescope.builtin").buffers(require("telescope.themes").get_dropdown({ previewer = false }))
			end,
			desc = "All Buffer",
			mode = "n",
		},
		{
			"<leader>bc",
			function()
				require("auto-bufferline.configs.utils").bufremove()
			end,
			desc = "Close current buffer",
			mode = "n",
		},
		{ "<leader>bd", "<cmd>BufferLineCloseLeft<cr>", desc = "Close Buffer Left", mode = "n" },
		{ "<leader>bD", "<cmd>BufferLineCloseRight<cr>", desc = "Close Buffer Right", mode = "n" },
		{ "<leader>ba", "<cmd>BufferLineCloseOthers<cr>", desc = "Close Buffer Other", mode = "n" },
		{ "<leader>bA", "<cmd>BufferLineCloseOthers<cr><cmd>bd!<cr>", desc = "Close Buffer All", mode = "n" },
	},
}
