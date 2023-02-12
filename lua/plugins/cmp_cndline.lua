return {
	-- {
	-- 	"hrsh7th/cmp-cmdline",
	-- 	event = "BufWinEnter",
	-- 	config = function()
	-- 		local cmp = require("cmp")
	-- 		-- for cmd line
	-- 		cmp.setup.cmdline("/", {
	-- 			mapping = cmp.mapping.preset.cmdline(),
	-- 			sources = {
	-- 				{ name = "buffer" },
	-- 			},
	-- 		})
	--
	-- 		-- -- `:` cmdline setup.
	-- 		cmp.setup.cmdline(":", {
	-- 			mapping = cmp.mapping.preset.cmdline(),
	-- 			sources = cmp.config.sources({
	-- 				{ name = "path" },
	-- 			}, {
	-- 				{
	-- 					name = "cmdline",
	-- 					option = {
	-- 						ignore_cmds = { "man", "!" },
	-- 					},
	-- 				},
	-- 			}),
	-- 		})
	-- 	end,
	-- },

	-- for auto complate commond mode
	{
		"gelguy/wilder.nvim",
		event = "BufWinEnter",
		config = function()
			local wilder = require("wilder")
			wilder.setup({ modes = { ":", "/", "?" } })
			wilder.set_option(
				"renderer",
				wilder.popupmenu_renderer({
					highlighter = wilder.basic_highlighter(),
					left = { " ", wilder.popupmenu_devicons() },
					right = { " ", wilder.popupmenu_scrollbar() },
				})
			)
		end,
	},
}