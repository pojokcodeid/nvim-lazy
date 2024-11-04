return {
	"LunarVim/bigfile.nvim",
	lazy = true,
	event = "BufReadPre",
	opts = {
		file_size = 2,
	},
}
