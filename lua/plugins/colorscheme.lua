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

return {
	-- color scheme
	{ "luisiacc/gruvbox-baby", lazy = true, enabled = gruvbox },
	{ "dracula/vim", enabled = dracula },
	{ "folke/tokyonight.nvim", enabled = tokyonight },
	{ "arcticicestudio/nord-vim", enabled = nord },
	{ "sainnhe/sonokai", enabled = sonokai },
	{ "lunarvim/lunar.nvim", enabled = lunar },
	{
		"marko-cerovac/material.nvim",
		enabled = material,
		config = function()
			vim.g.material_style = "palenight"
			require("material").setup({
				lualine_style = "stealth",
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
