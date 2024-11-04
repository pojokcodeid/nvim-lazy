local M = {
	"goolord/alpha-nvim",
	event = "VimEnter",
}

M.opts = {
	dash_model = {
		[[                _      __                __    ]],
		[[    ___ ___    (____  / /__  _______ ___/ ___  ]],
		[[   / _ / _ \  / / _ \/  '_/ / __/ _ / _  / -_) ]],
		[[  / .__\_____/ /\___/_/\_\  \__/\___\_,_/\__/  ]],
		[[ /_/      |___/                                ]],
	},
}

function M.config(_, opts)
	local alpha = require("alpha")
	local startify = require("alpha.themes.startify")
	startify.section.header.val = pcode.dashboard or opts.dash_model
	startify.section.top_buttons.val = {
		startify.button("F", "󰈞  Find file", ":Telescope find_files <CR>"),
		startify.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
		startify.button("p", "󰉋  Find project", ":Telescope projects <CR>"),
		startify.button("r", "󰦛  Recently used files", ":Telescope oldfiles <CR>"),
		startify.button("t", "󰊄  Find text", ":Telescope live_grep <CR>"),
		startify.button("c", "  Configuration", ":e $MYVIMRC <CR>"),
		startify.button("L", "󰒲  Lazy", ":Lazy<CR>"),
		startify.button("q", "󰅚  Quit", ":qa<CR>"),
	}
	-- disable MRU
	startify.section.mru.val = { { type = "padding", val = 4 } }
	-- disable MRU cwd
	startify.section.mru_cwd.val = { { type = "padding", val = 0 } }
	-- disable nvim_web_devicons
	startify.nvim_web_devicons.enabled = false
	startify.section.bottom_buttons.val = {}

	vim.api.nvim_create_autocmd("User", {
		pattern = "LazyVimStarted",
		desc = "Add Alpha dashboard footer",
		once = true,
		callback = function()
			local stats = require("lazy").stats()
			local ms = math.floor(stats.startuptime * 100 + 0.5) / 100
			-- stylua: ignore
			startify.section.footer.val = {
				-- {
				-- 	type = "text",
				-- 	val = {"───────────────────────────────────────────"},
				-- },
				{
					type = "text",
					val = {
						"⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins  in " .. ms .. "ms",
					},
				},
				-- {
				-- 	type = "text",
				-- 	val = {"───────────────────────────────────────────"},
				-- },
			}
			pcall(vim.cmd.AlphaRedraw)
		end,
	})

	vim.api.nvim_create_autocmd({ "User" }, {
		pattern = { "AlphaReady" },
		callback = function()
			vim.cmd([[
      set laststatus=0 | autocmd BufUnload <buffer> set laststatus=3
    ]])
		end,
	})
	-- ignore filetypes in MRU
	local default_mru_ignore = {}
	startify.mru_opts.ignore = function(path, ext)
		return (string.find(path, "COMMIT_EDITMSG")) or (vim.tbl_contains(default_mru_ignore, ext))
	end
	alpha.setup(startify.config)
end

return M
