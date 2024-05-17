local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

keymap("n", "]h", '<cmd>lua print("Testing")<cr>', opts)
keymap("n", "f", "<cmd>NvimTreeFindFileToggle<cr><cr><Up>", opts)

-- Allow clipboard copy paste in neovim
vim.api.nvim_set_keymap("", "<C-v>", "+p<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("!", "<C-v>", "<C-R>+", { noremap = true, silent = true })
vim.api.nvim_set_keymap("t", "<C-v>", "<C-R>+", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<C-v>", "<C-R>+", { noremap = true, silent = true })
