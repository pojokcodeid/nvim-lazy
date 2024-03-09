-- initial gui app
local is_neovide = false
local use_noice = true
if vim.g.neovide then
	is_neovide = true
	use_noice = false
end
vim.opt.lazyredraw = is_neovide
return {
	{ "gelguy/wilder.nvim", enabled = not use_noice },
	{
		"folke/noice.nvim",
		lazy = true,
		enabled = use_noice,
		dependencies = {
			{ "MunifTanjim/nui.nvim", enabled = use_noice },
		},
		event = "BufWinEnter",
		opts = {
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
				hover = {
					enabled = false,
				},
				signature = {
					enabled = false,
				},
			},
		},
		keys = {
			{
				"<S-Enter>",
				function()
					require("noice").redirect(vim.fn.getcmdline())
				end,
				mode = "c",
				desc = "Redirect Cmdline",
			},
			{
				"<leader>snl",
				function()
					require("noice").cmd("last")
				end,
				desc = "Noice Last Message",
			},
			{
				"<leader>snh",
				function()
					require("noice").cmd("history")
				end,
				desc = "Noice History",
			},
			{
				"<leader>sna",
				function()
					require("noice").cmd("all")
				end,
				desc = "Noice All",
			},
			{
				"<c-f>",
				function()
					if not require("noice.lsp").scroll(4) then
						return "<c-f>"
					end
				end,
				silent = true,
				expr = true,
				desc = "Scroll forward",
				mode = { "i", "n", "s" },
			},
			{
				"<c-b>",
				function()
					if not require("noice.lsp").scroll(-4) then
						return "<c-b>"
					end
				end,
				silent = true,
				expr = true,
				desc = "Scroll backward",
				mode = { "i", "n", "s" },
			},
		},
	},
	{
		"hrsh7th/cmp-cmdline",
		event = "VeryLazy",
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
