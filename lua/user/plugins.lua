local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- Install your plugins here
return packer.startup(function(use)
	use({
		"wbthomason/packer.nvim",
		commit = "6afb67460283f0e990d35d229fd38fdc04063e0a",
		-- config = function()
		-- 	require("user.plugins")
		-- end,
	}) -- Have packer manage itself
	use({
		"nvim-lua/plenary.nvim",
		commit = "4b7e52044bbb84242158d977a50c4cbcd85070c7",
		event = "BufWinEnter",
		module = "plenary",
	}) -- Useful lua functions used by lots of plugins
	use({
		"windwp/nvim-autopairs",
		commit = "4fc96c8f3df89b6d23e5092d31c866c53a346347",
		after = "nvim-cmp",
		config = function()
			require("user.autopairs")
		end,
	}) -- Autopairs, integrates with both cmp and treesitter
	use({
		"numToStr/Comment.nvim",
		commit = "97a188a98b5a3a6f9b1b850799ac078faa17ab67",
		event = "BufReadPost",
		config = function()
			require("user.comment")
		end,
	})
	use({
		"JoosepAlviste/nvim-ts-context-commentstring",
		commit = "4d3a68c41a53add8804f471fcc49bb398fe8de08",
		event = "BufReadPost",
		after = "nvim-treesitter",
	})
	use({
		"kyazdani42/nvim-web-devicons",
		commit = "563f3635c2d8a7be7933b9e547f7c178ba0d4352",
		module = "nvim-web-devicons",
		config = function()
			require("user.webdevicons")
		end,
	})
	use({
		"kyazdani42/nvim-tree.lua",
		commit = "7282f7de8aedf861fe0162a559fc2b214383c51c",
		-- ini dirimak karena jadi tab tidak kebuka full
		-- on = { "NvimTreeToggle" },
		-- cmd = "NvimTreeToggle",
		require = "kyazdani42/nvim-web-devicons",
		config = function()
			require("user.nvim-tree")
		end,
	})
	use({
		"akinsho/bufferline.nvim",
		commit = "83bf4dc7bff642e145c8b4547aa596803a8b4dc4",
		require = "kyazdani42/nvim-web-devicons",
		event = "BufWinEnter",
		config = function()
			require("user.bufferline")
		end,
	})
	use({ "moll/vim-bbye", commit = "25ef93ac5a87526111f43e5110675032dbcacf56" })
	use({
		"nvim-lualine/lualine.nvim",
		commit = "a52f078026b27694d2290e34efa61a6e4a690621",
		require = { "kyazdani42/nvim-web-devicons", opt = true },
		event = "BufWinEnter",
		config = function()
			require("user.lualine")
		end,
	})
	use({
		"akinsho/toggleterm.nvim",
		commit = "2a787c426ef00cb3488c11b14f5dcf892bbd0bda",
		module = "toggleterm",
		cmd = "Toggleterm",
		event = "BufWinEnter",
		config = function()
			require("user.toggleterm")
		end,
	})
	use({ "ahmedkhalf/project.nvim", commit = "628de7e433dd503e782831fe150bb750e56e55d6" })
	use({
		"lewis6991/impatient.nvim",
		commit = "b842e16ecc1a700f62adb9802f8355b99b52a5a6",
		config = function()
			require("user.impatient")
		end,
	})
	use({
		"lukas-reineke/indent-blankline.nvim",
		commit = "db7cbcb40cc00fc5d6074d7569fb37197705e7f6",
		event = "BufRead",
		config = function()
			require("user.indentline")
		end,
	})
	use({
		"goolord/alpha-nvim",
		commit = "0bb6fc0646bcd1cdb4639737a1cee8d6e08bcc31",
		module = "alpha",
		event = "BufWinEnter",
		config = function()
			require("user.alpha")
		end,
	})
	use({
		"folke/which-key.nvim",
		event = "BufWinEnter",
		config = function()
			require("user.whichkey")
		end,
	})

	-- Colorschemes
	use({
		"folke/tokyonight.nvim",
		commit = "66bfc2e8f754869c7b651f3f47a2ee56ae557764",
		-- ini diremark karena tab diatas jadi tidak ada warnanya
		-- event = "BufWinEnter",
		config = function()
			require("user.tokyonight")
			-- require("user.colorscheme")
		end,
	})

	-- Cmp
	use({
		"hrsh7th/nvim-cmp",
		commit = "b0dff0ec4f2748626aae13f011d1a47071fe9abc",
		event = "BufWinEnter",
		config = function()
			require("user.cmp")
		end,
	}) -- The completion plugin
	use({ "hrsh7th/cmp-buffer", commit = "3022dbc9166796b644a841a02de8dd1cc1d311fa", after = "nvim-cmp" }) -- buffer completions
	use({ "hrsh7th/cmp-path", commit = "447c87cdd6e6d6a1d2488b1d43108bfa217f56e1", after = "nvim-cmp" }) -- path completions
	use({ "saadparwaiz1/cmp_luasnip", commit = "a9de941bcbda508d0a45d28ae366bb3f08db2e36", after = "nvim-cmp" }) -- snippet completions
	use({
		"hrsh7th/cmp-nvim-lsp",
		commit = "3cf38d9c957e95c397b66f91967758b31be4abe6",
		after = "nvim-cmp",
		event = "BufWinEnter",
	})
	use({ "hrsh7th/cmp-nvim-lua", commit = "d276254e7198ab7d00f117e88e223b4bd8c02d21", after = "nvim-cmp" })

	-- Snippets
	use({
		"L3MON4D3/LuaSnip",
		commit = "8f8d493e7836f2697df878ef9c128337cbf2bb84",
		module = "luasnip",
		wants = "friendly-snippets",
		config = function()
			require("user.snip")
		end,
	}) --snippet engine
	use({ "rafamadriz/friendly-snippets", commit = "2be79d8a9b03d4175ba6b3d14b082680de1b31b1", opt = true }) -- a bunch of snippets to use

	-- LSP
	use({
		"neovim/nvim-lspconfig",
		commit = "f11fdff7e8b5b415e5ef1837bdcdd37ea6764dda",
		module = "lspconfig",
		event = "BufWinEnter",
		config = function()
			require("user.lsp")
		end,
	}) -- enable LSP
	use({
		"williamboman/mason.nvim",
		commit = "c2002d7a6b5a72ba02388548cfaf420b864fbc12",
		module = "mason",
		cmd = {
			"Mason",
			"MasonInstall",
			"MasonUninstall",
			"MasonUninstallAll",
			"MasonLog",
		},
		config = function()
			vim.tbl_map(function(plugin)
				pcall(require, plugin)
			end, { "lspconfig", "null-ls" })
		end,
	}) -- simple to use language server installer
	use({ "williamboman/mason-lspconfig.nvim", commit = "0051870dd728f4988110a1b2d47f4a4510213e31" })
	use({ "jose-elias-alvarez/null-ls.nvim", commit = "c0c19f32b614b3921e17886c541c13a72748d450" }) -- for formatters and linters
	use({ "RRethy/vim-illuminate", commit = "a2e8476af3f3e993bb0d6477438aad3096512e42" })

	-- Telescope
	use({
		"nvim-telescope/telescope.nvim",
		commit = "76ea9a898d3307244dce3573392dcf2cc38f340f",
		require = { { "nvim-lua/plenary.nvim" } },
		cmd = "Telescope",
		config = function()
			require("user.telescope")
		end,
	})

	-- Treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		commit = "8e763332b7bf7b3a426fd8707b7f5aa85823a5ac",
		run = ":TSUpdate",
		event = "BufWinEnter",
		config = function()
			require("user.treesitter")
		end,
	})

	-- custom akn
	use({ "manzeloth/live-server" })
	use({ "mg979/vim-visual-multi", event = "BufWinEnter" })
	use({
		"windwp/nvim-ts-autotag",
		event = "InsertEnter",
		after = "nvim-treesitter",
		-- config dipindah ke treesitter config
		-- config = function()
		-- 	require("user.autotag")
		-- end,
	})
	use({
		"CRAG666/code_runner.nvim",
		requires = "nvim-lua/plenary.nvim",
		cmd = { "RunCode", "RunFile", "RunProject", "RunClose" },
		config = function()
			require("user.coderunner")
		end,
	})
	use({
		"NvChad/nvim-colorizer.lua",
		event = "BufWinEnter",
		config = function()
			require("user.colorizer")
		end,
	})
	use({ "williamboman/nvim-lsp-installer" })
	use({
		"SmiteshP/nvim-navic",
		requires = "neovim/nvim-lspconfig",
		event = "BufRead",
		config = function()
			require("user.breadcrumb")
			require("user.winbar")
		end,
	})
	use({
		"rcarriga/nvim-notify",
		module = "notify",
		event = "BufRead",
		config = function()
			vim.notify = require("notify")
		end,
	})
	use({
		"mrjones2014/smart-splits.nvim",
		event = "BufWinEnter",
		config = function()
			require("user.smartspit")
		end,
	})
	-- null-ls manager
	use({
		"jayp0521/mason-null-ls.nvim",
		after = "null-ls.nvim",
		event = "BufRead",
		config = function()
			require("user.mason-null-ls")
		end,
	})
	use({
		"stevearc/dressing.nvim",
		event = "BufWinEnter",
		config = function()
			require("user.dressing")
		end,
	})

	use({
		"folke/todo-comments.nvim",
		event = "BufRead",
		config = function()
			require("todo-comments").setup()
		end,
	})
	use({
		"karb94/neoscroll.nvim",
		event = "BufRead",
		config = function()
			require("user.neoscroll")
		end,
	})
	use({
		"dstein64/nvim-scrollview",
		event = "BufRead",
		config = function()
			require("user.nvimscroll")
		end,
	})
	use({
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
	})
	use({
		"gbprod/yanky.nvim",
		event = "BufRead",
		config = function()
			require("user.yanky")
		end,
	})
	use({ "dstein64/vim-startuptime" })
	use({ "p00f/nvim-ts-rainbow", event = "BufWinEnter", after = "nvim-treesitter" })

	-- ini plugins alternatif yang tidak digunakan lagi
	-- use({ "rebelot/kanagawa.nvim" })
	-- use({ "mfussenegger/nvim-jdtls" })
	-- use({ "ellisonleao/gruvbox.nvim" })
	-- use({ "EdenEast/nightfox.nvim" })
	-- use({ "morhetz/gruvbox" })

	-- Git
	use({
		"lewis6991/gitsigns.nvim",
		commit = "2c6f96dda47e55fa07052ce2e2141e8367cbaaf2",
		disable = vim.fn.executable("git") == 0,
		ft = "gitcommit",
		event = "BufWinEnter",
		config = function()
			require("user.gitsigns")
		end,
	})

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
