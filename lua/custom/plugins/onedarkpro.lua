return {
	{ "folke/tokyonight.nvim", enabled = false },
	{
		"olimorris/onedarkpro.nvim",
		priority = 1000, -- Ensure it loads first
		config = function()
			require("onedarkpro").setup({
				styles = {
					types = "NONE",
					methods = "NONE",
					numbers = "NONE",
					strings = "NONE",
					comments = "italic",
					keywords = "bold,italic",
					constants = "NONE",
					functions = "italic",
					operators = "NONE",
					variables = "NONE",
					parameters = "NONE",
					conditionals = "italic",
					virtual_text = "NONE",
				},
				colors = {
					onedark = {
						green = "#99c379",
						gray = "#636e84",
						red = "#e06c75",
						purple = "#c678dd",
						yellow = "#e5c07a",
						blue = "#61afef",
						cyan = "#56b6c2",
						bg_statusline = "#282c34",
					},
				},
				options = {
					cursorline = true,
					transparency = false,
					terminal_colors = true,
				},
				highlights = {
					-- overide cursor line fill colors
					LineNr = { fg = "${fg}" }, -- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
					CursorLineNr = { fg = "${blue}" }, -- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
					CursorLine = { bg = "#333842" },
					Cursor = { fg = "${bg}", bg = "${fg}" }, -- character under the cursor
					lCursor = { fg = "${bg}", bg = "${fg}" }, -- the character under the cursor when |language-mapping| is used (see 'guicursor')
					CursorIM = { fg = "${bg}", bg = "${fg}" }, -- like Cursor, but used when in IME mode |CursorIM|
					CursorColumn = { bg = "#333842" }, -- Screen-column at the cursor, when 'cursorcolumn' is set.
					-- overide nvimtree folder icon fill color
					NvimTreeFolderIcon = { fg = "${blue}" },
					-- overide nvimtree text fill color folder opened
					NvimTreeOpenedFolderName = { fg = "${blue}" },
					-- overide nvimtree text fill color root folder
					NvimTreeRootFolder = { fg = "${blue}" },
					-- overide cmp cursorline fill color with #333842
					PmenuSel = { bg = "#333842" },
					illuminatedWord = { bg = "#3b4261" },
					illuminatedCurWord = { bg = "#3b4261" },
					IlluminatedWordText = { bg = "#3b4261" },
					IlluminatedWordRead = { bg = "#3b4261" },
					IlluminatedWordWrite = { bg = "#3b4261" },
					StatusLine = { fg = "#f8f8f2", bg = "${bg}" },
					StatusLineTerm = { fg = "#f8f8f2", bg = "${bg}" },
					BufferLineFill = { bg = "${bg}" },
					["@string.special.url.html"] = { fg = "${green}" },
					["@text.uri.html"] = { fg = "${green}" },
					Pmenu = { fg = "${fg}", bg = "${bg}" },
					PmenuThumb = { bg = "${gray}" }, -- Popup menu: Thumb of the scrollbar.
					-- overide lualine fill color with bg color
					LualineNormal = { bg = "${bg}" },
					-- overide lualine_c fill color with bg color
					LualineC = { bg = "${bg}" },
					-- overide lualine_x fill color with bg color
					LualineX = { bg = "${bg}" },
					-- overide which-key fill color with bg color
					WhichKey = { bg = "${bg}" },
					-- overide which-key fill color with bg color
					WhichKeySeperator = { bg = "${bg}" },
					-- overide which-key fill color with bg color
					WhichKeyDesc = { bg = "${bg}" },
					-- overide which-key fill color with bg color
					WhichKeyFloat = { bg = "${bg}" },
					-- overide which-key fill color with bg color
					WhichKeyValue = { bg = "${bg}" },
					-- overide which-key fill color with bg color
					WhichKeyBorder = { bg = "${bg}" },
				},
			})
		end,
	},
}
