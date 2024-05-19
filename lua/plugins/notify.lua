return {
	"rcarriga/nvim-notify",
	lazy = true,
	event = "VeryLazy",
	keys = {
		{
			"<leader>un",
			function()
				require("notify").dismiss({ silent = true, pending = true })
			end,
			desc = "Delete all Notifications",
		},
	},
	opts = {
		timeout = 3000,
		max_height = function()
			return math.floor(vim.o.lines * 0.75)
		end,
		max_width = function()
			return math.floor(vim.o.columns * 0.75)
		end,
	},
	-- event = "BufWinEnter",
	config = function()
		local notify = require("notify")
		-- this for transparency
		notify.setup({ background_colour = "#000000" })
		-- this overwrites the vim notify function
		vim.notify = notify.notify
	end,
}
