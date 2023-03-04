local gruvbox = true
local dracula = false
local tokyonight = false
local nord = false
local sonokai = false
local lunar = false
local material = false
local onedark = false
local catppuccin = false

_G.switch = function(param, case_table)
	local case = case_table[param]
	if case then
		return case()
	end
	local def = case_table["default"]
	return def and def() or nil
end

local data_exists, custom_ui = pcall(require, "custom.ui")
if data_exists then
	if type(custom_ui) == "table" then
		local color = custom_ui.colorscheme
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
			end,
			["material"] = function()
				gruvbox = false
				material = true
			end,
			["onedark"] = function()
				gruvbox = false
				onedark = true
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
			["dracula"] = function()
				gruvbox = false
				dracula = true
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
local transparent_mode = custom_ui.transparent_mode
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
					purple = "#FCC76A",
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
	{ "sainnhe/sonokai", enabled = sonokai },
	{ "lunarvim/lunar.nvim", enabled = lunar },
	{
		"marko-cerovac/material.nvim",
		enabled = material,
		config = function()
			vim.g.material_style = "palenight"
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
				style = "darker",
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
}
