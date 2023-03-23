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
			require("dracula").setup({
				colors = {
					-- purple = "#FCC76A",
					menu = "#282A36",
				},
				overrides = {
					NvimTreeFolderIcon = { fg = "#FCC76A" },
				},
				transparent_bg = transparent,
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
			vim.g.material_style = material_style
			require("material").setup({
				lualine_style = "stealth",
				disable = {
					background = transparent,
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
				style = onedark_style,
				highlights = {
					-- NvimTreeFolderIcon = { fg = "#FCC76A" },
				},
				transparent = transparent,
				lualine = {
					transparent = transparent,
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
			require("nightfox").setup({
				options = {
					transparent = transparent,
				},
			})
		end,
	},
}
