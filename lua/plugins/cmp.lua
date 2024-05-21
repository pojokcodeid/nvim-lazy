local cmprg = vim.g.pcode_cmprg or false
local cmpcalc = vim.g.pcode_cmpcalc or false
local cmptag = vim.g.pcode_cmptag or false
local lspghost_text = vim.g.pcode_lspghost_text or false
local icons = require("user.icons").ui
return {
	{ "hrsh7th/cmp-nvim-lsp", event = "InsertEnter", lazy = true },
	{ "hrsh7th/cmp-buffer", event = "InsertEnter", lazy = true },
	{ "hrsh7th/cmp-path", event = "InsertEnter", lazy = true },
	{ "saadparwaiz1/cmp_luasnip", event = "InsertEnter", lazy = true },
	{ "hrsh7th/cmp-nvim-lua", event = "InsertEnter", lazy = true },
	{ "lukas-reineke/cmp-rg", lazy = true, enabled = cmprg }, -- experimental
	{ "hrsh7th/cmp-calc", lazy = true, enabled = cmpcalc }, -- experimental
	{ "quangnguyen30192/cmp-nvim-tags", lazy = true, enabled = cmptag }, -- experimental
	{
		"hrsh7th/nvim-cmp",
		lazy = true,
		version = false, -- last release is way too old
		event = "InsertEnter",
		opts = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")

			local check_backspace = function()
				local col = vim.fn.col(".") - 1
				return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
			end

			return {
				completion = {
					completeopt = "menu,menuone,noinsert",
				},
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expandable() then
							luasnip.expand()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						elseif check_backspace() then
							fallback()
						else
							fallback()
						end
					end, {
						"i",
						"s",
					}),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, {
						"i",
						"s",
					}),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "buffer" },
					{ name = "path" },
					{ name = "nvim_lua" },
					{ name = "rg" }, -- experimental
					{ name = "calc" }, -- experimental
					{ name = "tags" }, --experimental
				}),
				formatting = {
					fields = { "kind", "abbr", "menu" },
					format = function(entry, vim_item)
						vim_item.kind = string.format("%s", require("user.icons")["kind"][vim_item.kind])
						vim_item.menu = ({
							nvim_lsp = "(LSP)",
							luasnip = "(Snippet)",
							buffer = "(Buffer)",
							path = "(Path)",
						})[entry.source.name]
						return vim_item
					end,
				},
				window = {
					-- completion = cmp.config.window.bordered(),
					-- documentation = cmp.config.window.bordered(),
					-- remove border window from cmp
					completion = {
						border = icons.Border,
						winhighlight = "Normal:bg,FloatBorder:BorderBG,CursorLine:PmenuSel,Search:None",
						scrollbar = true,
					},
					documentation = {
						border = icons.Border,
						winhighlight = "Normal:bg,FloatBorder:BorderBG,CursorLine:PmenuSel,Search:None",
						scrollbar = true,
					},
				},
				experimental = {
					ghost_text = lspghost_text,
					native_menu = false,
				},
			}
		end,
	},
}
