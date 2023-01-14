local onsave = true
require("user.options")
require("config.lazy")
require("user.keymaps")
require("user.autocommands")
require("user.colorscheme")
require("user.snip")
if onsave then
	require("user.format_onsave")
end

-- dipindah ke plugins
-- require("user.lualine")
-- require("user.bufferline")
-- require("user.cmp")
-- require("user.lsp")
