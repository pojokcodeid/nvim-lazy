local M = {}
function M.bufremove(buf)
	buf = buf or 0
	buf = buf == 0 and vim.api.nvim_get_current_buf() or buf

	if vim.bo.modified then
		local choice = vim.fn.confirm(("Save changes to %q?"):format(vim.fn.bufname()), "&Yes\n&No\n&Cancel")
		if choice == 0 then -- Cancel
			return
		end
		if choice == 1 then -- Yes
			vim.cmd.write()
		end
	end

	for _, win in ipairs(vim.fn.win_findbuf(buf)) do
		vim.api.nvim_win_call(win, function()
			if not vim.api.nvim_win_is_valid(win) or vim.api.nvim_win_get_buf(win) ~= buf then
				return
			end
			-- Try using alternate buffer
			local alt = vim.fn.bufnr("#")
			if alt ~= buf and vim.fn.buflisted(alt) == 1 then
				vim.api.nvim_win_set_buf(win, alt)
				return
			end

			-- Try using previous buffer
			local has_previous = pcall(vim.cmd, "bprevious")
			if has_previous and buf ~= vim.api.nvim_win_get_buf(win) then
				return
			end

			-- Create new listed buffer
			local new_buf = vim.api.nvim_create_buf(true, false)
			vim.api.nvim_win_set_buf(win, new_buf)
		end)
	end
	if vim.api.nvim_buf_is_valid(buf) then
		pcall(vim.cmd, "bdelete! " .. buf)
	end
end

function M._LAZYGIT_TOGGLE()
	local Terminal = require("toggleterm.terminal").Terminal
	local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })
	lazygit:toggle()
end

function M._NODE_TOGGLE()
	local Terminal = require("toggleterm.terminal").Terminal
	local node = Terminal:new({ cmd = "node", hidden = true })
	node:toggle()
end

function M._BTOP_TOGGLE()
	local Terminal = require("toggleterm.terminal").Terminal
	local htop = Terminal:new({ cmd = "btop", hidden = true })
	htop:toggle()
end

function M._PYTHON_TOGGLE()
	local Terminal = require("toggleterm.terminal").Terminal
	local python = Terminal:new({ cmd = "python", hidden = true })
	python:toggle()
end

function M._NEWTAB_TOGGLE()
	local Terminal = require("toggleterm.terminal").Terminal
	local pwsh = Terminal:new({ cmd = "pwsh", hidden = true, direction = "tab" })
	pwsh:toggle()
end

function M._OPEN_EXPLORER()
	local Terminal = require("toggleterm.terminal").Terminal
	local pwsh = Terminal:new({ cmd = "explorer .", hidden = true, direction = "tab" })
	pwsh:toggle()
end

function M._LIVE_SERVER()
	local Terminal = require("toggleterm.terminal").Terminal
	local live_server = Terminal:new({
		cmd = "live-server",
		hidden = true,
		direction = "tab",
	})
	live_server:toggle()
end

function M._OPEN_ALACRITTY()
	-- open alacritty new windows current directory
	vim.cmd("silent !alacritty --working-directory " .. vim.fn.getcwd())
end

function M._OPEN_WEZTERM()
	-- open wezterm new windows current directory
	vim.cmd("silent !wezterm start --cwd " .. vim.fn.getcwd())
end

-- get folder name from current directory
function M._get_folder_name()
	return vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
end

function M._OPEN_WEZTERM_TAB()
	-- open new tab wezterm current directory
	vim.cmd('silent !wezterm cli spawn --cwd "' .. vim.fn.getcwd() .. '"')
end

function M._SET_TAB_TITLE()
	-- set tab title
	vim.cmd('silent !wezterm cli set-tab-title "' .. _get_folder_name() .. '"')
end

function M._CLOSE_BUFFER()
	local buf = vim.api.nvim_get_current_buf()
	--  delete current buffer
	require("bufdelete").bufdelete(buf, true)
end

-- function for close all bufferline
function M._CLOSE_ALL_BUFFER()
	-- get all buffer
	local bufs = vim.api.nvim_list_bufs()
	-- loop through all buffer
	for _, buf in pairs(bufs) do
		require("user.utils").bufdelete(buf)
	end
end

return M
