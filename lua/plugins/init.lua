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
		lazy = true,
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load()
			require("user.snippets")
			require("user.snip")
		end,
	},
	{
		"L3MON4D3/LuaSnip",
		lazy = true,
		-- event = "InsertEnter",
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
      { "<tab>",   function() require("luasnip").jump(1) end,  mode = "s" },
      { "<s-tab>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
    },
	},
	{
		"neovim/nvim-lspconfig",
		lazy = true,
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
		-- event = "InsertEnter",
		dependencies = { "williamboman/mason-lspconfig.nvim" },
		cmd = {
			"Mason",
			"MasonInstall",
			"MasonUninstall",
			"MasonUninstallAll",
			"MasonLog",
		},
		-- keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
		config = function()
			require("user.lsp")
		end,
	},
	-- for formater linter
	{
		"RRethy/vim-illuminate",
		event = "BufRead",
		lazy = true,
		config = function()
			local status_ok, illuminate = pcall(require, "illuminate")
			if not status_ok then
				return
			end
			illuminate.configure({
				options = {
					-- providers: provider used to get references in the buffer, ordered by priority
					providers = {
						"lsp",
						"treesitter",
						"regex",
					},
					-- delay: delay in milliseconds
					delay = 120,
					-- filetype_overrides: filetype specific overrides.
					-- The keys are strings to represent the filetype while the values are tables that
					-- supports the same keys passed to .configure except for filetypes_denylist and filetypes_allowlist
					filetype_overrides = {},
					-- filetypes_denylist: filetypes to not illuminate, this overrides filetypes_allowlist
					filetypes_denylist = {
						"dirvish",
						"fugitive",
						"alpha",
						"NvimTree",
						"lazy",
						"neogitstatus",
						"Trouble",
						"lir",
						"Outline",
						"spectre_panel",
						"toggleterm",
						"DressingSelect",
						"TelescopePrompt",
					},
					-- filetypes_allowlist: filetypes to illuminate, this is overridden by filetypes_denylist
					filetypes_allowlist = {},
					-- modes_denylist: modes to not illuminate, this overrides modes_allowlist
					modes_denylist = {},
					-- modes_allowlist: modes to illuminate, this is overridden by modes_denylist
					modes_allowlist = {},
					-- providers_regex_syntax_denylist: syntax to not illuminate, this overrides providers_regex_syntax_allowlist
					-- Only applies to the 'regex' provider
					-- Use :echom synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
					providers_regex_syntax_denylist = {},
					-- providers_regex_syntax_allowlist: syntax to illuminate, this is overridden by providers_regex_syntax_denylist
					-- Only applies to the 'regex' provider
					-- Use :echom synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
					providers_regex_syntax_allowlist = {},
					-- under_cursor: whether or not to illuminate under the cursor
					under_cursor = true,
				},
			})
		end,
	},
	{
		"jayp0521/mason-null-ls.nvim",
		lazy = true,
		dependencies = {
			-- "jose-elias-alvarez/null-ls.nvim",
			"nvimtools/none-ls.nvim",
			dependencies = {
				"nvimtools/none-ls-extras.nvim",
				lazy = true,
			},
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
		lazy = true,
		event = "BufRead",
		dependencies = "mfussenegger/nvim-dap",
		enabled = vim.fn.has("win32") == 0,
		config = function()
			require("user.dapui")
		end,
	},
	{
		"jay-babu/mason-nvim-dap.nvim",
		lazy = true,
		event = "BufRead",
		dependencies = { "williamboman/mason.nvim", "mfussenegger/nvim-dap" },
		enabled = vim.fn.has("win32") == 0,
		config = function()
			require("user.mason_dap")
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
		-- event = "BufWinEnter",
		-- event = "InsertEnter",
		dependencies = "nvim-treesitter/nvim-treesitter",
		config = function()
			require("ts_context_commentstring").setup({
				enable_autocmd = false,
			})
		end,
	},
	{
		"numToStr/Comment.nvim",
		-- event = "BufWinEnter",
		-- event = "InsertEnter",
		lazy = true,
		config = function()
			require("user.comment")
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		-- event = "BufWinEnter",
		version = "3.5.4",
		event = { "BufRead", "InsertEnter", "BufNewFile" },
		lazy = true,
		opts = {
			indent = {
				char = "│",
				tab_char = "│",
			},
			scope = { enabled = false },
			exclude = {
				buftypes = {
					"nofile",
					"prompt",
					"quickfix",
					"terminal",
				},
				filetypes = {
					"help",
					"alpha",
					"dashboard",
					"neo-tree",
					"Trouble",
					"trouble",
					"lazy",
					"mason",
					"notify",
					"toggleterm",
					"lazyterm",
					"NvimTree",
					"aerial",
					"neogitstatus",
					"startify",
				},
			},
		},
		main = "ibl",
	},
	-- styleing indent
	-- {
	-- 	"lukas-reineke/indent-blankline.nvim",
	-- 	event = "BufRead",
	-- 	config = function()
	-- 		require("user.indentline")
	-- 		-- require("ibl").setup()
	-- 	end,
	-- },
	-- for Speed up loading Lua modules in Neovim to improve startup time.
	-- {
	-- 	"lewis6991/impatient.nvim",
	-- 	event = "BufWinEnter",
	-- 	config = function()
	-- 		require("user.impatient")
	-- 	end,
	-- },
	-- for live server html,css,js
	-- {
	-- "manzeloth/live-server",
	-- cmd = { "LiveServer" },
	-- event = "BufRead",
	-- build = "npm install -g live-server",
	-- },
	-- for multi cursor select
	{
		"mg979/vim-visual-multi",
		event = { "BufRead", "InsertEnter", "BufNewFile" },
		lazy = true,
		init = function()
			vim.g.VM_mouse_mappings = 1 -- equal CTRL + Left Click on VSCODE
			vim.g.VM_maps = {
				["Find Under"] = "<C-d>", -- equal CTRL+D on VSCODE
				["Find Subword Under"] = "<C-d>", -- equal CTRL+D on VSCODE
				["Select Cursor Down"] = "<M-C-Down>", -- equal CTRL+ALT+DOWN on VSCODE
				["Select Cursor Up"] = "<M-C-Up>", -- equal CTRL+ALT+UP on VSCODE
			}
		end,
	},
	-- for auto close tag
	{
		"windwp/nvim-ts-autotag",
		-- event = "BufWinEnter",
		lazy = true,
		event = "BufRead",
		dependencies = "nvim-treesitter/nvim-treesitter",
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},
	-- for auto detection file and run code
	{
		"CRAG666/code_runner.nvim",
		lazy = true,
		-- event = "InsertEnter",
		-- dependencies = "nvim-lua/plenary.nvim",
		cmd = { "RunCode", "RunFile", "RunProject", "RunClose" },
		config = function()
			require("user.coderunner")
		end,
	},
	-- for color view
	{
		"NvChad/nvim-colorizer.lua",
		lazy = true,
		-- event = "BufWinEnter",
		event = { "BufRead", "InsertEnter", "BufNewFile" },
		-- opts = function()
		-- 	require("user.colorizer")
		-- end,
		opts = {
			user_default_options = {
				RGB = true, -- #RGB hex codes
				RRGGBB = true, -- #RRGGBB hex codes
				names = true, -- "Name" codes like Blue
				RRGGBBAA = true, -- #RRGGBBAA hex codes
				rgb_fn = true, -- CSS rgb() and rgba() functions
				hsl_fn = true, -- CSS hsl() and hsla() functions
				css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
				css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
				-- Available modes: foreground, background
				mode = "background", -- Set the display mode.
				tailwind = true,
			},
			filetypes = {
				"*", -- Highlight all files, but customize some others.
				css = { rgb_fn = true }, -- Enable parsing rgb(...) functions in css.
				html = { names = false }, -- Disable parsing "names" like Blue or Gray
			},
		},
	},
	-- for winbar icon
	{
		"SmiteshP/nvim-navic",
		lazy = true,
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
		lazy = true,
		-- event = "BufWinEnter",
		event = "VeryLazy",
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
		lazy = true,
		event = { "BufRead", "InsertEnter", "BufNewFile" },
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
		config = function()
			require("user.dressing")
		end,
	}, -- mini scrollview
	{
		"dstein64/nvim-scrollview",
		lazy = true,
		-- event = "BufWinEnter",
		event = { "BufRead", "InsertEnter", "BufNewFile" },
		config = function()
			require("user.nvimscroll")
		end,
	},
	-- for check startuptime
	{ "dstein64/vim-startuptime", lazy = true, cmd = "StartupTime" },
	-- for coloring pairs
	-- remark 20231101 - menyebabkan error treesitter
	-- {
	-- 	"p00f/nvim-ts-rainbow",
	-- 	event = "BufRead",
	-- 	dependencies = "nvim-treesitter/nvim-treesitter",
	-- },
	-- for git
	-- {
	-- 	"HiPhish/nvim-ts-rainbow2",
	-- 	lazy = true,
	-- 	event = "BufRead",
	-- 	dependencies = "nvim-treesitter/nvim-treesitter",
	-- },
	{
		"lewis6991/gitsigns.nvim",
		lazy = true,
		enabled = vim.fn.executable("git") == 1,
		ft = "gitcommit",
		-- event = "BufWinEnter",
		event = "BufRead",
		config = function()
			require("user.gitsigns")
		end,
	},
	-- remove duplicate
	-- { "tpope/vim-repeat", event = "InsertEnter" },
}
