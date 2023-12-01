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
		["jsx"] = {
			icon = "",
			color = "#0FBFCF",
			cterm_color = "220",
			name = "jsx",
		},
		["svg"] = {
			icon = "󰜡",
			color = "#FDB03A",
			cterm_color = "220",
			name = "svg",
		},
	},
	color_icons = true,
	default = true,
})

web_devicons.setup({
	override = material_icon.get_icons(),
	override_by_filename = {
		[".prettierrc"] = {
			icon = "",
			color = "#ea5e5e",
			cterm_color = "167",
			name = "prettierrc",
		},
		[".prettierignore"] = {
			icon = "",
			color = "#ea5e5e",
			cterm_color = "167",
			name = "prettierignore",
		},
	},
})
