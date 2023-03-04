local colorscheme = "gruvbox-baby"
local data_exists, custom_ui = pcall(require, "custom.ui")
if data_exists then
	if type(custom_ui) == "table" then
		local color = custom_ui.colorscheme
		if color ~= nil then
			colorscheme = color
		else
			colorscheme = "gruvbox-baby"
		end
		local transparent_mode = custom_ui.transparent_mode
		if transparent_mode ~= nil then
			if transparent_mode == 1 then
				vim.g.gruvbox_baby_transparent_mode = 1
			end
		end
	end
end
local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
	local ok, _ = pcall(vim.cmd, "colorscheme " .. "gruvbox-baby")
	if not ok then
		return
	end
end
