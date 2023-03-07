local config

-- shim vim for kitty and other generators
vim = vim or { g = {}, o = {} }

local function opt(key, default)
	key = "pcode_" .. key
	if vim.g[key] == nil then
		return default
	end
	-- if vim.g[key] == 0 then
	-- 	return false
	-- end
	return vim.g[key]
end

config = {
	colorscheme = opt("colorscheme", "gruvbox-baby"),
	transparent_mode = opt("transparent_mode", 0),
	progress = opt("progress", 2),
	lualine_style = opt("lualine_style", 0),
	status_icon = opt("status_icon", 0),
	custom_lualine = opt("custom_lualine", false),
	component_separators = opt("component_separators", { left = " ", right = " " }),
	section_separators = opt("section_separators", { left = " ", right = " " }),
	header1 = opt("header1", nil),
	header2 = opt("header2", nil),
	footer = opt("footer", nil),
	model = opt("model", 1),
	format_on_save = opt("format_on_save", 1),
	lsp_installer = opt("lsp_installer", {}),
	mason_ensure_installed = opt("mason_ensure_installed", {}),
	unregister_lsp = opt("unregister_lsp", {}),
	null_ls_sources = opt("null_ls_sources", {}),
	whichkey = opt("whichkey", {}),
	coderunner = opt("coderunner", {}),
	null_ls_ensure_installed = opt("null_ls_ensure_installed", {}),
	dap_ensure_installed = opt("dap_ensure_installed", {}),
	cmprg = opt("cmprg", false),
	cmpcalc = opt("cmpcalc", false),
	cmptag = opt("cmptag", false),
	lsp_virtualtext = opt("lsp_virtualtext", false),
	lspghost_text = opt("lspghost_text", false),
	loadnvimtree_lazy = opt("loadnvimtree_lazy", false),
}

return config
