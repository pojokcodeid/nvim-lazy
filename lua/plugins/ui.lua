return {
	-- color scheme
	{
		"folke/tokyonight.nvim",
		-- commit = "66bfc2e8f754869c7b651f3f47a2ee56ae557764",
		lazy = true, -- make sure we load this during startup if it is your main colorscheme
		-- priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			local is_transparant = false
			if is_transparant then
				require("user.tokyonight_transparant")
			else
				require("user.tokyonight")
			end
		end,
	},
	-- {
	-- 	"navarasu/onedark.nvim",
	-- 	init = function()
	-- 		require("user.onedark")
	-- 		require("onedark").load()
	-- 	end,
	-- },
	-- { "lunarvim/lunar.nvim" },
	-- -- { "arcticicestudio/nord-vim" },
	-- {
	-- 	"catppuccin/nvim",
	-- 	name = "catppuccin",
	-- 	init = function()
	-- 		require("user.catppuccin")
	-- 	end,
	-- },
	{ "luisiacc/gruvbox-baby" },
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
	-- -- { "EdenEast/nightfox.nvim" },
	-- {
	-- 	"marko-cerovac/material.nvim",
	-- 	init = function()
	-- 		vim.g.material_style = "darker"
	-- 	end,
	-- },

	-- include treesitter
	-- require("plugins.treesitter"),
	-- {
	-- 	"nvim-treesitter/nvim-treesitter",
	-- 	commit = "8e763332b7bf7b3a426fd8707b7f5aa85823a5ac",
	-- 	run = ":TSUpdate",
	-- 	event = "BufWinEnter",
	-- 	opts = function()
	-- 		require("user.treesitter")
	-- 	end,
	-- },
	-- dashboard
	{
		"goolord/alpha-nvim",
		module = "alpha",
		event = "BufWinEnter",
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
			local model = 0
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
		event = "BufRead",
		config = function()
			require("user.webdevicons")
		end,
	},
	-- for tree exploler
	{
		"kyazdani42/nvim-tree.lua",
		-- event = "BufRead",
		cmd = "NvimTreeToggle",
		-- dependencies = "kyazdani42/nvim-web-devicons",
		config = function()
			require("user.nvim-tree")
		end,
	},
	-- for file tab
	{
		"famiu/bufdelete.nvim",
		event = "BufRead",
	},
	{
		"akinsho/bufferline.nvim",
		event = "BufRead",
		-- config = function()
		-- 	require("user.bufferline")
		-- end,
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
	-- -- ui components
	-- { "MunifTanjim/nui.nvim", lazy = true },
	-- -- noicer ui
	-- {
	-- 	"folke/noice.nvim",
	-- 	event = "VeryLazy",
	-- 	opts = {
	-- 		lsp = {
	-- 			override = {
	-- 				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
	-- 				["vim.lsp.util.stylize_markdown"] = true,
	-- 			},
	-- 		},
	-- 		presets = {
	-- 			bottom_search = true,
	-- 			command_palette = true,
	-- 			long_message_to_split = true,
	-- 		},
	-- 	},
	--    -- stylua: ignore
	--    keys = {
	--      { "<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c", desc = "Redirect Cmdline" },
	--      { "<leader>snl", function() require("noice").cmd("last") end, desc = "Noice Last Message" },
	--      { "<leader>snh", function() require("noice").cmd("history") end, desc = "Noice History" },
	--      { "<leader>sna", function() require("noice").cmd("all") end, desc = "Noice All" },
	--      { "<c-f>", function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end, silent = true, expr = true, desc = "Scroll forward", mode = {"i", "n", "s"} },
	--      { "<c-b>", function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true, expr = true, desc = "Scroll backward", mode = {"i", "n", "s"}},
	--    },
	-- },

	-- simbol outline
	{
		"simrat39/symbols-outline.nvim",
		event = "BufRead",
		config = function()
			require("symbols-outline").setup()
		end,
	},
}
