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
		["prisma"] = {
			icon = "",
			color = "#0FBFCF",
			cterm_color = "220",
			name = "prisma",
		},
		["json"] = {
			icon = "",
			color = "#dbb7b7",
			cterm_color = "220",
			name = "json",
		},
		["map"] = {
			icon = "",
			color = "#748e54",
			cterm_color = "220",
			name = "map",
		},
		["svelte"] = {
			icon = "",
			color = "#ef510b",
			cterm_color = "220",
			name = "svelte",
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
			cterm_color = "240",
			name = "prettierrc",
		},
		[".prettierignore"] = {
			icon = "",
			color = "#ea5e5e",
			cterm_color = "240",
			name = "prettierignore",
		},
		[".sequelizerc"] = {
			icon = "󱙌",
			color = "#397883",
			cterm_color = "220",
			name = "sequelizerc",
		},
		["pre-commit"] = {
			icon = "",
			color = "#75e4b3",
			cterm_color = "240",
			name = "pre",
		},
		["yarn.lock"] = {
			icon = "",
			color = "#ea5e5e",
			cterm_color = "240",
			name = "yarnlock",
		},
		["yarn-error.log"] = {
			icon = "",
			color = "#3d85c6",
			cterm_color = "240",
			name = "yarnerror",
		},
		[".eslintrc.json"] = {
			icon = "󰱺",
			color = "#4746a8",
			cterm_color = "240",
			name = "eslintrc",
		},
		["jest.config.js"] = {
			icon = "󰙨",
			color = "#e37575",
			cterm_color = "220",
			name = "jestconfig",
		},
	},
})
