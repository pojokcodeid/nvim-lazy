local gruvbox = true
local dracula = false
local tokyonight = false
local nord = false
local sonokai = false
local lunar = false
local material = false
local onedark = false
local catppuccin = false
local nightfox = false

local sonokai_style = "default"
local material_style = "oceanic"
local onedark_style = "dark"

_G.switch = function(param, case_table)
	local case = case_table[param]
	if case then
		return case()
	end
	local def = case_table["default"]
	return def and def() or nil
end

local data_exists, config = pcall(require, "core.config")
if data_exists then
	if config.colorscheme ~= nil then
		local color = config.colorscheme
		switch(color, {
			["tokyonight"] = function()
				gruvbox = false
				tokyonight = true
			end,
			["tokyonight-night"] = function()
				gruvbox = false
				tokyonight = true
			end,
			["tokyonight-storm"] = function()
				gruvbox = false
				tokyonight = true
			end,
			["tokyonight-day"] = function()
				gruvbox = false
				tokyonight = true
			end,
			["tokyonight-moon"] = function()
				gruvbox = false
				tokyonight = true
			end,
			["sonokai"] = function()
				gruvbox = false
				sonokai = true
				sonokai_style = "default"
			end,
			["sonokai_atlantis"] = function()
				gruvbox = false
				sonokai = true
				sonokai_style = "atlantis"
			end,
			["sonokai_andromeda"] = function()
				gruvbox = false
				sonokai = true
				sonokai_style = "andromeda"
			end,
			["sonokai_shusia"] = function()
				gruvbox = false
				sonokai = true
				sonokai_style = "shusia"
			end,
			["sonokai_maia"] = function()
				gruvbox = false
				sonokai = true
				sonokai_style = "maia"
			end,
			["sonokai_espresso"] = function()
				gruvbox = false
				sonokai = true
				sonokai_style = "espresso"
			end,
			["material"] = function()
				gruvbox = false
				material = true
			end,
			["material_deepocean"] = function()
				gruvbox = false
				material = true
				material_style = "deep ocean"
			end,
			["material_palenight"] = function()
				gruvbox = false
				material = true
				material_style = "palenight"
			end,
			["material_lighter"] = function()
				gruvbox = false
				material = true
				material_style = "lighter"
			end,
			["material_darker"] = function()
				gruvbox = false
				material = true
				material_style = "darker"
			end,
			["onedark"] = function()
				gruvbox = false
				onedark = true
			end,
			["onedark_darker"] = function()
				gruvbox = false
				onedark = true
				onedark_style = "darker"
			end,
			["onedark_cool"] = function()
				gruvbox = false
				onedark = true
				onedark_style = "cool"
			end,
			["onedark_deep"] = function()
				gruvbox = false
				onedark = true
				onedark_style = "deep"
			end,
			["onedark_warm"] = function()
				gruvbox = false
				onedark = true
				onedark_style = "warm"
			end,
			["onedark_warmer"] = function()
				gruvbox = false
				onedark = true
				onedark_style = "warmer"
			end,
			["onedark_light"] = function()
				gruvbox = false
				onedark = true
				onedark_style = "light"
			end,
			["lunar"] = function()
				gruvbox = false
				lunar = true
			end,
			["nord"] = function()
				gruvbox = false
				nord = true
			end,
			["catppuccin"] = function()
				gruvbox = false
				catppuccin = true
			end,
			["catppuccin-latte"] = function()
				gruvbox = false
				catppuccin = true
			end,
			["catppuccin-frappe"] = function()
				gruvbox = false
				catppuccin = true
			end,
			["catppuccin-macchiato"] = function()
				gruvbox = false
				catppuccin = true
			end,
			["catppuccin-mocha"] = function()
				gruvbox = false
				catppuccin = true
			end,
			["dracula"] = function()
				gruvbox = false
				dracula = true
			end,
			["nightfox"] = function()
				gruvbox = false
				nightfox = true
			end,
			["dayfox"] = function()
				gruvbox = false
				nightfox = true
			end,
			["dawnfox"] = function()
				gruvbox = false
				nightfox = true
			end,
			["duskfox"] = function()
				gruvbox = false
				nightfox = true
			end,
			["nordfox"] = function()
				gruvbox = false
				nightfox = true
			end,
			["terafox"] = function()
				gruvbox = false
				nightfox = true
			end,
			["carbonfox"] = function()
				gruvbox = false
				nightfox = true
			end,
			["gruvbox-baby"] = function()
				gruvbox = true
			end,
			default = function()
				gruvbox = true
			end,
		})
	end
end

local transparent = false
local transparent_mode = config.transparent_mode
if transparent_mode ~= nil then
	if transparent_mode == 1 then
		transparent = true
	end
end

return {
	-- color scheme
	{ "luisiacc/gruvbox-baby", lazy = true, enabled = gruvbox },
	{
		"Mofiqul/dracula.nvim",
		enabled = dracula,
		config = function()
			local is_transparent = false
			local colors = require("dracula").colors()
			if is_transparent then
				colors = {
					bg = "none",
				}
			end
			require("dracula").setup({
				colors = {
					-- purple = "#FCC76A",
					menu = colors.bg,
				},
				italic_comment = true,
				lualine_bg_color = colors.bg,
				overrides = {
					NvimTreeFolderIcon = { fg = "#6776a7" },
					CmpItemAbbr = { fg = "#ABB2BF" },
					CmpItemKind = { fg = "#ABB2BF" },
					CmpItemAbbrDeprecated = { fg = "#ABB2BF" },
					CmpItemAbbrMatch = { fg = "#8BE9FD" },
					htmlLink = { fg = "#BD93F9", underline = false },
					Underlined = { fg = "#8BE9FD" },
					NvimTreeSpecialFile = { fg = "#FF79C6" },
					MatchParen = { fg = "#F8F8F2" },
					SpellBad = { fg = "#FF6E6E" },
					illuminatedWord = { bg = "#3b4261" },
					illuminatedCurWord = { bg = "#3b4261" },
					IlluminatedWordText = { bg = "#3b4261" },
					IlluminatedWordRead = { bg = "#3b4261" },
					IlluminatedWordWrite = { bg = "#3b4261" },
					StatusLine = { fg = "#f8f8f2", bg = colors.bg },
					StatusLineTerm = { fg = "#f8f8f2", bg = colors.bg },
					BufferLineFill = { bg = colors.bg },
					Pmenu = { fg = colors.white, bg = colors.bg },
				},
				transparent_bg = transparent,
				-- transparent_bg = is_transparent,
			})
		end,
	},
	{
		"folke/tokyonight.nvim",
		enabled = tokyonight,
		config = function()
			require("user.tokyonight")
		end,
	},
	{
		"shaunsingh/nord.nvim",
		enabled = nord,
		config = function()
			vim.g.nord_disable_background = transparent
			require("nord").set()
		end,
	},
	{
		"sainnhe/sonokai",
		enabled = sonokai,
		config = function()
			vim.g.sonokai_style = sonokai_style
		end,
	},
	{ "lunarvim/lunar.nvim", enabled = lunar },
	{
		"marko-cerovac/material.nvim",
		enabled = material,
		config = function()
			local colors = require("material.colors")
			vim.g.material_style = material_style
			require("material").setup({
				lualine_style = "stealth",
				disable = {
					background = transparent,
				},
				plugins = { -- Uncomment the plugins that you use to highlight them
					-- Available plugins:
					"dap",
					-- "dashboard",
					-- "eyeliner",
					"fidget",
					-- "flash",
					-- "gitsigns",
					-- "harpoon",
					-- "hop",
					"illuminate",
					"indent-blankline",
					-- "lspsaga",
					"mini",
					-- "neogit",
					-- "neotest",
					-- "neo-tree",
					-- "neorg",
					"noice",
					"nvim-cmp",
					"nvim-navic",
					"nvim-tree",
					"nvim-web-devicons",
					-- "rainbow-delimiters",
					-- "sneak",
					"telescope",
					-- "trouble",
					"which-key",
					"nvim-notify",
				},
				custom_highlights = {
					BufferLineFill = { bg = colors.bg },
					StatusLine = { fg = "#f8f8f2", bg = colors.bg },
					StatusLineTerm = { fg = "#f8f8f2", bg = colors.bg },
				},
			})
		end,
	},
	{
		"navarasu/onedark.nvim",
		enabled = onedark,
		priority = 1000,
		config = function()
			-- Lua
			require("onedark").setup({
				term_colors = true,
				style = onedark_style,
				colors = {
					bg_d = "$bg",
				},
				highlights = {
					-- NvimTreeFolderIcon = { fg = "#FCC76A" },
					BufferLineFill = { bg = "$bg0" },
					BufferLineUnfocusedFill = { bg = "$bg0" },
					StatusLine = { fg = "#f8f8f2", bg = "$bg0" },
					StatusLineTerm = { fg = "#f8f8f2", bg = "$bg0" },
					illuminatedWord = { bg = "#3b4261" },
					illuminatedCurWord = { bg = "#3b4261" },
					IlluminatedWordText = { bg = "#3b4261" },
					IlluminatedWordRead = { bg = "#3b4261" },
					IlluminatedWordWrite = { bg = "#3b4261" },
					PmenuSel = { fg = "$fg", bg = "$bg1" },
					-- overide lualine fill color with bg color
					LualineNormal = { bg = "$bg0" },
					-- overide lualine_c fill color with bg color
					LualineC = { bg = "$bg0" },
					-- overide lualine_x fill color with bg color
					LualineX = { bg = "$bg0" },
					-- overide which-key fill color with bg color
					WhichKey = { bg = "$bg0" },
					-- overide which-key fill color with bg color
					WhichKeySeperator = { bg = "$bg0" },
					-- overide which-key fill color with bg color
					WhichKeyDesc = { bg = "$bg0" },
					-- overide which-key fill color with bg color
					WhichKeyFloat = { bg = "$bg0" },
					-- overide which-key fill color with bg color
					WhichKeyValue = { bg = "$bg0" },
					-- overide which-key fill color with bg color
					WhichKeyBorder = { bg = "$bg0" },
					-- overide Lazy fill color with bg color
					-- LazyNormal = { bg = "$bg0" },
					-- -- overide lazy background color with bg color
					-- LazyBackground = { bg = "$bg0" },
					-- -- overide Lazy fill color with bg color
					-- LazyH1 = { bg = "$bg0" },
					-- -- overide Lazy fill color with bg color
					-- LazyH2 = { bg = "$bg0" },
					-- -- overide Lazy fill color with bg color
					-- LazyH3 = { bg = "$bg0" },
					-- -- overide Lazy fill color with bg color
					-- LazyH4 = { bg = "$bg0" },
					-- -- overide Lazy fill color with bg color
					-- LazyH5 = { bg = "$bg0" },
					-- -- overide Lazy fill color with bg color
					-- LazyH6 = { bg = "$bg0" },
					-- -- overide Lazy fill color with bg color
					-- LazyButton = { bg = "$bg0" },
					-- -- overide Lazy fill color with bg color
					-- LazyButtonActive = { bg = "$bg0" },
					-- -- overide Lazy fill color with bg color
					-- LazySpecial = { bg = "$bg0" },
					-- -- overide Lazy fill color with bg color
					-- LazyProgress = { bg = "$bg0" },
					-- Pmenu = { fg = "$fg", bg = "$bg0" },
				},
				transparent = transparent,
				lualine = {
					transparent = true,
				},
			})
			require("onedark").load()
		end,
	},
	{
		"catppuccin/nvim",
		enabled = catppuccin,
		name = "catppuccin",
		init = function()
			require("user.catppuccin")
		end,
	},
	{
		"EdenEast/nightfox.nvim",
		enabled = nightfox,
		config = function()
			local palette = require("nightfox.palette").load("nightfox")
			local Color = require("nightfox.lib.color")
			local bg = Color.from_hex(palette.bg1)
			require("nightfox").setup({
				options = {
					terminal_colors = true,
					transparent = transparent,
				},
				palettes = {},
				specs = {},
				groups = {
					all = {
						-- overide bufferline fill color
						BufferLineFill = { bg = "bg1" },
						BufferLineUnfocusedFill = { bg = "bg1" },
						-- overide nvimtree fill color with bg color
						NvimTreeNormal = { bg = "bg1" },
						-- overide statusline fill color with bg color
						StatusLine = { bg = "bg1" },
						StatusLineTerm = { bg = "bg1" },
						-- overide lualine fill color with bg color
						LualineNormal = { bg = "bg1" },
						-- overide lualine_c fill color with bg color
						LualineC = { bg = "bg1" },
						-- overide lualine_x fill color with bg color
						LualineX = { bg = "bg1" },
						-- overide which-key fill color with bg color
						WhichKey = { bg = "bg1" },
						-- overide which-key fill color with bg color
						WhichKeySeperator = { bg = "bg1" },
						-- overide which-key fill color with bg color
						WhichKeyDesc = { bg = "bg1" },
						-- overide which-key fill color with bg color
						WhichKeyFloat = { bg = "bg1" },
						-- overide which-key fill color with bg color
						WhichKeyValue = { bg = "bg1" },
						-- overide which-key fill color with bg color
						WhichKeyBorder = { bg = "bg1" },
						-- overide Lazy fill color with bg color
						LazyNormal = { bg = "bg1" },
						-- overide Lazy fill color with bg color
						LazyH1 = { bg = "bg1" },
						-- overide Lazy fill color with bg color
						LazyH2 = { bg = "bg1" },
						-- overide Lazy fill color with bg color
						LazyH3 = { bg = "bg1" },
						-- overide Lazy fill color with bg color
						LazyH4 = { bg = "bg1" },
						-- overide Lazy fill color with bg color
						LazyH5 = { bg = "bg1" },
						-- overide Lazy fill color with bg color
						LazyH6 = { bg = "bg1" },
						-- overide Lazy fill color with bg color
						LazyButton = { bg = "bg1" },
						-- overide Lazy fill color with bg color
						LazyButtonActive = { bg = "bg1" },
						-- overide Lazy fill color with bg color
						LazySpecial = { bg = "bg1" },
						-- overide Lazy fill color with bg color
						LazyProgress = { bg = "bg1" },
						Pmenu = { bg = "bg1" },
					},
				},
			})
		end,
	},
}
