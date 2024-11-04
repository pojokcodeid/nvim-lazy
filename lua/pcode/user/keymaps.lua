-- definiskanfunction name
local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Remap space leader keys
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- MODES
-- mormal mode = "n"
-- insert mode = "i"
-- visual mode = "v"
-- visual block mode = "x"
-- term mode = "t"
-- command mode = "c"

for _, mode in ipairs({ "i", "v", "n", "x" }) do
	-- duplicate line
	keymap(mode, "<S-Down>", "<cmd>t.<cr>", opts)
	keymap(mode, "<S-Up>", "<cmd>t -1<cr>", opts)
	-- save file
	keymap(mode, "<C-s>", "<cmd>silent! w<cr>", opts)
end
-- duplicate line visual block
keymap("x", "<S-Down>", ":'<,'>t'><cr>", opts)
keymap("x", "<S-Up>", ":'<,'>t-1<cr>", opts)
-- move text up and down
keymap("x", "<A-Down>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-Up>", ":move '<-2<CR>gv-gv", opts)
keymap("n", "<M-Down>", "<cmd>m+<cr>", opts)
keymap("i", "<M-Down>", "<cmd>m+<cr>", opts)
keymap("n", "<M-Up>", "<cmd>m-2<cr>", opts)
keymap("i", "<M-Up>", "<cmd>m-2<cr>", opts)
-- create comment CTRL + / all mode
keymap("v", "<C-_>", "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>", opts)
keymap("v", "<C-/>", "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>", opts)
keymap("i", "<C-_>", "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>", opts)
keymap("i", "<C-/>", "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>", opts)
keymap("i", "<C-_>", "<esc><cmd>lua require('Comment.api').toggle.linewise.current()<cr>", opts)
keymap("i", "<C-/>", "<esc><cmd>lua require('Comment.api').toggle.linewise.current()<cr>", opts)
keymap("n", "<C-_>", "<esc><cmd>lua require('Comment.api').toggle.linewise.current()<cr>", opts)
keymap("n", "<C-/>", "<esc><cmd>lua require('Comment.api').toggle.linewise.current()<cr>", opts)

-- close windows
keymap("n", "q", "<cmd>q<cr>", opts)
keymap("n", "f", "<cmd>NvimTreeFindFileToggle<cr><cr><Up>", opts)
