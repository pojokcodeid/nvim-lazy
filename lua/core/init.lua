local onsave = true
-- require("config.lazy")
require("user.options")
require("user.keymaps")
require("user.autocommands")
-- require("user.colorscheme")
-- require("user.snip")
-- require("user.bufferline")
if onsave then
	require("user.format_onsave")
end
-- require("user.chat_gpt")
