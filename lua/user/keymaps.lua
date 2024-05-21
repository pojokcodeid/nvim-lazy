local opts = { noremap = true, silent = true }

function _LIVE_SERVER()
  local Terminal = require("toggleterm.terminal").Terminal
  local live_server = Terminal:new {
    cmd = "live-server",
    hidden = true,
    direction = "tab",
  }
  live_server:toggle()
end

function _CLOSE_BUFFER()
  local buf = vim.api.nvim_get_current_buf()
  --  delete current buffer
  require("bufdelete").bufdelete(buf, true)
end

function _OPEN_ALACRITTY()
  -- open alacritty new windows current directory
  vim.cmd("silent !alacritty --working-directory " .. vim.fn.getcwd())
end

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
keymap("n", "<C-A>", "gg0v$G", opts)
keymap("i", "<C-A>", "<esc>gg0v$G", opts)
keymap("n", "<C-c>", '"+y', opts)
keymap("v", "<C-c>", '"+y', opts)
keymap("x", "<C-c>", '"+y', opts)
keymap("n", "<C-v>", '"+P', opts)
keymap("v", "<C-v>", '"+P', opts)
keymap("i", "<C-v>", "<esc>pa<Left>", opts)
keymap("x", "<C-v>", '"+P', opts)
keymap("n", "<C-Z>", "<cmd>undo<CR>", opts)
keymap("x", "<C-Z>", "<esc><cmd>undo<CR>", opts)
keymap("v", "<C-Z>", "<esc><cmd>undo<CR>", opts)
keymap("i", "<C-Z>", "<esc><cmd>undo<CR>", opts)
-- create comment CTRL + / all mode
keymap("n", "<C-_>", "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>", opts)
keymap("n", "<C-/>", "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>", opts)
keymap("v", "<C-_>", "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>", opts)
keymap("v", "<C-/>", "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>", opts)
keymap("i", "<C-_>", "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>", opts)
keymap("i", "<C-/>", "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>", opts)
keymap("i", "<C-_>", "<esc><cmd>lua require('Comment.api').toggle.linewise.current()<cr>i", opts)
keymap("i", "<C-/>", "<esc><cmd>lua require('Comment.api').toggle.linewise.current()<cr>i", opts)
keymap("n", "<C-_>", "<esc><cmd>lua require('Comment.api').toggle.linewise.current()<cr>i", opts)
keymap("n", "<C-/>", "<esc><cmd>lua require('Comment.api').toggle.linewise.current()<cr>i", opts)
-- keymap("n", "<C-l>", "<esc><cmd>lua _LIVE_SERVER()<cr>", opts)
-- keymap("i", "<C-l>", "<esc><cmd>lua _LIVE_SERVER()<cr>", opts)

-- ALT + l to open terminal and run live-server
keymap("n", "<A-l>", "<cmd>terminal live-server<cr>", opts)

-- Resize with arrows
-- cona
-- keymap("n", "<C-Down>", ":resize +2<CR>", opts)
-- keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
-- keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-Left>", "<Esc>:bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)
keymap("n", "<S-Right>", "<Esc>:bprevious<CR>", opts)
-- Reordering Bufferline
keymap("n", "<S-PageUp>", "<cmd>BufferLineMovePrev<cr>", opts)
keymap("n", "<S-PageDown>", "<cmd>BufferLineMoveNext<cr>", opts)

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
keymap("n", "q", "<cmd>q<cr>", opts)
keymap("x", "<S-Down>", ":'<,'>t'><cr>", opts)

-- keymap("i", "<C-r>", "<cmd>RunFile<CR>", opts)
-- keymap("n", "<C-r>", "<cmd>RunFile<CR>", opts)

-- close current buffer
keymap("n", "<S-t>", "<cmd>lua _CLOSE_BUFFER()<cr>", opts)
-- open alacritty terminal
-- keymap("n", "<A-a>", "<cmd>lua _OPEN_ALACRITTY()<cr>", opts)

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
  vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc, buffer = 0, noremap = true })
end
-- if pcall(require, "dap") then
-- modified function keys found with `showkey -a` in the terminal to get key code
-- run `nvim -V3log +quit` and search through the "Terminal info" in the `log` file for the correct keyname
if vim.fn.has "win32" == 0 then
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

-- vim.keymap.set("n", "<C-Left>", require("smart-splits").resize_left)
-- vim.keymap.set("n", "<C-Down>", require("smart-splits").resize_down)
-- vim.keymap.set("n", "<C-Up", require("smart-splits").resize_up)
-- vim.keymap.set("n", "<C-Right>", require("smart-splits").resize_right)
