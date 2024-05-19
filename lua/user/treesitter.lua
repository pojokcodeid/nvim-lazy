local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	return
end
configs.setup({
	ensure_installed = {
		"lua",
		"vim",
	},
	ignore_install = { "phpdoc" }, -- List of parsers to ignore installing
	highlight = {
		enable = true,
		disable = { "css" }, -- list of language that will be disabled
		additional_vim_regex_highlighting = false,
	},
	-- context_commentstring = {
	-- 	enable = true,
	-- enable_autocmd = false,
	-- config = {
	-- Languages that have a single comment style
	-- typescript = "// %s",
	-- css = "/* %s */",
	-- scss = "/* %s */",
	-- html = "<!-- %s -->",
	-- svelte = "<!-- %s -->",
	-- vue = "<!-- %s -->",
	-- jsx = "{/* %s */}",
	-- json = "",
	-- },
	-- },
	-- rainbow = {
	-- 	enable = true,
	-- 	disable = { "html", "tsx" },
	-- 	equery = "rainbow-parens",
	-- 	strategy = require("ts-rainbow").strategy.global,
	-- },
	-- rainbow = {
	-- 	enable = false,
	-- 	extended_mode = true, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
	-- 	max_file_lines = 1000, -- Do not enable for files with more than 1000 lines, int
	-- },
	-- autotag = { enable = true, enable_rename = true, enable_close = true, enable_close_on_slash = true },
	incremental_selection = { enable = true },
	indent = { enable = true, disable = { "python", "css" } },
	autopairs = {
		enable = true,
	},
})
