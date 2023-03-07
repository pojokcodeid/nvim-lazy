return {
	-- dashboard
	{
		"goolord/alpha-nvim",
		-- event = "BufWinEnter",
		event = "VimEnter",
		config = function()
			require("user.alpha")
		end,
	},
	-- line info bootom
	{
		"nvim-lualine/lualine.nvim",
		-- dependencies = { "kyazdani42/nvim-web-devicons", opt = true },
		event = "BufWinEnter",
		config = function()
			require("user.lualine")
		end,
	},
	-- for show icon
	{
		"kyazdani42/nvim-web-devicons",
		dependencies = { "DaikyXendo/nvim-material-icon" },
		event = "BufRead",
		config = function()
			require("user.webdevicons")
		end,
	},
	-- for tree exploler
	{
		"kyazdani42/nvim-tree.lua",
		-- event = "BufWinEnter",
		cmd = { "NvimTree", "NvimTreeToggle", "NvimTreeFocus", "NvimTreeClose" },
		-- dependencies = "kyazdani42/nvim-web-devicons",
		-- config = function()
		-- 	require("user.nvim-tree")
		-- end,
	},
	-- for file tab
	{
		"famiu/bufdelete.nvim",
		event = "BufRead",
	},
	{
		"akinsho/bufferline.nvim",
		event = "BufWinEnter",
		config = function()
			require("user.bufferline")
		end,
	},
	-- for delete buffers (close files) without closing your windows or messing up your layout.
	{ "moll/vim-bbye", event = "BufRead" },
	-- for view terminal
	{
		"akinsho/toggleterm.nvim",
		cmd = "Toggleterm",
		event = "BufWinEnter",
		init = function()
			require("user.toggleterm")
		end,
	},
	-- key mapping
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			require("user.whichkey")
		end,
	},
	-- for search
	{
		"nvim-telescope/telescope.nvim",
		-- event = "BufRead",
		-- dependencies = { { "nvim-lua/plenary.nvim" } },
		cmd = "Telescope",
		version = false, -- telescope did only one release, so use HEAD for now
		config = function()
			require("user.telescope")
		end,
	},
}
