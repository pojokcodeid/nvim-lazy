local M = {
	"SmiteshP/nvim-navic",
	event = "VeryLazy",
	dependencies = {
		"LunarVim/breadcrumbs.nvim",
		opts = {},
		config = true,
	},
}

function M.config()
	local icons = require("pcode.user.icons").kind
	for key, value in pairs(icons) do
		icons[key] = value .. " "
	end
	require("nvim-navic").setup({
		icons = icons,
		lsp = {
			auto_attach = false,
			preference = nil,
		},
		highlight = false,
		separator = " > ",
		depth_limit = 0,
		depth_limit_indicator = "..",
		safe_output = true,
		lazy_update_context = false,
		click = false,
		format_text = function(text)
			return text
		end,
	})
end

return M
