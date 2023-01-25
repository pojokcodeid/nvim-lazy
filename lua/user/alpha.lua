local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
	return
end

local board = {
	[[             _       _                    _      ]],
	[[            (_)     | |                  | |     ]],
	[[ _ __   ___  _  ___ | | __   ___ ___   __| | ___ ]],
	[[| '_ \ / _ \| |/ _ \| |/ /  / __/ _ \ / _` |/ _ \]],
	[[| |_) | (_) | | (_) |   <  | (_| (_) | (_| |  __/]],
	[[| .__/ \___/| |\___/|_|\_\  \___\___/ \__,_|\___|]],
	[[| |        _/ |                                  ]],
	[[|_|       |__/                                   ]],
}

local data_exists, custom_dasboard = pcall(require, "custom.dashboard")
if data_exists then
	if type(custom_dasboard) == "table" then
		local data_board = custom_dasboard.dashboard
		if data_board ~= nil then
			board = data_board
		end
	end
end

local dashboard = require("alpha.themes.dashboard")
dashboard.section.header.val = board
dashboard.section.buttons.val = {
	dashboard.button("f", "  Find file", ":Telescope find_files <CR>"),
	dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
	dashboard.button("p", "  Find project", ":Telescope projects <CR>"),
	dashboard.button("r", "  Recently used files", ":Telescope oldfiles <CR>"),
	dashboard.button("t", "  Find text", ":Telescope live_grep <CR>"),
	dashboard.button("c", "  Configuration", ":e $MYVIMRC <CR>"),
	dashboard.button("z", "鈴 Lazy", ":Lazy<CR>"),
	dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
}

local function footer()
	-- NOTE: requires the fortune-mod package to work
	-- local handle = io.popen("fortune")
	-- local fortune = handle:read("*a")
	-- handle:close()
	-- return fortune
	return "Pojok Code"
end

dashboard.section.footer.val = footer()

dashboard.section.footer.opts.hl = "Type"
dashboard.section.header.opts.hl = "Include"
dashboard.section.buttons.opts.hl = "Keyword"

dashboard.opts.opts.noautocmd = true
-- vim.cmd([[autocmd User AlphaReady echo 'ready']])
alpha.setup(dashboard.opts)
