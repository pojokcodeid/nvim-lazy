if vim.g.vscode then
	Map = vim.keymap.set
	Cmd = vim.cmd
	VSCodeNotify = vim.fn.VSCodeNotify
	VSCodeCall = vim.fn.VSCodeCall

	-- require("vscode.options")
	require("vscode.functions")
	require("vscode.mappings")
-- vim.cmd([[source C:\\Users\\Asep\\AppData\\Local\\nvim\\settings.vim]])
else
	require("core")
end
