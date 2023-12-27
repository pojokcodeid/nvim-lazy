if vim.g.vscode then
	-- config vscode
	Map = vim.keymap.set
	Cmd = vim.cmd
	VSCodeNotify = vim.fn.VSCodeNotify
	VSCodeCall = vim.fn.VSCodeCall

	require("vscode.functions")
	require("vscode.mappings")
else
	-- config neovim
	require("core")
end
