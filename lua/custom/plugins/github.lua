return {
	"projekt0n/github-nvim-theme",
	lazy = false, -- make sure we load this during startup if it is your main colorscheme
	priority = 1000, -- make sure to load this before all the other start plugins
	config = function()
		local palette = require("github-theme.palette").load("github_dark_dimmed")
		require("github-theme").setup({
			options = {
				-- Compiled file's destination location
				compile_path = vim.fn.stdpath("cache") .. "/github-theme",
				compile_file_suffix = "_compiled", -- Compiled file suffix
				hide_end_of_buffer = true, -- Hide the '~' character at the end of the buffer for a cleaner look
				hide_nc_statusline = true, -- Override the underline style for non-active statuslines
				transparent = false, -- Disable setting background
				terminal_colors = true, -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
				dim_inactive = false, -- Non focused panes set to alternative background
				module_default = true, -- Default enable value for modules
				styles = { -- Style to be applied to different syntax groups
					comments = "italic", -- Value is any valid attr-list value `:help attr-list`
					functions = "italic",
					keywords = "NONE",
					variables = "NONE",
					conditionals = "NONE",
					constants = "NONE",
					numbers = "NONE",
					operators = "NONE",
					strings = "NONE",
					types = "NONE",
				},
				inverse = { -- Inverse highlight for different types
					match_paren = false,
					visual = false,
					search = false,
				},
				darken = { -- Darken floating windows and sidebar-like windows
					floats = false,
					sidebars = {
						enabled = true,
						list = {}, -- Apply dark background to specific windows
					},
				},
				modules = { -- List of various plugins and additional options
					-- ...
				},
			},
			palettes = {
				all = {
					bg0 = "bg1",
				},
			},
			specs = {},
			groups = {
				all = {
					-- As with specs and palettes, a specific style's value will be used over the `all`'s value.
					illuminatedWord = { bg = "#3b4261" },
					illuminatedCurWord = { bg = "#3b4261" },
					IlluminatedWordText = { bg = "#3b4261" },
					IlluminatedWordRead = { bg = "#3b4261" },
					IlluminatedWordWrite = { bg = "#3b4261" },
					NvimTreeNormal = { fg = "fg1", bg = "bg1" },
					NvimTreeSpecialFile = { fg = "fg1", style = "italic" },
					BufferLineFill = { bg = "bg1" },
					BufferLineUnfocusedFill = { bg = "bg1" },
					LualineNormal = { bg = "bg1" },
					StatusLine = { bg = "bg1" },
					StatusLineTerm = { bg = "bg1" },
					Pmenu = { bg = "bg1" },
					PmenuSel = { link = "CursorLine" },
					WhichKeyFloat = { bg = "bg1" },
					LazyNormal = { bg = "bg1" },
					LazyBackground = { bg = "bg1" },
					["@tag.attribute"] = { fg = palette.field, style = "italic" },
					["@text.uri"] = { fg = palette.const, style = "italic" },
				},
			},
		})
	end,
}
