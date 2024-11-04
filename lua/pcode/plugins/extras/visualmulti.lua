return {
	"mg979/vim-visual-multi",
	event = { "BufRead", "InsertEnter", "BufNewFile" },
	branch = "master",
	lazy = true,
	init = function()
		vim.g.VM_mouse_mappings = 1 -- equal CTRL + Left Click on VSCODE
		vim.g.VM_maps = {
			["Find Under"] = "<C-d>", -- equal CTRL+D on VSCODE
			["Find Subword Under"] = "<C-d>", -- equal CTRL+D on VSCODE
			["Select Cursor Down"] = "<M-C-Down>", -- equal CTRL+ALT+DOWN on VSCODE
			["Select Cursor Up"] = "<M-C-Up>", -- equal CTRL+ALT+UP on VSCODE
			["Undo"] = "u", -- undo
			["Redo"] = "<C-r>", -- redo
		}
	end,
}
