local transparent_mode = require("core.config").transparent_mode
if transparent_mode ~= nil then
	if transparent_mode == 1 then
		vim.cmd("TransparentDisable")
		vim.cmd("TransparentEnable")
	end
end

-- get folder name from current directory
local _get_folder_name = function()
	local str = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
	return " 󱧶  " .. str:lower():gsub("^%l", string.upper) .. " "
end

local term_program = vim.fn.getenv("TERM_PROGRAM")
if term_program == "WezTerm" then
	vim.cmd('silent !wezterm cli set-tab-title "' .. _get_folder_name() .. '"')
end

-- vim.cmd([[
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
