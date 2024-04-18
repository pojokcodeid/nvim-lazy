local opts = {
	setup = {
		root_dir = require("lspconfig.util").root_pattern("package.json", "vue.config.js")
			or vim.loop.cwd()
			or vim.fn.getcwd(),
		init_options = {
			config = {
				vetur = {
					completion = {
						autoImport = true,
						tagCasing = "kebab",
						useScaffoldSnippets = true,
					},
					useWorkspaceDependencies = true,
					validation = {
						script = true,
						style = true,
						template = true,
					},
				},
			},
		},
	},
}
return opts
