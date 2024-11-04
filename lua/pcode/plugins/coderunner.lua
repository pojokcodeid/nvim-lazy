--typescript = "deno run",
-- cpp="gcc $fileName -lstdc++ -o $fileNameWithoutExt && $fileNameWithoutExt"
local pyrun = "python -u"
if vim.fn.has("win32") == 0 then
	pyrun = "python3 -u"
end
local rfile = {
	java = "cd $dir && javac $fileName && java $fileNameWithoutExt",
	python = pyrun,
	typescript = "ts-node $dir/$fileName",
	rust = "cd $dir && rustc $fileName && $dir/$fileNameWithoutExt",
	cpp = "cd $dir && g++ $fileName -o $fileNameWithoutExt && $dir/$fileNameWithoutExt",
	scss = "sass $dir/$fileName $dir/$fileNameWithoutExt.css",
	javascript = 'node "$dir/$fileName"',
	go = "go run .",
}

return {
	"CRAG666/code_runner.nvim",
	lazy = true,
	cmd = { "RunCode", "RunFile", "RunProject", "RunClose" },
	opts = {
		filetype = rfile,
		mode = "float",
		focus = true,
		startinsert = true,
		term = {
			position = "bot",
			size = 50,
		},
		float = {
			close_key = "<ESC>",
			border = "rounded",
			height = 0.8,
			width = 0.8,
			x = 0.5,
			y = 0.5,
			border_hl = "FloatBorder",
			float_hl = "Normal",
			blend = 0,
		},
	},
	config = function(_, opts)
		require("code_runner").setup(opts)
	end,
	keys = {
		{ "<leader>r", "", desc = "  Run", mode = "n" },
		{ "<leader>rr", "<cmd>RunCode<CR>", desc = "Run Code", mode = "n" },
		{ "<leader>rf", "<cmd>RunFile<CR>", desc = "Run File", mode = "n" },
		{ "<leader>rp", "<cmd>RunProject<CR>", desc = "Run Project", mode = "n" },
	},
}
