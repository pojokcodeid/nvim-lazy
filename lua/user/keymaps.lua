local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
-- keymap("n", "<C-Up>", ":resize -2<CR>", opts)
-- keymap("n", "<C-Down>", ":resize +2<CR>", opts)
-- keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
-- keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Move text up and down
keymap("n", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
keymap("n", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)

-- Insert --
-- Press jk fast to exit insert mode
keymap("i", "jk", "<ESC>", opts)
keymap("i", "kj", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-Down>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-Up>", ":move '<-2<CR>gv-gv", opts)

keymap("n", "<S-Down>", "<cmd>t.<cr>", opts)
keymap("i", "<S-Down>", "<cmd>t.<cr>", opts)
keymap("n", "<S-Up>", "<cmd>t -1<cr>", opts)
keymap("i", "<S-Up>", "<cmd>t -1<cr>", opts)
keymap("n", "<M-J>", "<cmd>t.<cr>", opts)
keymap("n", "<M-K>", "<cmd>t -1<cr>", opts)
keymap("n", "<M-Down>", "<cmd>m+<cr>", opts)
keymap("i", "<M-Down>", "<cmd>m+<cr>", opts)
keymap("n", "<M-Up>", "<cmd>m-2<cr>", opts)
keymap("i", "<M-Up>", "<cmd>m-2<cr>", opts)
keymap("n", "<M-j>", "<cmd>m+<cr>", opts)
keymap("n", "<M-k>", "<cmd>m-2<cr>", opts)
keymap("i", "<C-s>", "<cmd>w<cr>", opts)
keymap("n", "<C-s>", "<cmd>w<cr>", opts)
keymap("i", "<C-l>", "<cmd>LiveServer start<cr><cr>", opts)
keymap("n", "q", "<cmd>q<cr>", opts)
keymap("x", "<S-Down>", ":'<,'>t'><cr>", opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

local map = function(mode, lhs, rhs, desc)
	if desc then
		desc = desc
	end
	vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc, buffer = bufnr, noremap = true })
end
-- if pcall(require, "dap") then
-- modified function keys found with `showkey -a` in the terminal to get key code
-- run `nvim -V3log +quit` and search through the "Terminal info" in the `log` file for the correct keyname
if vim.fn.has("win32") == 0 then
	map("n", "<F5>", function()
		require("dap").continue()
	end, "")
	map("n", "<F17>", function()
		require("dap").terminate()
	end, "") -- Shift+F5
	map("n", "<F29>", function()
		require("dap").restart_frame()
	end, "") -- Control+F5
	map("n", "<F6>", function()
		require("dap").pause()
	end, "")
	map("n", "<F9>", function()
		require("dap").toggle_breakpoint()
	end, "")
	map("n", "<F10>", function()
		require("dap").step_over()
	end, "")
	map("n", "<F11>", function()
		require("dap").step_into()
	end, "")
	map("n", "<F23>", function()
		require("dap").step_out()
	end, "") -- Shift+F11
end

-- Terminal --
-- Better terminal navigation
-- keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
-- keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
-- keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
-- keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)
