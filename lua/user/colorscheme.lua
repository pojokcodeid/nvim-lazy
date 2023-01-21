-- local colorscheme = "tokyonight-night"
-- local colorscheme = "gruvbox"
-- local colorscheme = "sonokai"
-- local colorscheme = "nordfox"
local colorscheme = "onedark"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
	return
end
