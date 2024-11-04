return {
	"numToStr/Comment.nvim",
	event = "VeryLazy",
	dependencies = {
		"JoosepAlviste/nvim-ts-context-commentstring",
	},
	opts = function()
		return {
			pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
		}
	end,
	keys = {
		{
			"<leader>/",
			"<Plug>(comment_toggle_linewise_current)",
			desc = "󰆈 Coment line",
			mode = "n",
		},
		{
			"<leader>/",
			"<Plug>(comment_toggle_linewise_visual)",
			desc = "󰆈 Coment line",
			mode = "v",
		},
	},
	config = function(_, opts)
		require("Comment").setup(opts)
	end,
}
