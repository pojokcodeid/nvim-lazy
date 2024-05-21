local colorscheme = vim.g.pcode_colorscheme
local lst_style = {
	"sonokai",
	"sonokai_atlantis",
	"sonokai_andromeda",
	"sonokai_shusia",
	"sonokai_maia",
	"sonokai_espresso",
}
local lst_material = {
	"material",
	"material_deepocean",
	"material_palenight",
	"material_lighter",
	"material_darker",
}
local lst_onedark = {
	"onedark",
	"onedark_darker",
	"onedark_cool",
	"onedark_deep,onedark_warm",
	"onedark_warmer",
	"onedark_light",
}

local transparent_mode = vim.g.pcode_transparent_mode
if transparent_mode ~= nil then
	if transparent_mode == 1 then
		vim.g.gruvbox_baby_transparent_mode = 1
		vim.g.sonokai_transparent_background = 2
	end
end

for _, v in pairs(lst_style) do
	if v == colorscheme then
		colorscheme = "sonokai"
		break
	end
end
for _, v in pairs(lst_material) do
	if v == colorscheme then
		colorscheme = "material"
		break
	end
end
for _, v in pairs(lst_onedark) do
	if v == colorscheme then
		colorscheme = "onedark"
		break
	end
end

vim.cmd("colorscheme " .. colorscheme)
