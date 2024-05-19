local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
	return
end

-- config for toggleterm

function _LAZYGIT_TOGGLE()
	local Terminal = require("toggleterm.terminal").Terminal
	local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })
	lazygit:toggle()
end

function _NODE_TOGGLE()
	local Terminal = require("toggleterm.terminal").Terminal
	local node = Terminal:new({ cmd = "node", hidden = true })
	node:toggle()
end

function _HTOP_TOGGLE()
	local Terminal = require("toggleterm.terminal").Terminal
	local htop = Terminal:new({ cmd = "htop", hidden = true })
	htop:toggle()
end

function _BTOP_TOGGLE()
	local Terminal = require("toggleterm.terminal").Terminal
	local htop = Terminal:new({ cmd = "btop", hidden = true })
	htop:toggle()
end

function _BTM_TOGGLE()
	local Terminal = require("toggleterm.terminal").Terminal
	local htop = Terminal:new({ cmd = "btm", hidden = true })
	htop:toggle()
end

function _PYTHON_TOGGLE()
	local Terminal = require("toggleterm.terminal").Terminal
	local python = Terminal:new({ cmd = "python", hidden = true })
	python:toggle()
end

function _NEWTAB_TOGGLE()
	local Terminal = require("toggleterm.terminal").Terminal
	local pwsh = Terminal:new({ cmd = "pwsh", hidden = true, direction = "tab" })
	pwsh:toggle()
end

function _OPEN_EXPLORER()
	local Terminal = require("toggleterm.terminal").Terminal
	local pwsh = Terminal:new({ cmd = "explorer .", hidden = true, direction = "tab" })
	pwsh:toggle()
end

function _LIVE_SERVER()
	local Terminal = require("toggleterm.terminal").Terminal
	local live_server = Terminal:new({
		cmd = "live-server",
		hidden = true,
		direction = "tab",
	})
	live_server:toggle()
end

function _OPEN_ALACRITTY()
	-- open alacritty new windows current directory
	vim.cmd("silent !alacritty --working-directory " .. vim.fn.getcwd())
end

function _OPEN_WEZTERM()
	-- open wezterm new windows current directory
	vim.cmd("silent !wezterm start --cwd " .. vim.fn.getcwd())
end

-- get folder name from current directory
local _get_folder_name = function()
	return vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
end

function _OPEN_WEZTERM_TAB()
	-- open new tab wezterm current directory
	vim.cmd('silent !wezterm cli spawn --cwd "' .. vim.fn.getcwd() .. '"')
end

function _SET_TAB_TITLE()
	-- set tab title
	vim.cmd('silent !wezterm cli set-tab-title "' .. _get_folder_name() .. '"')
end

function _CLOSE_BUFFER()
	local buf = vim.api.nvim_get_current_buf()
	--  delete current buffer
	require("bufdelete").bufdelete(buf, true)
end

-- function for close all bufferline
function _CLOSE_ALL_BUFFER()
	-- get all buffer
	local bufs = vim.api.nvim_list_bufs()
	-- loop through all buffer
	for _, buf in pairs(bufs) do
		require("bufdelete").bufdelete(buf, true)
	end
end

local icons = require("user.icons")

local setup = {
	plugins = {
		marks = false, -- shows a list of your marks on ' and `
		registers = false, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
		spelling = {
			enabled = true,
			suggestions = 20,
		}, -- use which-key for spelling hints
		-- the presets plugin, adds help for a bunch of default keybindings in Neovim
		-- No actual key bindings are created
		presets = {
			operators = false, -- adds help for operators like d, y, ...
			motions = false, -- adds help for motions
			text_objects = false, -- help for text objects triggered after entering an operator
			windows = false, -- default bindings on <c-w>
			nav = false, -- misc bindings to work with windows
			z = false, -- bindings for folds, spelling and others prefixed with z
			g = false, -- bindings for prefixed with g
		},
	}, -- add operators that will trigger motion and text object completion
	-- to enable all native operators, set the preset / operators plugin above
	-- operators = { gc = "Comments" },
	key_labels = {
		-- override the label used to display some keys. It doesn't effect WK in any other way.
		-- For example:
		-- ["<space>"] = "SPC",
		-- ["<cr>"] = "RET",
		-- ["<tab>"] = "TAB",
	},
	icons = {
		breadcrumb = icons.ui.DoubleChevronRight, -- symbol used in the command line area that shows your active key combo
		separator = icons.ui.BoldArrowRight, -- symbol used between a key and it's label
		group = icons.ui.Plus, -- symbol prepended to a group
	},
	popup_mappings = {
		scroll_down = "<c-d>", -- binding to scroll down inside the popup
		scroll_up = "<c-u>", -- binding to scroll up inside the popup
	},
	window = {
		border = "rounded", -- none, single, double, shadow
		position = "bottom", -- bottom, top
		margin = { 1, 1, 1, 1 }, -- extra window margin [top, right, bottom, left]
		padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
		winblend = 0,
	},
	layout = {
		height = { min = 4, max = 25 }, -- min and max height of the columns
		width = { min = 20, max = 50 }, -- min and max width of the columns
		spacing = 3, -- spacing between columns
		align = "left", -- align columns left, center or right
	},
	ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
	hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
	show_help = true, -- show help message on the command line when the popup is visible
	show_keys = true, -- show the currently pressed key and its label as a message in the command line
	triggers = "auto", -- automatically setup triggers
	-- triggers = {"<leader>"} -- or specify a list manually
	triggers_blacklist = {
		-- list of mode / prefixes that should never be hooked by WhichKey
		-- this is mostly relevant for key maps that start with a native binding
		-- most people should not need to change this
		i = { "j", "k" },
		v = { "j", "k" },
	},
	-- Disabled by default for Telescope
	disable = {
		buftypes = {},
		filetypes = { "TelescopePrompt" },
	},
}

local opts = {
	mode = "n", -- NORMAL mode
	prefix = "<leader>",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = true, -- use `nowait` when creating keymaps
}

local opts2 = {
	mode = "v", -- NORMAL mode
	prefix = "<leader>",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = true, -- use `nowait` when creating keymaps
}

-- for debug
local debug_key = {}

if vim.fn.has("win32") == 0 then
	debug_key = {
		name = "  Debug",
		t = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
		b = { "<cmd>lua require'dap'.step_back()<cr>", "Step Back" },
		c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
		C = { "<cmd>lua require'dap'.run_to_cursor()<cr>", "Run To Cursor" },
		d = { "<cmd>lua require'dap'.disconnect()<cr>", "Disconnect" },
		g = { "<cmd>lua require'dap'.session()<cr>", "Get Session" },
		i = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
		o = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over" },
		u = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },
		p = { "<cmd>lua require'dap'.pause()<cr>", "Pause" },
		r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Toggle Repl" },
		s = { "<cmd>lua require'dap'.continue()<cr>", "Start" },
		q = { "<cmd>lua require'dap'.close()<cr>", "Quit" },
		U = { "<cmd>lua require'dapui'.toggle({reset = true})<cr>", "Toggle UI" },
	}
end
-- end debug
local mappings2 = {
	["/"] = { "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>", " 󰆈 Commet Block" },
}
local mappings = {
	["a"] = { "<cmd>Alpha<cr>", "󰕮 Alpha" },
	["e"] = { "<cmd>NvimTreeToggle<cr><cr>", "󰙅 Explorer" },
	["w"] = { "<cmd>w!<CR>", "󰆓 Save" },
	["q"] = { "<cmd>q!<CR>", "󰿅 Quit" },
	-- open exloler and close toggleterm
	["o"] = { "<cmd>lua _OPEN_EXPLORER()<cr><cmd>lua require('toggleterm').toggle()<cr>", "󱏒 Open Explorer" },
	["h"] = { "<cmd>nohlsearch<CR>", "󱪿 No Highlight" },
	["f"] = {
		"<cmd>Telescope find_files <CR>",
		" Find files",
	},
	["F"] = { "<cmd>Telescope live_grep theme=ivy<cr>", " Find Text" },
	["/"] = {
		function()
			require("Comment.api").toggle.linewise.current()
		end,
		"󰆈 Coment line",
	},
	b = {
		name = "  Buffers",
		-- show all buffers with telescope
		b = {
			"<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>",
			"All Buffer",
		},
		-- close current active buffer
		c = { "<cmd>lua _CLOSE_BUFFER()<cr>", "Close current buffer" },
		-- bufferline close left
		d = {
			"<cmd>BufferLineCloseLeft<cr>",
			"Buffer close left",
		},
		-- bufferline close right
		D = {
			"<cmd>BufferLineCloseRight<cr>",
			"Buffer close right",
		},
		-- bufferline close others
		a = {
			"<cmd>BufferLineCloseOthers<cr>",
			"Buffer close others",
		},
		-- close all bufferline
		A = {
			"<cmd>BufferLineCloseOthers<cr><cmd>bd!<cr>",
			"Buffer close All Buffer",
		},
	},

	g = {
		name = "  Git",
		g = { "<cmd>lua _LAZYGIT_TOGGLE()<CR>", "Lazygit" },
		j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
		k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
		l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
		p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
		r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
		R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
		s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
		u = {
			"<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
			"Undo Stage Hunk",
		},
		o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
		b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
		c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
		d = {
			"<cmd>Gitsigns diffthis HEAD<cr>",
			"Diff",
		},
	},

	l = {
		name = "  LSP",
		a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
		d = {
			"<cmd>Telescope diagnostics bufnr=0<cr>",
			"Document Diagnostics",
		},
		w = {
			"<cmd>Telescope diagnostics<cr>",
			"Workspace Diagnostics",
		},
		f = { "<cmd>lua vim.lsp.buf.format{async=true}<cr>", "Format" },
		i = { "<cmd>LspInfo<cr>", "Info" },
		I = { "<cmd>Mason<cr>", "Installer Info" },
		j = {
			"<cmd>lua vim.lsp.diagnostic.goto_next()<CR>",
			"Next Diagnostic",
		},
		k = {
			"<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>",
			"Prev Diagnostic",
		},
		l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
		q = { "<cmd>lua vim.diagnostic.setloclist()<cr>", "Quickfix" },
		r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
		s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
		S = {
			"<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
			"Workspace Symbols",
		},
	},
	s = {
		name = "  Search",
		b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
		c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
		h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
		M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
		r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
		R = { "<cmd>Telescope registers<cr>", "Registers" },
		k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
		C = { "<cmd>Telescope commands<cr>", "Commands" },
	},

	t = {
		name = "  Terminal",
		l = { "<cmd>terminal live-server<cr>", "Live Server" },
		P = { "<cmd>lua _NEWTAB_TOGGLE()<cr>", "Power Shell" },
		x = { "<cmd>ToggleTermToggleAll!<cr>", "Close Tab" },
		n = { "<cmd>lua _NODE_TOGGLE()<cr>", "Node" },
		b = { "<cmd>lua _BTOP_TOGGLE()<cr>", "Btop" },
		p = { "<cmd>lua _PYTHON_TOGGLE()<cr>", "Python" },
		f = { "<cmd>ToggleTerm direction=float<cr>", "Float" },
		h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" },
		v = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "Vertical" },
		s = { "<cmd>ToggleTerm direction=tab<cr>", "New Tab" },
		a = { "<cmd>lua _OPEN_ALACRITTY()<cr>", "Open Alacritty" },
		w = { "<cmd>lua _OPEN_WEZTERM()<cr>", "Open Wezterm" },
		t = { "<cmd>lua _OPEN_WEZTERM_TAB()<cr>", "Open Tab Wezterm" },
		j = { "<cmd>lua _SET_TAB_TITLE()<cr>", "Set Tab Title" },
	},
	r = {
		name = "  Run",
		l = { "<cmd>edit term://live-server<cr>", "Live Server" },
		s = {
			'<cmd>autocmd bufwritepost [^_]*.sass,[^_]*.scss  silent exec "!sass %:p %:r.css"<CR>',
			"Auto Compile Sass",
		},
		r = { "<cmd>RunCode<CR>", "Run Code" },
		f = { "<cmd>RunFile<CR>", "Run File" },
		p = { "<cmd>RunProject<CR>", "Run Project" },
		g = { "<cmd>terminal<cr>gradle run<cr>", "Run Gradle" },
		m = {
			"<cmd>terminal mvn package<cr>",
			"MVN Build",
		},
	},
	d = debug_key,
	z = {
		name = " 󱑠 Plugins(Lazy)",
		i = { "<cmd>Lazy install<cr>", "Install" },
		s = { "<cmd>Lazy sync<cr>", "Sync" },
		S = { "<cmd>Lazy clear<cr>", "Status" },
		c = { "<cmd>Lazy clean<cr>", "Clean" },
		u = { "<cmd>Lazy update<cr>", "Update" },
		p = { "<cmd>Lazy profile<cr>", "Profile" },
		l = { "<cmd>Lazy log<cr>", "Log" },
		d = { "<cmd>Lazy debug<cr>", "Debug" },
	},
}

local wkey = {}
local data_exists, key = pcall(require, "core.config")
if data_exists then
	wkey = key.whichkey
end

which_key.setup(setup)
which_key.register(mappings, opts)
which_key.register(wkey, opts)
which_key.register(mappings2, opts2)
