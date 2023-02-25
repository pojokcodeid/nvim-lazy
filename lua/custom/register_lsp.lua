-- untuk referesi support language kunjungi link dibawah
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
local m = {
	lspreg = {
		"yamlls",
		"intelephense",
		"marksman",
		"csharp_ls",
		"clangd",
		"dartls",
		"kotlin_language_server",
		-- tambahkan di bawah sini setelah melakukan :masoninstall
	},
	skipreg = {
		"jdtls", -- tambahkan di bawah ini
	},
}
return m
