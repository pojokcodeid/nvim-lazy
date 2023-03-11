local null_ls = require("null-ls")
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local m = {
	sources = {
		formatting.stylua, -- tambahkan di bawah sini
		diagnostics.flake8, -- tambahkan di bawah sini
	},
}
return m
