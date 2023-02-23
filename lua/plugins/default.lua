
local opts, _ = pcall(require, "user.options")
if opts then
	require("user.options")
end
-- local key, _ = pcall(require, "user.keymaps")
-- if key then
-- 	require("user.keymaps")
-- end
local cmd, _ = pcall(require, "user.autocommands")
if cmd then
	require("user.autocommands")
end
local onsave, _ = pcall(require, "user.format_onsave")
if onsave then
	require("user.format_onsave")
end
return {}
