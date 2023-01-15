return {
	-- the colorscheme should be available when starting Neovim
	{
		"nvim-lua/plenary.nvim",
		commit = "4b7e52044bbb84242158d977a50c4cbcd85070c7",
		event = "BufWinEnter",
		module = "plenary",
	},
	{
		"folke/tokyonight.nvim",
		commit = "66bfc2e8f754869c7b651f3f47a2ee56ae557764",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
	},
	{
		"goolord/alpha-nvim",
		commit = "0bb6fc0646bcd1cdb4639737a1cee8d6e08bcc31",
		module = "alpha",
		event = "BufWinEnter",
		config = function()
			require("user.alpha")
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		commit = "a52f078026b27694d2290e34efa61a6e4a690621",
		require = { "kyazdani42/nvim-web-devicons", opt = true },
		event = "BufWinEnter",
		opts = function()
			require("user.lualine")
		end,
	},
	{ "rafamadriz/friendly-snippets" },
	{
		"hrsh7th/nvim-cmp",
		dependencies = "rafamadriz/friendly-snippets",
		opts = function()
			require("user.cmp")
		end,
	},
	{
		"windwp/nvim-autopairs",
		commit = "4fc96c8f3df89b6d23e5092d31c866c53a346347",
		dependencies = "hrsh7th/nvim-cmp",
		event = "VeryLazy",
		init = function()
			require("user.autopairs")
		end,
	},
	{
		"numToStr/Comment.nvim",
		commit = "97a188a98b5a3a6f9b1b850799ac078faa17ab67",
		event = "InsertEnter",
		init = function()
			require("user.comment")
		end,
	},
	-- include treesitter
	-- require("plugins.treesitter"),
	{
		"nvim-treesitter/nvim-treesitter",
		commit = "8e763332b7bf7b3a426fd8707b7f5aa85823a5ac",
		run = ":TSUpdate",
		event = "BufWinEnter",
		opts = function()
			require("user.treesitter")
		end,
	},
	{
		"kyazdani42/nvim-web-devicons",
		commit = "563f3635c2d8a7be7933b9e547f7c178ba0d4352",
		init = function()
			require("user.webdevicons")
		end,
	},
	{
		"kyazdani42/nvim-tree.lua",
		commit = "7282f7de8aedf861fe0162a559fc2b214383c51c",
		cmd = "NvimTreeToggle",
		dependencies = "kyazdani42/nvim-web-devicons",
		init = function()
			require("user.nvim-tree")
		end,
	},
	{
		"akinsho/bufferline.nvim",
		commit = "83bf4dc7bff642e145c8b4547aa596803a8b4dc4",
		dependencies = { "kyazdani42/nvim-web-devicons", "famiu/bufdelete.nvim" },
		event = "VeryLazy",
		-- config = function()
		-- 	require("user.bufferline")
		-- end,
	},
	{ "moll/vim-bbye", commit = "25ef93ac5a87526111f43e5110675032dbcacf56" },
	{
		"akinsho/toggleterm.nvim",
		commit = "2a787c426ef00cb3488c11b14f5dcf892bbd0bda",
		cmd = "Toggleterm",
		event = "BufWinEnter",
		init = function()
			require("user.toggleterm")
		end,
	},
	{ "ahmedkhalf/project.nvim", commit = "628de7e433dd503e782831fe150bb750e56e55d6" },
	{
		"lewis6991/impatient.nvim",
		commit = "b842e16ecc1a700f62adb9802f8355b99b52a5a6",
		init = function()
			require("user.impatient")
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		commit = "db7cbcb40cc00fc5d6074d7569fb37197705e7f6",
		event = "BufRead",
		init = function()
			require("user.indentline")
		end,
	},
	{
		"folke/which-key.nvim",
		event = "BufWinEnter",
		init = function()
			require("user.whichkey")
		end,
	},
	-- start programming
	{ "hrsh7th/cmp-buffer", commit = "3022dbc9166796b644a841a02de8dd1cc1d311fa", dependencies = "hrsh7th/nvim-cmp" },
	{ "hrsh7th/cmp-nvim-lua", commit = "d276254e7198ab7d00f117e88e223b4bd8c02d21", dependencies = "hrsh7th/nvim-cmp" },
	{
		"neovim/nvim-lspconfig",
		commit = "f11fdff7e8b5b415e5ef1837bdcdd37ea6764dda",
		event = "BufWinEnter",
		init = function()
			require("user.lsp")
		end,
	},
	{
		"williamboman/mason.nvim",
		commit = "c2002d7a6b5a72ba02388548cfaf420b864fbc12",
		cmd = {
			"Mason",
			"MasonInstall",
			"MasonUninstall",
			"MasonUninstallAll",
			"MasonLog",
		},
		dependencies = { "williamboman/mason-lspconfig.nvim" },
		init = function()
			vim.tbl_map(function(plugin)
				pcall(require, plugin)
			end, { "lspconfig", "null-ls" })
		end,
	},
	{ "jose-elias-alvarez/null-ls.nvim", commit = "c0c19f32b614b3921e17886c541c13a72748d450" },
	{ "RRethy/vim-illuminate", commit = "a2e8476af3f3e993bb0d6477438aad3096512e42" },
	-- include for coding
	require("plugins.coding"), -- extra plugins
	{
		"nvim-telescope/telescope.nvim",
		commit = "76ea9a898d3307244dce3573392dcf2cc38f340f",
		dependencies = { { "nvim-lua/plenary.nvim" } },
		cmd = "Telescope",
		init = function()
			require("user.telescope")
		end,
	},
	{ "manzeloth/live-server", cmd = { "LiveServer" } },
	{ "mg979/vim-visual-multi", event = "BufWinEnter" },
	{
		"windwp/nvim-ts-autotag",
		dependencies = "nvim-treesitter/nvim-treesitter",
		init = function()
			require("nvim-ts-autotag").setup()
		end,
	},
	{
		"CRAG666/code_runner.nvim",
		dependencies = "nvim-lua/plenary.nvim",
		cmd = { "RunCode", "RunFile", "RunProject", "RunClose" },
		config = function()
			require("user.coderunner")
		end,
	},
	{
		"NvChad/nvim-colorizer.lua",
		event = "VeryLazy",
		opts = function()
			require("user.colorizer")
		end,
	},
	{ "williamboman/nvim-lsp-installer" },
	{
		"SmiteshP/nvim-navic",
		dependencies = "neovim/nvim-lspconfig",
		event = "BufRead",
		config = function()
			require("user.breadcrumb")
			require("user.winbar")
		end,
	},
	{
		"rcarriga/nvim-notify",
		event = "BufRead",
		config = function()
			vim.notify = require("notify")
		end,
	},
	{
		"mrjones2014/smart-splits.nvim",
		event = "BufWinEnter",
		config = function()
			require("user.smartspit")
		end,
	},
	{
		"jayp0521/mason-null-ls.nvim",
		dependencies = "jose-elias-alvarez/null-ls.nvim",
		event = "BufRead",
		opts = function()
			require("user.mason-null-ls")
		end,
	},
	{
		"stevearc/dressing.nvim",
		event = "BufWinEnter",
		config = function()
			require("user.dressing")
		end,
	},
	{
		"folke/todo-comments.nvim",
		event = "BufRead",
		config = function()
			require("todo-comments").setup()
		end,
	},
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
	{
		"gbprod/yanky.nvim",
		event = "BufRead",
		config = function()
			require("user.yanky")
		end,
	},
	{ "dstein64/vim-startuptime", cmd = "StartupTime" },
	{ "p00f/nvim-ts-rainbow", event = "BufWinEnter", dependencies = "nvim-treesitter/nvim-treesitter" },
	{
		"lewis6991/gitsigns.nvim",
		commit = "2c6f96dda47e55fa07052ce2e2141e8367cbaaf2",
		disable = vim.fn.executable("git") == 0,
		ft = "gitcommit",
		event = "VeryLazy",
		config = function()
			require("user.gitsigns")
		end,
	},

	-- additional new plugins
	-- active indent guide and indent text objects
	{
		"echasnovski/mini.indentscope",
		version = false, -- wait till new 0.7.0 release to put it back on semver
		event = "BufReadPre",
		opts = {
			-- symbol = "▏",
			symbol = "│",
			options = { try_as_border = true },
		},
		config = function(_, opts)
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason" },
				callback = function()
					vim.b.miniindentscope_disable = true
				end,
			})
			require("mini.indentscope").setup(opts)
		end,
	},
	-- makes some plugins dot-repeatable like leap
	{ "tpope/vim-repeat", event = "VeryLazy" },
	-- better diagnostics list and others
	{
		"folke/trouble.nvim",
		cmd = { "TroubleToggle", "Trouble" },
		opts = { use_diagnostic_signs = true },
		keys = {
			{ "<leader>xx", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document Diagnostics (Trouble)" },
			{ "<leader>xX", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)" },
		},
	},
}
