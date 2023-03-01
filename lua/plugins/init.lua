return {
	-- plugin ini merupakan penyedia library neovim lua
	{
		"nvim-lua/plenary.nvim",
		lazy = true,
	},
	-- coding start
	-- coloring code
	{
		"nvim-treesitter/nvim-treesitter",
		event = "BufRead",
		cmd = {
			"TSBufDisable",
			"TSBufEnable",
			"TSBufToggle",
			"TSDisable",
			"TSEnable",
			"TSToggle",
			"TSInstall",
			"TSInstallInfo",
			"TSInstallSync",
			"TSModuleInfo",
			"TSUninstall",
			"TSUpdate",
			"TSUpdateSync",
		},
		build = function()
			local status_ok, ts = pcall(require, "nvim-treesitter.install")
			if not status_ok then
				return
			end
			ts.update({ with_sync = true })()
		end,
		config = function()
			local status_ok, _ = pcall(require, "nvim-treesitter")
			if not status_ok then
				return
			end
			require("user.treesitter")
		end,
	},
	-- snippets
	{
		"L3MON4D3/LuaSnip",
		dependencies = {
			"rafamadriz/friendly-snippets",
			config = function()
				require("luasnip.loaders.from_vscode").lazy_load()
				require("user.snippets")
			end,
		},
		opts = {
			history = true,
			delete_check_events = "TextChanged",
		},
      -- stylua: ignore
      keys = {
        {
          "<tab>",
          function()
            return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
          end,
          expr = true, silent = true, mode = "i",
        },
        { "<tab>", function() require("luasnip").jump(1) end, mode = "s" },
        { "<s-tab>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
      },
	},
	-- for cmp
	{
		"hrsh7th/nvim-cmp",
		version = false, -- last release is way too old
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lua",
			-- {
			-- 	"hrsh7th/cmp-cmdline",
			-- 	--event = "BufWinEnter",
			-- 	event = "VeryLazy",
			-- 	config = function()
			-- 		require("user.cmdline")
			-- 	end,
			-- },
		},
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
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "buffer" },
					{ name = "path" },
					{ name = "nvim_lua" },
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
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				experimental = {
					ghost_text = false,
					native_menu = false,
				},
			}
		end,
	},
	{
		"neovim/nvim-lspconfig",
		event = "BufWinEnter",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
		},
		config = function()
			require("user.lsp")
		end,
	},
	-- {
	-- 	"williamboman/mason.nvim",
	-- 	event = "VeryLazy",
	-- 	cmd = {
	-- 		"Mason",
	-- 		"MasonInstall",
	-- 		"MasonUninstall",
	-- 		"MasonUninstallAll",
	-- 		"MasonLog",
	-- 	},
	-- 	dependencies = { "williamboman/mason-lspconfig.nvim" },
	-- 	init = function()
	-- 		vim.tbl_map(function(plugin)
	-- 			pcall(require, plugin)
	-- 		end, { "lspconfig", "null-ls" })
	-- 	end,
	-- },
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
	},
	-- for formater linter
	{ "RRethy/vim-illuminate", event = "BufRead" },
	{
		"jayp0521/mason-null-ls.nvim",
		dependencies = "jose-elias-alvarez/null-ls.nvim",
		event = "BufRead",
		opts = function()
			require("user.mason-null-ls")
		end,
	},
	-- debuging
	{
		"rcarriga/nvim-dap-ui",
		event = "BufWinEnter",
		dependencies = "mfussenegger/nvim-dap",
		enabled = vim.fn.has("win32") == 0,
		config = function()
			require("user.dapui")
		end,
	},
	{
		"jayp0521/mason-nvim-dap.nvim",
		event = "VeryLazy",
		dependencies = { "williamboman/mason.nvim", "mfussenegger/nvim-dap" },
		enabled = vim.fn.has("win32") == 0,
		init = function()
			require("user.mason_dap")
		end,
	},
	-- for install lsp tidak support mason
	{ "williamboman/nvim-lsp-installer", event = "VeryLazy" },
	-- auto pairs
	{
		"windwp/nvim-autopairs",
		commit = "4fc96c8f3df89b6d23e5092d31c866c53a346347",
		dependencies = "hrsh7th/nvim-cmp",
		event = "InsertEnter",
		config = function()
			require("user.autopairs")
		end,
	},
	-- untuk comment
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		event = "BufRead",
		dependencies = "nvim-treesitter/nvim-treesitter",
	},
	{
		"numToStr/Comment.nvim",
		event = "BufRead",
		config = function()
			require("user.comment")
		end,
	},
	-- styleing indent
	{
		"lukas-reineke/indent-blankline.nvim",
		event = "BufRead",
		config = function()
			require("user.indentline")
		end,
	},
	-- for Speed up loading Lua modules in Neovim to improve startup time.
	{
		"lewis6991/impatient.nvim",
		event = "BufRead",
		config = function()
			require("user.impatient")
		end,
	},
	-- for live server html,css,js
	{
		"manzeloth/live-server",
		cmd = { "LiveServer" },
		event = "BufRead",
		build = "npm install -g live-server",
	},
	-- for multi cursor select
	{ "mg979/vim-visual-multi", event = "BufRead" },
	-- for auto close tag
	{
		"windwp/nvim-ts-autotag",
		event = "BufRead",
		dependencies = "nvim-treesitter/nvim-treesitter",
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},
	-- for auto detection file and run code
	{
		"CRAG666/code_runner.nvim",
		event = "BufRead",
		-- dependencies = "nvim-lua/plenary.nvim",
		cmd = { "RunCode", "RunFile", "RunProject", "RunClose" },
		config = function()
			require("user.coderunner")
		end,
	},
	-- for color view
	{
		"NvChad/nvim-colorizer.lua",
		event = "BufRead",
		opts = function()
			require("user.colorizer")
		end,
	},
	-- for winbar icon
	{
		"SmiteshP/nvim-navic",
		dependencies = "neovim/nvim-lspconfig",
		event = "BufRead",
		config = function()
			require("user.breadcrumb")
			require("user.winbar")
		end,
	},
	-- for popup alert
	{
		"rcarriga/nvim-notify",
		event = "BufWinEnter",
		config = function()
			local notify = require("notify")
			-- this for transparency
			notify.setup({ background_colour = "#000000" })
			-- this overwrites the vim notify function
			vim.notify = notify.notify
		end,
	},
	-- for resize screen
	{
		"mrjones2014/smart-splits.nvim",
		event = "BufWinEnter",
		config = function()
			require("user.smartspit")
		end,
	},
	-- for popup input
	{
		"stevearc/dressing.nvim",
		event = "BufWinEnter",
		config = function()
			require("user.dressing")
		end,
	},
	-- mini scrollview
	{
		"karb94/neoscroll.nvim",
		event = "BufRead",
		config = function()
			require("user.neoscroll")
		end,
	},
	{
		"dstein64/nvim-scrollview",
		event = "BufRead",
		config = function()
			require("user.nvimscroll")
		end,
	},
	-- for check startuptime
	{ "dstein64/vim-startuptime", cmd = "StartupTime", event = "BufRead" },
	-- for coloring pairs
	{
		"p00f/nvim-ts-rainbow",
		event = "BufRead",
		dependencies = "nvim-treesitter/nvim-treesitter",
	},
	-- for git
	{
		"lewis6991/gitsigns.nvim",
		enabled = vim.fn.executable("git") == 1,
		ft = "gitcommit",
		event = "BufRead",
		config = function()
			require("user.gitsigns")
		end,
	},
	-- for loading info
	{
		"j-hui/fidget.nvim",
		event = "BufRead",
		config = function()
			require("fidget").setup()
		end,
	},
}
