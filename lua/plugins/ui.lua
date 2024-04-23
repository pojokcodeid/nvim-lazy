return {
	-- dashboard
	{
		"goolord/alpha-nvim",
		-- event = "BufWinEnter",
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
		-- dependencies = { "kyazdani42/nvim-web-devicons", opt = true },
		-- event = "BufWinEnter",
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
		-- event = "BufRead",
		config = function()
			require("user.webdevicons")
		end,
	},
	-- for tree exploler
	{
		"kyazdani42/nvim-tree.lua",
		lazy = true,
		-- event = "BufRead",
		cmd = { "NvimTree", "NvimTreeToggle", "NvimTreeFocus", "NvimTreeClose" },
		-- dependencies = "kyazdani42/nvim-web-devicons",
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
		-- event = "InsertEnter",
	},
	{
		"akinsho/bufferline.nvim",
		lazy = true,
		-- event = "BufWinEnter",
		event = { "BufRead", "InsertEnter", "BufNewFile" },
		config = function()
			require("user.bufferline")
		end,
	},
	-- for delete buffers (close files) without closing your windows or messing up your layout.
	-- { "moll/vim-bbye", event = "InsertEnter" },
	-- for view terminal
	{
		"akinsho/toggleterm.nvim",
		lazy = true,
		cmd = { "ToggleTerm" },
		-- event = "InsertEnter",
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
		-- event = "BufRead",
		-- dependencies = { { "nvim-lua/plenary.nvim" } },
		cmd = "Telescope",
		version = false, -- telescope did only one release, so use HEAD for now
		config = function()
			require("user.telescope")
		end,
	},
	{
		"karb94/neoscroll.nvim",
		lazy = true,
		-- event = "InsertEnter",
		config = function()
			require("user.neoscroll")
		end,
	},
}
