local alpha = require("alpha")
local startify = require("alpha.themes.startify")
local dash_model = {}
dash_model = {
	[[                _      __                __    ]],
	[[    ___ ___    (____  / /__  _______ ___/ ___  ]],
	[[   / _ / _ \  / / _ \/  '_/ / __/ _ / _  / -_) ]],
	[[  / .__\_____/ /\___/_/\_\  \__/\___\_,_/\__/  ]],
	[[ /_/      |___/                                ]],
}

local data_exists, custom_dasboard = pcall(require, "core.config")
if data_exists then
	local board = custom_dasboard.header1
	if board ~= nil then
		dash_model = board
	end
end
startify.section.header.val = dash_model
startify.section.top_buttons.val = {
	startify.button("f", "  Find file", ":Telescope find_files <CR>"),
	startify.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
	startify.button("p", "  Find project", ":Telescope projects <CR>"),
	startify.button("r", "  Recently used files", ":Telescope oldfiles <CR>"),
	startify.button("t", "  Find text", ":Telescope live_grep <CR>"),
	startify.button("c", "  Configuration", ":e $MYVIMRC <CR>"),
	startify.button("z", "鈴 Lazy", ":Lazy<CR>"),
	-- startify.button("q", "  Quit Neovim", ":qa<CR>"),
}
-- disable MRU
startify.section.mru.val = { { type = "padding", val = 4 } }
-- disable MRU cwd
startify.section.mru_cwd.val = { { type = "padding", val = 0 } }
-- disable nvim_web_devicons
startify.nvim_web_devicons.enabled = false
-- startify.nvim_web_devicons.highlight = false
-- startify.nvim_web_devicons.highlight = 'Keyword'
--
startify.section.bottom_buttons.val = {
	startify.button("q", "  Quit NVIM", ":qa<CR>"),
}

local footer_text = "Pojok Code"
if data_exists then
	local data_txt = custom_dasboard.footer
	if data_txt ~= nil then
		footer_text = data_txt
	end
end
startify.section.footer.val = {
	{ type = "text", val = footer_text },
}
-- ignore filetypes in MRU
startify.mru_opts.ignore = function(path, ext)
	return (string.find(path, "COMMIT_EDITMSG")) or (vim.tbl_contains(default_mru_ignore, ext))
end
alpha.setup(startify.config)
