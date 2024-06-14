local transparent_mode = pcode.transparent_mode or 0
if transparent_mode ~= nil then
  if transparent_mode == 1 then
    vim.cmd "TransparentDisable"
    vim.cmd "TransparentEnable"
  end
end

-- get folder name from current directory
local _get_folder_name = function()
  local str = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
  return " " .. str:lower():gsub("^%l", string.upper) .. " "
end

local term_program = vim.fn.getenv "TERM_PROGRAM"
if term_program == "WezTerm" then
  -- vim.cmd('silent !wezterm cli set-tab-title "' .. _get_folder_name() .. '"')
  -- create autocmd on insertEnter
  vim.api.nvim_create_autocmd("BufRead", {
    group = vim.api.nvim_create_augroup("BufRead", { clear = true }),
    command = 'silent !wezterm cli set-tab-title "' .. _get_folder_name() .. '"',
    desc = "Set Folder Name",
  })
end

vim.api.nvim_create_autocmd("ExitPre", {
  group = vim.api.nvim_create_augroup("Exit", { clear = true }),
  command = "set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175,a:ver90",
  desc = "Set cursor back to beam when leaving Neovim.",
})

-- config for vim-visual-multi color selection
vim.g.VM_Mono_hl = "DiffText"
vim.g.VM_Extend_hl = "DiffAdd"
-- vim.g.VM_Cursor_hl = "Visual"
vim.g.VM_Cursor_hl = "DiffText"
vim.g.VM_Insert_hl = "DiffChange"

-- NvimTree automatically resize the floating window when neovim's window size changes
-- local tree_api = require("nvim-tree")
-- local tree_view = require("nvim-tree.view")
--
-- vim.api.nvim_create_augroup("NvimTreeResize", {
-- 	clear = true,
-- })
--
-- vim.api.nvim_create_autocmd({ "VimResized" }, {
-- 	group = "NvimTreeResize",
-- 	callback = function()
-- 		if tree_view.is_visible() then
-- 			tree_view.close()
-- 			tree_api.open()
-- 		end
-- 	end,
-- })
