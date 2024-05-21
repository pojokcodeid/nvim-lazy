return {
	"folke/which-key.nvim",
	lazy = true,
	keys = { "<leader>", '"', "'", "`", "c", "v" },
	event = "VeryLazy",
	opts = function()
		local icons = require("user.icons")
		return {
			plugins = {
				marks = false, -- shows a list of your marks on ' and `
				registers = false, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
				spelling = {
					enabled = true,
					suggestions = 20,
				}, -- use which-key for spelling hints
				-- the presets plugin, adds help for a bunch of default keybindings in Neovim
				-- No actual key bindings are created
				presets = {
					operators = false, -- adds help for operators like d, y, ...
					motions = false, -- adds help for motions
					text_objects = false, -- help for text objects triggered after entering an operator
					windows = false, -- default bindings on <c-w>
					nav = false, -- misc bindings to work with windows
					z = false, -- bindings for folds, spelling and others prefixed with z
					g = false, -- bindings for prefixed with g
				},
			}, -- add operators that will trigger motion and text object completion
			-- to enable all native operators, set the preset / operators plugin above
			-- operators = { gc = "Comments" },
			key_labels = {
				-- override the label used to display some keys. It doesn't effect WK in any other way.
				-- For example:
				-- ["<space>"] = "SPC",
				-- ["<cr>"] = "RET",
				-- ["<tab>"] = "TAB",
			},
			icons = {
				breadcrumb = icons.ui.DoubleChevronRight, -- symbol used in the command line area that shows your active key combo
				separator = icons.ui.BoldArrowRight, -- symbol used between a key and it's label
				group = icons.ui.Plus, -- symbol prepended to a group
			},
			popup_mappings = {
				scroll_down = "<c-d>", -- binding to scroll down inside the popup
				scroll_up = "<c-u>", -- binding to scroll up inside the popup
			},
			window = {
				border = "rounded", -- none, single, double, shadow
				position = "bottom", -- bottom, top
				margin = { 1, 1, 1, 1 }, -- extra window margin [top, right, bottom, left]
				padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
				winblend = 0,
			},
			layout = {
				height = { min = 4, max = 25 }, -- min and max height of the columns
				width = { min = 20, max = 50 }, -- min and max width of the columns
				spacing = 3, -- spacing between columns
				align = "left", -- align columns left, center or right
			},
			ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
			hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
			show_help = true, -- show help message on the command line when the popup is visible
			show_keys = true, -- show the currently pressed key and its label as a message in the command line
			triggers = "auto", -- automatically setup triggers
			-- triggers = {"<leader>"} -- or specify a list manually
			triggers_blacklist = {
				-- list of mode / prefixes that should never be hooked by WhichKey
				-- this is mostly relevant for key maps that start with a native binding
				-- most people should not need to change this
				i = { "j", "k" },
				v = { "j", "k" },
			},
			-- Disabled by default for Telescope
			disable = {
				buftypes = {},
				filetypes = { "TelescopePrompt" },
			},
		}
	end,
	config = function(_, opts)
		local opt = {
			mode = "n", -- NORMAL mode
			prefix = "<leader>",
			buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
			silent = true, -- use `silent` when creating keymaps
			noremap = true, -- use `noremap` when creating keymaps
			nowait = true, -- use `nowait` when creating keymaps
		}

		local opt2 = {
			mode = "v", -- NORMAL mode
			prefix = "<leader>",
			buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
			silent = true, -- use `silent` when creating keymaps
			noremap = true, -- use `noremap` when creating keymaps
			nowait = true, -- use `nowait` when creating keymaps
		}

		local wkey = {}
		local data_exists, key = pcall(require, "core.config")
		if data_exists then
			wkey = key.whichkey
		end

		local which_key = require("which-key")
		which_key.setup(opts)
		which_key.register(require("user.utils.whichkey").mappings, opt)
		which_key.register(wkey, opt)
		which_key.register(require("user.utils.whichkey").mappings2, opt2)
	end,
}
