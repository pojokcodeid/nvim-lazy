local status_ok, smart_splits = pcall(require, "smart-splits")
if not status_ok then
	return
end
smart_splits.setup({
	ignored_filetypes = {
		"nofile",
		"quickfix",
		"qf",
		"prompt",
	},
	ignored_buftypes = { "nofile" },
})

vim.keymap.set("n", "<C-Left>", require("smart-splits").resize_left)
vim.keymap.set("n", "<C-Down>", require("smart-splits").resize_down)
vim.keymap.set("n", "<C-Up", require("smart-splits").resize_up)
vim.keymap.set("n", "<C-Right>", require("smart-splits").resize_right)
