local web_devicons_ok, web_devicons = pcall(require, "nvim-web-devicons")
if not web_devicons_ok then
	return
end

local material_icon_ok, material_icon = pcall(require, "nvim-material-icon")
if not material_icon_ok then
	return
end
material_icon.setup({
	override = {},
})

web_devicons.setup({
	override = material_icon.get_icons(),
	override_by_filename = {},
})
