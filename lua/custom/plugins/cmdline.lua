return {
	{ "gelguy/wilder.nvim", enabled = false },
	{
		"folke/noice.nvim",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
			"nvim-treesitter/nvim-treesitter",
		},
		event = "BufWinEnter",
		config = function()
			vim.opt.lazyredraw = false
			require("noice").setup({
				messages = {
					enabled = false,
				},
				notify = {
					enabled = false,
				},
				lsp = {
					progress = {
						enabled = false,
					},
				},
			})
		end,
	},
	{
		"hrsh7th/cmp-cmdline",
		event = "BufWinEnter",
		config = function()
			local cmp = require("cmp")
			local mapping = {
				["<CR>"] = cmp.mapping.confirm({ select = true }),
				["<Up>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
				["<S-Tab>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
				["<Down>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
				["<Tab>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
			}

			-- Use buffer source for `/`.
			cmp.setup.cmdline("/", {
				preselect = "none",
				completion = {
					completeopt = "menu,preview,menuone,noselect",
				},
				mapping = mapping,
				sources = {
					{ name = "buffer" },
				},
				experimental = {
					ghost_text = true,
					native_menu = false,
				},
			})

			-- Use cmdline & path source for ':'.
			cmp.setup.cmdline(":", {
				preselect = "none",
				completion = {
					completeopt = "menu,preview,menuone,noselect",
				},
				mapping = mapping,
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{ name = "cmdline" },
				}),
				experimental = {
					ghost_text = true,
					native_menu = false,
				},
			})
		end,
	},
}
