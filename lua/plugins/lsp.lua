return {
	{
		"neovim/nvim-lspconfig",
		lazy = true,
		event = "BufRead",
	},
	{
		"williamboman/mason.nvim",
		lazy = true,
		dependencies = { "williamboman/mason-lspconfig.nvim" },
		cmd = {
			"Mason",
			"MasonInstall",
			"MasonUninstall",
			"MasonUninstallAll",
			"MasonLog",
		},
		config = function()
			require("user.lsp")
		end,
	},
	{
		"jayp0521/mason-null-ls.nvim",
		lazy = true,
		dependencies = {
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
}
