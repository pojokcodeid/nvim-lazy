local web_devicons_ok, web_devicons = pcall(require, "nvim-web-devicons")
if not web_devicons_ok then
	return
end

local material_icon_ok, material_icon = pcall(require, "nvim-material-icon")
if not material_icon_ok then
	return
end
material_icon.setup({
	override = {
		["mjs"] = {
			icon = "",
			color = "#efd81d",
			cterm_color = "220",
			name = "Mjs",
		},
		["ts"] = {
			icon = "󰛦",
			color = "#30A2FF",
			cterm_color = "220",
			name = "ts",
		},
	},
	color_icons = true,
	default = true,
})

web_devicons.setup({
	override = material_icon.get_icons(),
})
