-- autocmd BufWinEnter * :set formatoptions-=cro
-- vim.cmd([[
--   augroup _general_settings
--     autocmd!
--     autocmd FileType qf,help,man,lspinfo nnoremap <silent> <buffer> q :close<CR>
--     autocmd TextYankPost * silent!lua require('vim.highlight').on_yank({higroup = 'Visual', timeout = 200})
--     " autocmd BufWinEnter * :set formatoptions=croql
--     " autocmd BufWinEnter * :set textwidth=80
--     " autocmd BufWinEnter * :set colorcolumn=+1
--     " autocmd BufWinEnter * :set nolazyredraw
--     " autocmd BufWinEnter * :hi ColorColumn guibg=#1B243000 ctermbg=246
--     autocmd FileType qf set nobuflisted
--   augroup end
--
--   augroup _git
--     autocmd!
--     autocmd FileType gitcommit setlocal wrap
--     autocmd FileType gitcommit setlocal spell
--   augroup end
--
--   augroup _markdown
--     autocmd!
--     autocmd FileType markdown setlocal wrap
--     autocmd FileType markdown setlocal spell
--   augroup end
--
--   augroup _auto_resize
--     autocmd!
--     autocmd VimResized * tabdo wincmd =
--   augroup end
--
--   augroup _alpha
--     autocmd!
--     autocmd User AlphaReady set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
--   augroup end
--
--   augroup neovim_terminal
--     autocmd!
--     " Enter Terminal-mode (insert) automatically
--     autocmd TermOpen * startinsert
--     " Disables number lines on terminal buffers
--     autocmd TermOpen * :set nonumber norelativenumber
--     " allows you to use Ctrl-c on terminal window
--     autocmd TermOpen * nnoremap <buffer> <C-c> i<C-c>
--   augroup END
--
--   function s:MkNonExDir(file, buf)
--     if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
--         let dir=fnamemodify(a:file, ':h')
--         if !isdirectory(dir)
--             call mkdir(dir, 'p')
--         endif
--     endif
--     endfunction
--     augroup BWCCreateDir
--     autocmd!
--     autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
--   augroup END
-- ]])

local api = vim.api

-- General Settings
api.nvim_create_augroup("_general_settings", { clear = true })
api.nvim_create_autocmd({ "FileType" }, {
  group = "_general_settings",
  pattern = { "qf", "help", "man", "lspinfo" },
  command = "nnoremap <silent> <buffer> q :close<CR>",
})

api.nvim_create_autocmd("TextYankPost", {
  group = "_general_settings",
  callback = function()
    require("vim.highlight").on_yank({ higroup = "Visual", timeout = 200 })
  end,
})

api.nvim_create_autocmd("FileType", {
  group = "_general_settings",
  pattern = "qf",
  command = "set nobuflisted",
})

-- Git Settings
api.nvim_create_augroup("_git", { clear = true })
api.nvim_create_autocmd("FileType", {
  group = "_git",
  pattern = "gitcommit",
  command = "setlocal wrap spell",
})

-- Markdown Settings
api.nvim_create_augroup("_markdown", { clear = true })
api.nvim_create_autocmd("FileType", {
  group = "_markdown",
  pattern = "markdown",
  command = "setlocal wrap spell",
})

-- Auto Resize
api.nvim_create_augroup("_auto_resize", { clear = true })
api.nvim_create_autocmd("VimResized", {
  group = "_auto_resize",
  command = "tabdo wincmd =",
})

-- Alpha Settings
api.nvim_create_augroup("_alpha", { clear = true })
api.nvim_create_autocmd("User", {
  group = "_alpha",
  pattern = "AlphaReady",
  command = "set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2",
})

-- Terminal Settings
api.nvim_create_augroup("neovim_terminal", { clear = true })
api.nvim_create_autocmd("TermOpen", {
  group = "neovim_terminal",
  command = "startinsert | set nonumber norelativenumber | nnoremap <buffer> <C-c> i<C-c>",
})

-- Function to Create Non-Existent Directory on BufWrite
local function MkNonExDir(file, buf)
  if vim.fn.empty(vim.fn.getbufvar(buf, "&buftype")) == 1 and not string.match(file, "^%w+://") then
    local dir = vim.fn.fnamemodify(file, ":h")
    if vim.fn.isdirectory(dir) == 0 then
      vim.fn.mkdir(dir, "p")
    end
  end
end

api.nvim_create_augroup("BWCCreateDir", { clear = true })
api.nvim_create_autocmd("BufWritePre", {
  group = "BWCCreateDir",
  callback = function(_)
    MkNonExDir(vim.fn.expand("<afile>"), vim.fn.expand("<abuf>"))
  end,
})

-- for fix error last close buffer
vim.api.nvim_create_autocmd({ "QuitPre" }, {
  callback = function()
    vim.cmd("NvimTreeClose")
  end,
})

local autocmd = vim.api.nvim_create_autocmd
autocmd("VimEnter", {
  pattern = "*",
  callback = function()
    vim.opt.statusline = "%#normal# "
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "help", "alpha", "dashboard", "NvimTree", "Trouble", "lazy", "mason", "neotest-summary" },
  callback = function()
    vim.b.miniindentscope_disable = true
  end,
})

vim.filetype.add({
  pattern = {
    [".*%.blade%.php"] = "blade",
  },
})

-- config cursor
vim.opt.guicursor = {
  "n-v:block", -- Normal, Visual, Command mode: block cursor
  "i-ci-ve-c:ver25", -- Insert, Command-line Insert, Visual mode: vertical bar cursor
  "r-cr:hor20", -- Replace, Command-line Replace mode: horizontal bar cursor
  "o:hor50", -- Operator-pending mode: horizontal bar cursor
  "a:blinkwait700-blinkoff400-blinkon250", -- Blinking settings
  "sm:block-blinkwait175-blinkoff150-blinkon175", -- Select mode: block cursor with blinking
}

-- Autoformat
-- augroup _lsp
--   autocmd!
--   autocmd BufWritePre * lua vim.lsp.buf.formatting()
-- augroup end
