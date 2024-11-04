return {
	"Mofiqul/dracula.nvim",
	priority = 1000,
	opts=function()
		local colors = require("dracula").colors()
		return{
			colors = {
				-- purple = "#FCC76A",
				menu = colors.bg,
				selection = "#363848",
			},
			italic_comment = true,
			lualine_bg_color = colors.bg,
			overrides = {
				Keywords = { fg = colors.cyan, italic = true },
				["@keyword"] = { fg = colors.pink, italic = true },
				["@keyword.function"] = { fg = colors.cyan, italic = true },
				["@function"] = { fg = colors.green, italic = true },
				["@tag.attribute"] = { fg = colors.green, italic = true },
				["@tag.builtin.javascript"] = { fg = colors.pink },
				["@tag.delimiter.javascript"] = { fg = colors.fg },
				["@type.javascript"] = { fg = colors.fg },
				["@property.css"] = { fg = colors.cyan },
				["@type.css"] = { fg = colors.green },
				["@tag.css"] = { fg = colors.pink },
				["@keyword.css"] = { fg = colors.fg },
				["@string.css"] = { fg = colors.pink },
				NvimTreeFolderIcon = { fg = "#6776a7" },
				CmpItemAbbr = { fg = "#ABB2BF" },
				CmpItemKind = { fg = "#ABB2BF" },
				CmpItemAbbrDeprecated = { fg = "#ABB2BF" },
				CmpItemAbbrMatch = { fg = "#8BE9FD" },
				htmlLink = { fg = "#BD93F9", underline = false },
				Underlined = { fg = "#8BE9FD" },
				NvimTreeSpecialFile = { fg = "#FF79C6" },
				SpellBad = { fg = "#FF6E6E" },
				illuminatedWord = { bg = "#3b4261" },
				illuminatedCurWord = { bg = "#3b4261" },
				IlluminatedWordText = { bg = "#3b4261" },
				IlluminatedWordRead = { bg = "#3b4261" },
				IlluminatedWordWrite = { bg = "#3b4261" },
				DiffChange = { fg = colors.fg },
				StatusLine = { fg = colors.fg, bg = colors.bg },
				StatusLineTerm = { fg = colors.fg, bg = colors.bg },
				BufferLineFill = { bg = colors.bg },
				Pmenu = { fg = colors.fg, bg = colors.bg },
				LspInfoBorder = { fg = colors.fg },
				LspReferenceText = { bg = "#3b4261" },
				LspReferenceRead = { bg = "#3b4261" },
				LspReferenceWrite = { bg = "#3b4261" },
				WinBar = { bg = colors.bg },
				WinBarNC = { fg = colors.fg, bg = colors.bg },
			},
			transparent_bg = false,
		}
	end,
	config = function(_,opts)
		require("dracula").setup(opts)
		local colorscheme = pcode.themes.dracula or "dracula"
		vim.cmd("colorscheme " .. colorscheme)
	end,
}
