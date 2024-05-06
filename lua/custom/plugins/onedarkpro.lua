return {
	{ "navarasu/onedark.nvim", enabled = false },
	{
		"olimorris/onedarkpro.nvim",
		priority = 1000, -- Ensure it loads first
		config = function()
			local is_transparent = true
			require("onedarkpro").setup({
				styles = {
					types = "NONE",
					methods = "NONE",
					numbers = "NONE",
					strings = "NONE",
					comments = "italic",
					-- keywords = "bold,italic",
					keywords = "italic",
					constants = "NONE",
					functions = "NONE",
					operators = "NONE",
					variables = "NONE",
					parameters = "NONE",
					conditionals = "italic",
					virtual_text = "NONE",
					tags = "italic",
				},
				colors = {
					onedark = {
						green = "#99c379",
						gray = "#8094b4",
						red = "#e06c75",
						purple = "#c678dd",
						yellow = "#e5c07a",
						blue = "#61afef",
						cyan = "#56b6c2",
						bg_statusline = "#282c34",
						indentline = "#3b4261",
						float_bg = "#282c34",
					},
				},
				filetypes = {
					-- javascript = false,
				},
				options = {
					cursorline = true, -- Use cursorline highlighting?
					transparency = is_transparent, -- Use a transparent background?
					terminal_colors = true, -- Use the theme's colors for Neovim's :terminal?
					lualine_transparency = is_transparent, -- Center bar transparency?
					highlight_inactive_windows = false, -- When the window is out of focus, change the normal background?
				},
				highlights = {
					-- overide cursor line fill colors
					LineNr = { fg = "#49505E" }, -- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
					CursorLineNr = { fg = "${blue}" }, -- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
					CursorLine = { bg = "#333842" },
					Cursor = { fg = "${bg}", bg = "${fg}" }, -- character under the cursor
					lCursor = { fg = "${bg}", bg = "${fg}" }, -- the character under the cursor when |language-mapping| is used (see 'guicursor')
					CursorIM = { fg = "${bg}", bg = "${fg}" }, -- like Cursor, but used when in IME mode |CursorIM|
					CursorColumn = { bg = "#333842" }, -- Screen-column at the cursor, when 'cursorcolumn' is set.
					-- overide nvimtree folder icon fill color
					NvimTreeFolderIcon = { fg = "${gray}" },
					-- overide nvimtree text fill color folder opened
					NvimTreeOpenedFolderName = { fg = "${blue}" },
					-- overide nvimtree text fill color root folder
					NvimTreeRootFolder = { fg = "${blue}" },
					NvimTreeSpecialFile = { fg = "${orange}" },
					NvimTreeWinSeparator = { fg = "#202329" },
					NvimTreeIndentMarker = { fg = "#3E4450" },
					-- overide indenline fill color
					IblIndent = { fg = "#3E4450" },
					-- overide cmp cursorline fill color with #333842
					PmenuSel = { bg = "#333842" },
					illuminatedWord = { bg = "#3b4261" },
					illuminatedCurWord = { bg = "#3b4261" },
					IlluminatedWordText = { bg = "#3b4261" },
					IlluminatedWordRead = { bg = "#3b4261" },
					IlluminatedWordWrite = { bg = "#3b4261" },
					StatusLine = { fg = "#f8f8f2", bg = is_transparent and "NONE" or "${bg}" },
					StatusLineTerm = { fg = "#f8f8f2", bg = "${bg}" },
					BufferLineFill = { bg = is_transparent and "NONE" or "${bg}" },
					["@string.special.url.html"] = { fg = "${green}" },
					["@text.uri.html"] = { fg = "${green}" },
					["@tag.javascript"] = { fg = "${red}" },
					["@tag.attribute"] = { fg = "${orange}", style = "italic" },
					["@constructor.javascript"] = { fg = "${red}" },
					-- ["@variable"] = { fg = "${fg}", style = "NONE" }, -- various variable names
					["@variable.builtin"] = { fg = "${red}", style = "NONE" },
					["@variable.member"] = "${cyan}",
					["@variable.parameter"] = "${red}",
					-- ["@property.javascript"] = { fg = "${cyan}" }, -- similar to `@field`
					["@lsp.type.parameter"] = { fg = "${fg}" },
					["@lsp.type.property.lua"] = { fg = "${red}" },
					["@lsp.type.variable"] = { fg = "${fg}" },
					NvimTreeGitDirty = { fg = "${yellow}" },
					Pmenu = { fg = "${fg}", bg = "${bg}" },
					PmenuThumb = { bg = "${gray}" }, -- Popup menu: Thumb of the scrollbar.
					-- overide lualine fill color with bg color
					LualineNormal = { bg = "${bg}" },
					-- overide lualine_c fill color with bg color
					LualineC = { bg = "${bg}" },
					-- overide lualine_x fill color with bg color
					LualineX = { bg = "${bg}" },
					-- overide which-key fill color with bg color
					-- WhichKey = { bg = "${bg}" },
					-- -- overide which-key fill color with bg color
					-- WhichKeySeperator = { bg = "${bg}" },
					-- -- overide which-key fill color with bg color
					-- WhichKeyDesc = { fg = "${red}" },
					-- -- overide which-key fill color with bg color
					-- WhichKeyFloat = { bg = "${bg}" },
					WhichKeyFloat = { bg = is_transparent and "NONE" or "${bg}" },
					-- -- overide which-key fill color with bg color
					-- WhichKeyValue = { bg = "${bg}" },
					-- -- overide which-key fill color with bg color
					-- WhichKeyBorder = { bg = "${bg}" },
					-- Folded = { bg = "NONE", fg = "${fg}" }, -- line used for closed folds
					TermCursor = { bg = "${fg}" },
					TSRainbowRed = { fg = "${cyan}" },
					TSRainbowCyan = { fg = "${red}" },
					NonText = { fg = "${fg}", bg = is_transparent and "NONE" or "#30333d" },
					MiniIndentscopeSymbol = { fg = "${cyan}" },
				},
			})
		end,
	},
}
