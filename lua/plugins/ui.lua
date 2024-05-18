return {
	-- dashboard
	{
		"goolord/alpha-nvim",
		lazy = true,
		event = "VimEnter",
		config = function()
			require("user.alpha")
		end,
	},
	-- line info bootom
	{
		"nvim-lualine/lualine.nvim",
		lazy = true,
		event = { "BufRead", "BufNewFile" },
		config = function()
			require("user.lualine_cfg")
		end,
	},
	-- for show icon
	{
		"kyazdani42/nvim-web-devicons",
		lazy = true,
		dependencies = { "pojokcodeid/nvim-material-icon" },
		config = function()
			require("user.webdevicons")
		end,
	},
	-- for tree exploler
	{
		"kyazdani42/nvim-tree.lua",
		lazy = true,
		cmd = { "NvimTree", "NvimTreeOpen", "NvimTreeToggle", "NvimTreeFocus", "NvimTreeClose" },
		config = function()
			local data_exists, treeconfig = pcall(require, "core.config")
			if data_exists then
				if treeconfig.loadnvimtree_lazy then
					require("user.nvim-tree")
				end
			end
		end,
	},
	-- for file tab
	{
		"famiu/bufdelete.nvim",
		lazy = true,
	},
	{
		"akinsho/bufferline.nvim",
		lazy = true,
		branch = "main",
		event = { "BufRead", "InsertEnter", "BufNewFile" },
		config = function()
			require("user.bufferline")
		end,
	},
	-- for view terminal
	{
		"akinsho/toggleterm.nvim",
		lazy = true,
		cmd = { "ToggleTerm" },
		config = function()
			require("user.toggleterm")
		end,
	},
	-- key mapping
	{
		"folke/which-key.nvim",
		lazy = true,
		keys = { "<leader>", '"', "'", "`", "c", "v" },
		event = "VeryLazy",
		config = function()
			require("user.whichkey")
		end,
	},
	-- for search
	{
		"nvim-telescope/telescope.nvim",
		lazy = true,
		cmd = "Telescope",
		version = false, -- telescope did only one release, so use HEAD for now
		config = function()
			require("user.telescope")
		end,
	},
	{
		"karb94/neoscroll.nvim",
		lazy = true,
		config = function()
			require("user.neoscroll")
		end,
	},
}
