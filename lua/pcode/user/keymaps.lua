-- definiskanfunction name
-- local keymap = vim.api.nvim_set_keymap
local keymap = vim.keymap.set
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
  keymap(mode, "<S-M-Down>", "<cmd>t.<cr>", opts)
  keymap(mode, "<S-M-Up>", "<cmd>t -1<cr>", opts)
  -- save file
  keymap(mode, "<C-s>", "<cmd>silent! w<cr>", opts)
end

-- duplicate line visual block
keymap("x", "<S-Down>", ":'<,'>t'><cr>", opts)
keymap("x", "<S-M-Down>", ":'<,'>t'><cr>", opts)
keymap("x", "<S-Up>", ":'<,'>t-1<cr>", opts)
keymap("x", "<S-M-Up>", ":'<,'>t-1<cr>", opts)

-- move text up and down
keymap("x", "<A-Down>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-Up>", ":move '<-2<CR>gv-gv", opts)
keymap("n", "<M-Down>", "<cmd>m+<cr>", opts)
keymap("i", "<M-Down>", "<cmd>m+<cr>", opts)
keymap("n", "<M-Up>", "<cmd>m-2<cr>", opts)
keymap("i", "<M-Up>", "<cmd>m-2<cr>", opts)

-- create comment CTRL + / visual block mode
keymap("x", "<C-_>", function()
  vim.api.nvim_feedkeys("gb", "v", true)
end, opts)
-- create comment CTRL + / normal mode
keymap("i", "<C-_>", function()
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<esc>", true, false, true), "n", true)
  -- Toggle comment baris
  vim.api.nvim_feedkeys("gcc", "v", true)

  -- Tunggu sejenak agar komentar terbentuk
  vim.schedule(function()
    local row = vim.fn.line(".") - 1 -- index dimulai dari 0
    local col = #vim.fn.getline(".") -- panjang baris = akhir kalimat

    -- Geser 2 spasi dari akhir dan masuk insert mode
    vim.api.nvim_win_set_cursor(0, { row + 1, col })
    vim.api.nvim_feedkeys("i", "v", true)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Right><leader>", true, false, true), "n", true)
  end)
end, opts)
-- create comment CTRL + / normal mode
keymap("n", "<C-_>", function()
  -- Toggle comment baris
  vim.api.nvim_feedkeys("gcc", "v", true)

  -- Tunggu sejenak agar komentar terbentuk
  vim.schedule(function()
    local row = vim.fn.line(".") - 1 -- index dimulai dari 0
    local col = #vim.fn.getline(".") -- panjang baris = akhir kalimat

    -- Geser 2 spasi dari akhir dan masuk insert mode
    vim.api.nvim_win_set_cursor(0, { row + 1, col })
    vim.api.nvim_feedkeys("i", "v", true)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Right><leader>", true, false, true), "n", true)
  end)
end, opts)

-- close windows
keymap("n", "q", "<cmd>q<cr>", opts)
keymap("n", "f", "<cmd>NvimTreeFindFileToggle<cr><cr><Up>", opts)

-- window navigation
keymap("n", "<c-h>", "<C-w>h", opts)
keymap("n", "<c-j>", "<C-w>j", opts)
keymap("n", "<c-k>", "<C-w>k", opts)
keymap("n", "<c-l>", "<C-w>l", opts)
keymap("n", "<c-a>", "gg0v$G", opts)
keymap("i", "<c-a>", "<esc>gg0v$G", opts)
keymap("n", "<c-c>", '"+y', opts)
keymap("v", "<c-c>", '"+y', opts)
keymap("x", "<c-c>", '"+y', opts)
keymap("n", "<c-v>", '"+P', opts)
keymap("v", "<c-v>", '"+P', opts)
keymap("i", "<c-v>", "<esc>pa<Left>", opts)
keymap("x", "<c-v>", '"+P', opts)
keymap("n", "<c-z>", "<cmd>undo<CR>", opts)
keymap("x", "<c-z>", "<esc><cmd>undo<CR>", opts)
keymap("v", "<c-z>", "<esc><cmd>undo<CR>", opts)
keymap("i", "<c-z>", "<esc><cmd>undo<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-Left>", "<Esc>:bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)
keymap("n", "<S-Right>", "<Esc>:bprevious<CR>", opts)

-- Reordering Bufferline
keymap("n", "<S-PageUp>", "<cmd>BufferLineMovePrev<cr>", opts)
keymap("n", "<S-PageDown>", "<cmd>BufferLineMoveNext<cr>", opts)

-- Press jk fast to exit insert mode
keymap("i", "jk", "<ESC>", opts)
keymap("i", "kj", "<ESC>", opts)

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- ALT + l to open terminal and run live-server
keymap("n", "<A-l>", "<cmd>terminal live-server<cr>", opts)

-- close current buffer
keymap("n", "<S-t>", "<cmd>lua require('auto-bufferline.configs.utils').bufremove()<cr>", opts)

vim.api.nvim_create_user_command("TSIsInstalled", function()
  local parsers = require("nvim-treesitter.info").installed_parsers()
  table.sort(parsers)
  local choices = {}
  local lookup = {}

  for _, parser in ipairs(parsers) do
    local label = "[✓] " .. parser
    table.insert(choices, label)
    lookup[label] = parser
  end

  vim.ui.select(choices, {
    prompt = "Uninstall Treesitter",
  }, function(choice)
    if choice then
      local parser_name = lookup[choice]
      if parser_name then
        vim.cmd("TSUninstall " .. parser_name)
      end
    end
  end)
end, {})
