local status_ok = pcall(require, "luasnip")
if not status_ok then
	return
end

local lpath = vim.fn.stdpath("config") .. "/snippets"
require("luasnip.loaders.from_vscode").lazy_load({ paths = lpath })
require("luasnip.loaders.from_vscode").load({ paths = lpath })
