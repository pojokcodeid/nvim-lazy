return {
	{
		"nvim-treesitter/nvim-treesitter",
		-- build = ":TSUpdate",
		-- event = "BufReadPost",
		---@type TSConfig
		opts = {
			sync_install = false,
			highlight = { enable = true },
			autopairs = {
				enable = true,
			},
			indent = { enable = true, disable = { "python", "css" } },
			autotag = { enable = true },
			incremental_selection = { enable = true },
			rainbow = {
				enable = true,
				disable = { "html" },
				extended_mode = false,
				max_file_lines = nil,
			},
			context_commentstring = {
				enable = true,
				enable_autocmd = false,
				config = {
					-- Languages that have a single comment style
					typescript = "// %s",
					css = "/* %s */",
					scss = "/* %s */",
					html = "<!-- %s -->",
					svelte = "<!-- %s -->",
					vue = "<!-- %s -->",
					json = "",
				},
			},
			ensure_installed = {
				"bash",
				"html",
				-- "c",
				-- "javascript",
				-- "json",
				-- "lua",
				-- "python",
				-- "typescript",
				-- "tsx",
				-- "css",
				-- "rust",
				-- "java",
				-- "yaml",
				-- "markdown",
				-- "markdown_inline",
			},
		},
		---@param opts TSConfig
		config = function(plugin, opts)
			if plugin.ensure_installed then
				require("lazyvim.util").deprecate("treesitter.ensure_installed", "treesitter.opts.ensure_installed")
			end
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
}
