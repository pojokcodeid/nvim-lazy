return {
	{
		"nvim-lua/plenary.nvim",
		-- commit = "4b7e52044bbb84242158d977a50c4cbcd85070c7",
		event = "BufWinEnter",
		module = "plenary",
	},
	-- color scheme
	{
		"folke/tokyonight.nvim",
		-- commit = "66bfc2e8f754869c7b651f3f47a2ee56ae557764",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			local is_transparant = false
			if is_transparant then
				require("user.tokyonight_transparant")
			else
				require("user.tokyonight")
			end
		end,
	},
	{ "luisiacc/gruvbox-baby", lazy = true },
	-- {
	-- 	"navarasu/onedark.nvim",
	-- 	init = function()
	-- 		require("user.onedark")
	-- 		require("onedark").load()
	-- 	end,
	-- },
	-- { "lunarvim/lunar.nvim" },
	-- { "arcticicestudio/nord-vim" },
	-- {
	-- 	"catppuccin/nvim",
	-- 	name = "catppuccin",
	-- 	init = function()
	-- 		require("user.catppuccin")
	-- 	end,
	-- },
	-- {
	-- 	"ellisonleao/gruvbox.nvim",
	-- 	init = function()
	-- 		require("gruvbox").setup({
	-- 			undercurl = true,
	-- 			underline = true,
	-- 			bold = true,
	-- 			italic = true,
	-- 			strikethrough = true,
	-- 			invert_selection = false,
	-- 			invert_signs = false,
	-- 			invert_tabline = false,
	-- 			invert_intend_guides = false,
	-- 			inverse = true, -- invert background for search, diffs, statuslines and errors
	-- 			contrast = "", -- can be "hard", "soft" or empty string
	-- 			palette_overrides = {},
	-- 			overrides = {},
	-- 			dim_inactive = false,
	-- 			transparent_mode = false,
	-- 		})
	-- 		vim.o.background = "dark" -- or "light" for light mode
	-- 	end,
	-- },
	-- { "sainnhe/sonokai" },
	-- { "EdenEast/nightfox.nvim" },
	-- {
	-- 	"marko-cerovac/material.nvim",
	-- 	init = function()
	-- 		vim.g.material_style = "darker"
	-- 	end,
	-- },

	-- include treesitter
	-- require("plugins.treesitter"),
	{
		"nvim-treesitter/nvim-treesitter",
		-- commit = "8e763332b7bf7b3a426fd8707b7f5aa85823a5ac",
		run = ":TSUpdate",
		event = "BufWinEnter",
		opts = function()
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

	-- auto completion
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"saadparwaiz1/cmp_luasnip",
		},
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
		--commit = "97a188a98b5a3a6f9b1b850799ac078faa17ab67",
		event = "InsertEnter",
		init = function()
			require("user.comment")
		end,
	},
	-- styleing indent
	{
		"lukas-reineke/indent-blankline.nvim",
		-- commit = "db7cbcb40cc00fc5d6074d7569fb37197705e7f6",
		event = "BufRead",
		init = function()
			require("user.indentline")
		end,
	},
	{
		"hrsh7th/cmp-buffer",
		event = "VeryLazy",
		-- commit = "3022dbc9166796b644a841a02de8dd1cc1d311fa",
		dependencies = "hrsh7th/nvim-cmp",
	},
	{
		"hrsh7th/cmp-nvim-lua",
		event = "VeryLazy",
		-- commit = "d276254e7198ab7d00f117e88e223b4bd8c02d21",
		dependencies = "hrsh7th/nvim-cmp",
	},
	{
		"neovim/nvim-lspconfig",
		-- commit = "f11fdff7e8b5b415e5ef1837bdcdd37ea6764dda",
		event = "BufWinEnter",
		config = function()
			require("user.lsp")
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = true,
	},
	{
		"williamboman/mason.nvim",
		-- commit = "c2002d7a6b5a72ba02388548cfaf420b864fbc12",
		event = "VeryLazy",
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
	-- for formater linter
	{
		"jose-elias-alvarez/null-ls.nvim",
		-- commit = "c0c19f32b614b3921e17886c541c13a72748d450",
		event = "VeryLazy",
	},
	{
		"RRethy/vim-illuminate",
		-- commit = "a2e8476af3f3e993bb0d6477438aad3096512e42",
		event = "VeryLazy",
	},
	{
		"jayp0521/mason-null-ls.nvim",
		dependencies = "jose-elias-alvarez/null-ls.nvim",
		event = "BufRead",
		opts = function()
			require("user.mason-null-ls")
		end,
	},
	-- dashboard
	{
		"goolord/alpha-nvim",
		-- commit = "0bb6fc0646bcd1cdb4639737a1cee8d6e08bcc31",
		module = "alpha",
		event = "BufWinEnter",
		config = function()
			require("user.alpha")
		end,
	},
	-- line info bootom
	{
		"nvim-lualine/lualine.nvim",
		-- commit = "a52f078026b27694d2290e34efa61a6e4a690621",
		dependencies = { "kyazdani42/nvim-web-devicons", opt = true },
		event = "BufWinEnter",
		opts = function()
			local model = 2
			if model == 1 then
				require("user.lualine1")
			elseif model == 2 then
				require("user.lualine2")
			else
				require("user.lualine")
			end
		end,
	},
	-- for show icon
	{
		"kyazdani42/nvim-web-devicons",
		-- commit = "563f3635c2d8a7be7933b9e547f7c178ba0d4352",
		event = "VeryLazy",
		config = function()
			require("user.webdevicons")
		end,
	},
	-- for tree exploler
	{
		"kyazdani42/nvim-tree.lua",
		-- commit = "7282f7de8aedf861fe0162a559fc2b214383c51c",
		event = "BufWinEnter",
		cmd = "NvimTreeToggle",
		dependencies = "kyazdani42/nvim-web-devicons",
		init = function()
			require("user.nvim-tree")
		end,
	},
	-- for file tab
	{
		"akinsho/bufferline.nvim",
		-- commit = "83bf4dc7bff642e145c8b4547aa596803a8b4dc4",
		dependencies = { "kyazdani42/nvim-web-devicons", "famiu/bufdelete.nvim" },
		event = "VeryLazy",
		-- config = function()
		-- 	require("user.bufferline")
		-- end,
	},
	{
		"moll/vim-bbye",
		-- commit = "25ef93ac5a87526111f43e5110675032dbcacf56",
		event = "VeryLazy",
	},
	-- for view terminal
	{
		"akinsho/toggleterm.nvim",
		--commit = "2a787c426ef00cb3488c11b14f5dcf892bbd0bda",
		cmd = "Toggleterm",
		event = "BufWinEnter",
		init = function()
			require("user.toggleterm")
		end,
	},
	{
		"ahmedkhalf/project.nvim",
		-- commit = "628de7e433dd503e782831fe150bb750e56e55d6",
		event = "VeryLazy",
	},
	{
		"lewis6991/impatient.nvim",
		-- commit = "b842e16ecc1a700f62adb9802f8355b99b52a5a6",
		event = "BufRead",
		init = function()
			require("user.impatient")
		end,
	},
	-- key mapping
	{
		"folke/which-key.nvim",
		event = "BufWinEnter",
		init = function()
			require("user.whichkey")
		end,
	},
	-- include for coding
	-- require("plugins.coding"),
	-- extra plugins
	-- for search
	{
		"nvim-telescope/telescope.nvim",
		event = "VeryLazy",
		-- commit = "76ea9a898d3307244dce3573392dcf2cc38f340f",
		dependencies = { { "nvim-lua/plenary.nvim" } },
		cmd = "Telescope",
		init = function()
			require("user.telescope")
		end,
	},
	-- for live server html,css,js
	{ "manzeloth/live-server", cmd = { "LiveServer" }, event = "VeryLazy" },
	-- for multi cursor select
	{ "mg979/vim-visual-multi", event = "BufWinEnter" },
	-- for auto close tag
	{
		"windwp/nvim-ts-autotag",
		event = "VeryLazy",
		dependencies = "nvim-treesitter/nvim-treesitter",
		init = function()
			require("nvim-ts-autotag").setup()
		end,
	},
	-- for auto detection file and run code
	{
		"CRAG666/code_runner.nvim",
		event = "VeryLazy",
		dependencies = "nvim-lua/plenary.nvim",
		cmd = { "RunCode", "RunFile", "RunProject", "RunClose" },
		config = function()
			require("user.coderunner")
		end,
	},
	{
		"is0n/jaq-nvim",
		event = "CursorHold",
		config = function()
			require("user.jaq")
		end,
	},
	-- for color view
	{
		"NvChad/nvim-colorizer.lua",
		event = "VeryLazy",
		opts = function()
			require("user.colorizer")
		end,
	},
	-- for install only java support windows
	{ "williamboman/nvim-lsp-installer", event = "VeryLazy" },
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
		event = "BufRead",
		config = function()
			-- vim.notify = require("notify")  -- ini jika tidak transparant
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
	-- better todo coloring and icon
	{
		"folke/todo-comments.nvim",
		event = "BufRead",
		config = function()
			require("todo-comments").setup()
		end,
	},
	-- mini scrollview
	{
		"karb94/neoscroll.nvim",
		event = "WinScrolled",
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
	-- auto complite commond mode
	{
		"gelguy/wilder.nvim",
		event = "BufWinEnter",
		config = function()
			local wilder = require("wilder")
			wilder.setup({ modes = { ":", "/", "?" } })
			-- *ini popup biasa
			-- wilder.set_option(
			-- 	"renderer",
			-- 	wilder.popupmenu_renderer({
			-- 		highlighter = wilder.basic_highlighter(),
			-- 		left = { " ", wilder.popupmenu_devicons() },
			-- 		right = { " ", wilder.popupmenu_scrollbar() },
			-- 	})
			-- )

			-- *ini untuk border rounded
			wilder.set_option(
				"renderer",
				wilder.popupmenu_renderer(wilder.popupmenu_border_theme({
					highlights = {
						border = "Normal", -- highlight to use for the border
					},
					-- 'single', 'double', 'rounded' or 'solid'
					-- can also be a list of 8 characters, see :h wilder#popupmenu_border_theme() for more details
					border = "rounded",
					left = { " ", wilder.popupmenu_devicons() },
					right = { " ", wilder.popupmenu_scrollbar() },
				}))
			)

			-- *ini untuk popup dialog
			-- wilder.set_option(
			-- 	"renderer",
			-- 	wilder.popupmenu_renderer(wilder.popupmenu_palette_theme({
			-- 		-- 'single', 'double', 'rounded' or 'solid'
			-- 		-- can also be a list of 8 characters, see :h wilder#popupmenu_palette_theme() for more details
			-- 		border = "rounded",
			-- 		max_height = "40%", -- max height of the palette
			-- 		max_width = "40%",
			-- 		min_height = 0, -- set to the same as 'max_height' for a fixed height window
			-- 		prompt_position = "top", -- 'top' or 'bottom' to set the location of the prompt
			-- 		reverse = 0, -- set to 1 to reverse the order of the list, use in combination with 'prompt_position'
			-- 		left = { " ", wilder.popupmenu_devicons() },
			-- 		right = { " ", wilder.popupmenu_scrollbar() },
			-- 		pumblend = 20,
			-- 	}))
			-- )
		end,
	},
	-- for manage and coloring copy
	{
		"gbprod/yanky.nvim",
		event = "BufRead",
		config = function()
			require("user.yanky")
		end,
	},
	-- for check startuptime
	{ "dstein64/vim-startuptime", cmd = "StartupTime", event = "VeryLazy" },
	-- for coloring pairs
	{ "p00f/nvim-ts-rainbow", event = "BufWinEnter", dependencies = "nvim-treesitter/nvim-treesitter" },
	{
		"lewis6991/gitsigns.nvim",
		-- commit = "2c6f96dda47e55fa07052ce2e2141e8367cbaaf2",
		enabled = vim.fn.executable("git") == 1,
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
		event = "VeryLazy",
		cmd = { "TroubleToggle", "Trouble" },
		opts = { use_diagnostic_signs = true },
		keys = {
			{ "<leader>xx", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document Diagnostics (Trouble)" },
			{ "<leader>xX", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)" },
		},
	},
	-- for markdown preview
	-- -- make sure already install npm and yarn
	-- {
	-- 	"iamcco/markdown-preview.nvim",
	-- 	event = "VeryLazy",
	-- 	build = "cd app && npm install",
	-- 	init = function()
	-- 		vim.g.mkdp_filetypes = { "markdown" }
	-- 	end,
	-- 	ft = { "markdown" },
	-- 	cmd = { "MarkdownPreview", "MarkdownPreviewStop", "MarkdownPreviewToggle" },
	-- },
	-- debuging
	{
		"mfussenegger/nvim-dap",
		event = "VeryLazy",
		enabled = vim.fn.has("win32") == 0,
	},
	{
		"rcarriga/nvim-dap-ui",
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
	-- for codeGPT
	-- {
	-- 	"jackMort/ChatGPT.nvim",
	-- 	dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
	-- 	lazy = true,
	-- 	event = "VeryLazy",
	-- 	-- opts = function()
	-- 	-- 	require("user.chat_gpt")
	-- 	-- end,
	-- },
	-- indent detection
	-- {
	-- 	"Darazaki/indent-o-matic",
	-- 	event = "VeryLazy",
	-- 	opt = true,
	-- 	cmd = { "IndentOMatic" },
	-- 	config = function()
	-- 		require("user.indent-o-matic")
	-- 	end,
	-- },
	-- Lsp Saga
	-- {
	-- 	"glepnir/lspsaga.nvim",
	-- 	event = "BufRead",
	-- 	config = function()
	-- 		require("lspsaga").setup({})
	-- 	end,
	-- 	dependencies = { { "kyazdani42/nvim-web-devicons" } },
	-- 	init = function()
	-- 		require("user.lspsaga_config")
	-- 	end,
	-- },
	-- Khusus Projek laravel baru di buka
	-- {
	-- 	"adalessa/laravel.nvim",
	-- 	dependencies = {
	-- 		"nvim-telescope/telescope.nvim",
	-- 	},
	-- 	cmd = { "Sail", "Artisan", "Composer" },
	-- 	keys = {
	-- 		{ "<leader>pa", ":Artisan<cr>" },
	-- 	},
	-- 	config = function()
	-- 		require("laravel").setup()
	-- 		require("telescope").load_extension("laravel")
	-- 	end,
	-- },
	-- {
	-- 	"j-hui/fidget.nvim",
	-- 	event = "VeryLazy",
	-- 	config = function()
	-- 		require("fidget").setup()
	-- 	end,
	-- },
}
