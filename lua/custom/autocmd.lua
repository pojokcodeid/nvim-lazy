local transparent_mode = require("core.config").transparent_mode
if transparent_mode ~= nil then
	if transparent_mode == 1 then
		vim.cmd("TransparentDisable")
		vim.cmd("TransparentEnable")
	end
end
