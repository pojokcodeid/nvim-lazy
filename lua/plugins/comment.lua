return {
	"numToStr/Comment.nvim",
	lazy = true,
	opts = function()
		return {
			pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
		}
	end,
	config = function(_, opts)
		require("Comment").setup(opts)
	end,
}
