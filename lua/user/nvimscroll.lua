local status_ok, scrollview = pcall(require, "scrollview")
if not status_ok then
	return
end
scrollview.setup({
	bg = "LightCyan",
	ctermbg = 160,
})
vim.g.scrollview_excluded_filetypes = { "NvimTree", "vista_kind", "Outline", "neo-tree" }
