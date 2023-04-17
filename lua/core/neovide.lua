if vim.g.neovide then
	vim.g.neovide_input_use_logo = 1 -- enable use of the logo (cmd) key
	vim.keymap.set("n", "<c-s>", ":w<CR>") -- Save
	vim.keymap.set("v", "<c-c>", '"+y') -- Copy
	vim.keymap.set("n", "<c-v>", '"+P') -- Paste normal mode
	vim.keymap.set("v", "<c-v>", '"+P') -- Paste visual mode
	vim.keymap.set("c", "<c-v>", "<C-R>+") -- Paste command mode
	vim.keymap.set("i", "<c-v>", '<ESC>l"+Pli') -- Paste insert mode

	vim.o.guifont = "JetBrainsMono_Nerd_Font:h17"
	vim.g.neovide_padding_top = 0
	vim.g.neovide_padding_bottom = 0
	vim.g.neovide_padding_right = 0
	vim.g.neovide_padding_left = 0

	-- config for transparent
	--vim.g.neovide_transparency = 0.8
	vim.g.neovide_transparency = 1

	vim.g.neovide_underline_automatic_scaling = false
	vim.g.neovide_refresh_rate_idle = 5
	vim.g.neovide_no_idle = true
	vim.g.neovide_remember_window_size = true
	vim.g.neovide_touch_drag_timeout = 0.17
	-- animation config
	--vim.g.neovide_scroll_animation_length = 0.3
	--vim.g.neovide_cursor_animation_length = 0.13
	vim.g.neovide_cursor_trail_size = 0.8
	vim.g.neovide_cursor_antialiasing = true
	vim.g.neovide_cursor_animate_in_insert_mode = true
	vim.g.neovide_cursor_vfx_mode = "torpedo"

	vim.opt.cmdheight = 0
end

-- Allow clipboard copy paste in neovim
vim.g.neovide_input_use_logo = 1
vim.api.nvim_set_keymap("", "<c-v>", "+p<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("!", "<c-v>", "<C-R>+", { noremap = true, silent = true })
vim.api.nvim_set_keymap("t", "<c-v>", "<C-R>+", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<c-v>", "<C-R>+", { noremap = true, silent = true })
