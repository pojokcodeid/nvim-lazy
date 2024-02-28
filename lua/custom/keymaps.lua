-- custom key maps disini
local function map(mode, l, r, desc)
	vim.keymap.set(mode, l, r, { desc = desc })
end
-- click ctrl + Left mouse buttn to run
map("t", "<C-LeftMouse>", "<cmd>lua print('Run Link')<cr>", "Run Link")
