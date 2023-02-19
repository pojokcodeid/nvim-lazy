local null_ls = require("null-ls")
local formatting = null_ls.builtins.formatting
local m = {
	sources = {
		formatting.stylua, -- tambahkan di bawah sini
	},
}
return m
