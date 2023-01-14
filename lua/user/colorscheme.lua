local colorscheme = "tokyonight-night"
-- local colorscheme = "nord"
-- local colorscheme = "lunar"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
	return
end
