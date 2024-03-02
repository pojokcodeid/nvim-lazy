return {
	-- add cmd
	cmd = { "deno", "lsp" },
	-- add file type support
	filetypes = {
		"javascript",
		"javascriptreact",
		"javascript.jsx",
		"typescript",
		"typescriptreact",
		"typescript.tsx",
	},
	-- add root dir support
	root_dir = require("lspconfig.util").root_pattern(
		"package.json",
		"tsconfig.json",
		"jsconfig.json",
		"deno.json",
		"deno.jsonc",
		".git"
	),
	-- add settings
	settings = {
		deno = {
			enable = true,
			suggest = {
				imports = {
					hosts = {
						["https://deno.land"] = true,
					},
				},
			},
		},
	},
}
