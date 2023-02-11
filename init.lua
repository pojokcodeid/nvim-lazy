local onsave = true
require("user.options")
require("config.lazy")
require("user.keymaps")
require("user.autocommands")
require("user.colorscheme")
require("user.snip")
require("user.bufferline")
if onsave then
	require("user.format_onsave")
end
-- require("user.chat_gpt")
