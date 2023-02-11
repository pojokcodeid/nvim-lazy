require("cmp").setup.cmdline({ "/", "?" }, {
	mapping = require("cmp").mapping.preset.cmdline({
		["<C-z>"] = {
			c = function()
				if require("cmp").visible() then
					require("cmp").select_next_item()
				else
					require("cmp").complete()
				end
			end,
		},
		["<C-e>"] = { c = require("cmp").mapping.abort() },
		["<C-y>"] = { c = require("cmp").mapping.confirm({ select = false }) },
	}),
	sources = require("cmp").config.sources({ { name = "buffer", keyword_length = 1 } }),
})

require("cmp").setup.cmdline(":", {
	mapping = require("cmp").mapping.preset.cmdline({
		["<C-z>"] = {
			c = function()
				if require("cmp").visible() then
					require("cmp").select_next_item()
				else
					require("cmp").complete()
				end
			end,
		},
		["<C-e>"] = { c = require("cmp").mapping.abort() },
		["<C-y>"] = { c = require("cmp").mapping.confirm({ select = false }) },
	}),
	sources = require("cmp").config.sources({
		{ name = "path", keyword_length = 1 },
	}, {
		{ name = "cmdline", keyword_length = 1 },
	}),
})
