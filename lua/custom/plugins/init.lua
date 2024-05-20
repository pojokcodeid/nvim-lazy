local icons = require("user.icons")
return {
	--- masukan plugin tambahan disini
	-- {
	-- 	"folke/trouble.nvim",
	-- 	event = "BufRead",
	-- 	cmd = { "TroubleToggle", "Trouble" },
	-- 	opts = { use_diagnostic_signs = true },
	-- 	keys = {
	-- 		{
	-- 			"<leader>xx",
	-- 			"<cmd>TroubleToggle document_diagnostics<cr>",
	-- 			desc = "Document Diagnostics (Trouble)",
	-- 		},
	-- 		{
	-- 			"<leader>xX",
	-- 			"<cmd>TroubleToggle workspace_diagnostics<cr>",
	-- 			desc = "Workspace Diagnostics (Trouble)",
	-- 		},
	-- 	},
	-- },
	{
		"echasnovski/mini.indentscope",
		version = false, -- wait till new 0.7.0 release to put it back on semver
		event = "BufReadPre",
		opts = {
			-- symbol = "▏",
			-- symbol = "│",
			symbol = icons.ui.LineMiddle,
			options = { try_as_border = true },
		},
		config = function(_, opts)
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "help", "alpha", "dashboard", "NvimTree", "Trouble", "lazy", "mason" },
				callback = function()
					vim.b.miniindentscope_disable = true
				end,
			})
			require("mini.indentscope").setup(opts)
		end,
	},
	{
		"hrsh7th/cmp-nvim-lua",
		enabled = false,
	},
	-- {
	-- 	"gbprod/yanky.nvim",
	-- 	event = "BufReadPre",
	-- 	config = function()
	-- 		require("user.yanky")
	-- 	end,
	-- },
	-- {
	-- 	"is0n/jaq-nvim",
	-- 	event = "BufRead",
	-- 	config = function()
	-- 		require("user.jaq")
	-- 	end,
	-- },
	-- better todo coloring and icon
	-- {
	-- 	"folke/todo-comments.nvim",
	-- 	event = { "BufReadPost", "BufNewFile" },
	-- 	config = function()
	-- 		require("todo-comments").setup()
	-- 	end,
	-- },
	-- mini scrollview
	-- {
	-- 	"karb94/neoscroll.nvim",
	-- 	event = "BufRead",
	-- 	config = function()
	-- 		require("user.neoscroll")
	-- 	end,
	-- },

	-- { "ahmedkhalf/project.nvim", commit = "628de7e433dd503e782831fe150bb750e56e55d6", event = "VeryLazy" },	  --
	-- additional plugins
	-- makes some plugins dot-repeatable like leap
	-- { "tpope/vim-repeat", event = "VeryLazy" },
	-- better diagnostics list and others
	-- for markdown preview
	-- make sure already install npm and yarn
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
	-- --
	-- {
	-- 	"barrett-ruth/live-server.nvim",
	-- 	build = "yarn global add live-server",
	-- 	config = true,
	-- 	init = function()
	-- 		require("live-server").setup({
	-- 			-- Arguments passed to live-server via `vim.fn.jobstart()`
	-- 			-- Run `live-server --help` to see list of available options
	-- 			-- For example, to use port 7000 and browser firefox:
	-- 			args = { "--port=7000", "--browser=firefox" },
	-- 			--args = {},
	-- 		})
	-- 	end,
	-- },
	-- for install lsp tidak support mason
	-- {
	-- 	"williamboman/nvim-lsp-installer",
	-- 	event = "BufRead",
	-- 	lazy = true,
	-- 	config = function()
	-- 		require("user.lsp.config")
	-- 	end,
	-- },
}
