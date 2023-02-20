local options_ok, _ = pcall(require, "user.options")
if not options_ok then
	return
end
local key_ok, _ = pcall(require, "user.keymaps")
if not key_ok then
	return
end
local cmd_ok, _ = pcall(require, "user.autocommands")
if not cmd_ok then
	return
end
local fmt_ok, _ = pcall(require, "user.format_onsave")
if not fmt_ok then
	return
end

require("user.options")
require("user.keymaps")
require("user.autocommands")
require("user.format_onsave")
return {}
