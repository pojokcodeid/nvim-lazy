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
		lazy = true,
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
		"rafamadriz/friendly-snippets",
		event = "InsertEnter",
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load()
			require("user.snippets")
			require("user.snip")
		end,
	},
	{
		"L3MON4D3/LuaSnip",
		lazy = true,
		event = "InsertEnter",
		-- dependencies = {
		-- 	"rafamadriz/friendly-snippets",
		-- 	event = "BufRead",
		-- 	config = function()
		-- 		require("luasnip.loaders.from_vscode").lazy_load()
		-- 		require("user.snippets")
		-- 	end,
		-- },
		opts = {
			history = true,
			delete_check_events = "TextChanged",
		},
      -- stylua: ignore
      keys = {
        -- {
        --   "<tab>",
        --   function()
        --     return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
        --   end,
        --   expr = true, silent = true, mode = "i",
        -- },
        { "<tab>", function() require("luasnip").jump(1) end, mode = "s" },
        { "<s-tab>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
      },
	},
	{
		"neovim/nvim-lspconfig",
		event = "BufRead",
		-- dependencies = {
		-- 	"williamboman/mason-lspconfig.nvim",
		-- },
		-- config = function()
		-- 	require("user.lsp")
		-- end,
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
		lazy = true,
		event = "InsertEnter",
		dependencies = { "williamboman/mason-lspconfig.nvim" },
		cmd = {
			"Mason",
			"MasonInstall",
			"MasonUninstall",
			"MasonUninstallAll",
			"MasonLog",
		},
		keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
		config = function()
			require("user.lsp")
		end,
	},
	-- for formater linter
	{ "RRethy/vim-illuminate", event = "BufRead", lazy = true },
	{
		"jayp0521/mason-null-ls.nvim",
		-- lazy = true,
		dependencies = {
			"jose-elias-alvarez/null-ls.nvim",
			config = function()
				require("user.lsp.null-ls")
			end,
		},
		event = "InsertEnter",
		opts = function()
			require("user.mason-null-ls")
		end,
	},
	-- debuging
	{
		"rcarriga/nvim-dap-ui",
		event = "BufRead",
		dependencies = "mfussenegger/nvim-dap",
		enabled = vim.fn.has("win32") == 0,
		config = function()
			require("user.dapui")
		end,
	},
	{
		"jay-babu/mason-nvim-dap.nvim",
		event = "BufRead",
		dependencies = { "williamboman/mason.nvim", "mfussenegger/nvim-dap" },
		enabled = vim.fn.has("win32") == 0,
		config = function()
			require("user.mason_dap")
		end,
	},
	-- for install lsp tidak support mason
	{
		"williamboman/nvim-lsp-installer",
		event = "BufRead",
		lazy = true,
		config = function()
			require("user.lsp.config")
		end,
	},
	-- auto pairs
	{
		"windwp/nvim-autopairs",
		lazy = true,
		-- commit = "4fc96c8f3df89b6d23e5092d31c866c53a346347",
		dependencies = "hrsh7th/nvim-cmp",
		event = "InsertEnter",
		config = function()
			require("user.autopairs")
		end,
	},
	-- untuk comment
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		lazy = true,
		event = "InsertEnter",
		dependencies = "nvim-treesitter/nvim-treesitter",
	},
	{
		"numToStr/Comment.nvim",
		event = "InsertEnter",
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
	-- {
	-- "manzeloth/live-server",
	-- cmd = { "LiveServer" },
	-- event = "BufRead",
	-- build = "npm install -g live-server",
	-- },
	-- for multi cursor select
	{ "mg979/vim-visual-multi", event = "InsertEnter" },
	-- for auto close tag
	{
		"windwp/nvim-ts-autotag",
		event = "InsertEnter",
		dependencies = "nvim-treesitter/nvim-treesitter",
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},
	-- for auto detection file and run code
	{
		"CRAG666/code_runner.nvim",
		event = "InsertEnter",
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
		event = "InsertEnter",
		config = function()
			require("user.breadcrumb")
			require("user.winbar")
		end,
	},
	-- for popup alert
	{
		"rcarriga/nvim-notify",
		event = "BufRead",
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
	},
	-- for resize screen
	{
		"mrjones2014/smart-splits.nvim",
		event = "BufRead",
		config = function()
			require("user.smartspit")
		end,
	},
	-- for popup input
	{
		"stevearc/dressing.nvim",
		lazy = true,
		init = function()
			---@diagnostic disable-next-line: duplicate-set-field
			vim.ui.select = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return vim.ui.select(...)
			end
			---@diagnostic disable-next-line: duplicate-set-field
			vim.ui.input = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return vim.ui.input(...)
			end
		end,
	}, -- mini scrollview
	{
		"karb94/neoscroll.nvim",
		event = "InsertEnter",
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
	{ "dstein64/vim-startuptime", cmd = "StartupTime", event = "InsertEnter" },
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
	-- remove duplicate
	{ "tpope/vim-repeat", event = "InsertEnter" },
}
