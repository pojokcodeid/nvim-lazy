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

function _NCDU_TOGGLE()
	local Terminal = require("toggleterm.terminal").Terminal
	local ncdu = Terminal:new({ cmd = "ncdu", hidden = true })
	ncdu:toggle()
end

function _HTOP_TOGGLE()
	local Terminal = require("toggleterm.terminal").Terminal
	local htop = Terminal:new({ cmd = "htop", hidden = true })
	htop:toggle()
end

function _PYTHON_TOGGLE()
	local Terminal = require("toggleterm.terminal").Terminal
	local python = Terminal:new({ cmd = "python", hidden = true })
	python:toggle()
end

local setup = {
	plugins = {
		marks = true, -- shows a list of your marks on ' and `
		registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
		spelling = {
			enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
			suggestions = 20, -- how many suggestions should be shown in the list?
		},
		-- the presets plugin, adds help for a bunch of default keybindings in Neovim
		-- No actual key bindings are created
		presets = {
			operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
			motions = true, -- adds help for motions
			text_objects = true, -- help for text objects triggered after entering an operator
			windows = true, -- default bindings on <c-w>
			nav = true, -- misc bindings to work with windows
			z = true, -- bindings for folds, spelling and others prefixed with z
			g = true, -- bindings for prefixed with g
		},
	},
	-- add operators that will trigger motion and text object completion
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
		breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
		separator = "➜", -- symbol used between a key and it's label
		group = "+", -- symbol prepended to a group
	},
	popup_mappings = {
		scroll_down = "<c-d>", -- binding to scroll down inside the popup
		scroll_up = "<c-u>", -- binding to scroll up inside the popup
	},
	window = {
		border = "rounded", -- none, single, double, shadow
		-- border = "none", -- none, single, double, shadow
		position = "bottom", -- bottom, top
		margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
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
	triggers = "auto", -- automatically setup triggers
	-- triggers = {"<leader>"} -- or specify a list manually
	triggers_blacklist = {
		-- list of mode / prefixes that should never be hooked by WhichKey
		-- this is mostly relevant for key maps that start with a native binding
		-- most people should not need to change this
		i = { "j", "k" },
		v = { "j", "k" },
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

local trn = ""
if vim.fn.has("win32") == 1 then
	trn = "pwsh<cr>"
end
-- for debug
local debug_key = {}
-- local is_dap = pcall(require, "dap")

if vim.fn.has("win32") == 0 then
	debug_key = {
		name = "Debug",
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
	["/"] = { "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>", "Commet Block" },
}
local mappings = {
	["a"] = { "<cmd>Alpha<cr>", "Alpha" },
	["b"] = {
		"<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>",
		"Buffers",
	},
	--["e"] = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
	["e"] = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
	["w"] = { "<cmd>w!<CR>", "Save" },
	["q"] = { "<cmd>q!<CR>", "Quit" },
	["c"] = { "<cmd>Bdelete!<CR>", "Close Buffer" },
	["h"] = { "<cmd>nohlsearch<CR>", "No Highlight" },
	["f"] = {
		"<cmd>Telescope find_files <CR>",
		"Find files",
	},
	["F"] = { "<cmd>Telescope live_grep theme=ivy<cr>", "Find Text" },
	-- ["P"] = { "<cmd>lua require('telescope').extensions.projects.projects()<cr>", "Projects" },
	-- ["z"] = { "<cmd>Lazy<cr>", "Lazy" },

	["/"] = {
		function()
			require("Comment.api").toggle.linewise.current()
		end,
		"Coment line",
	},
	-- ["m"] = {
	-- 	name = "Markdown",
	-- 	p = { "<cmd>MarkdownPreview<cr>", "Preview" },
	-- 	s = { "<cmd>MarkdownPreviewStop<cr>", "Stop Preview" },
	-- },
	-- p = {
	-- 	name = "Packer",
	-- 	c = { "<cmd>PackerCompile<cr>", "Compile" },
	-- 	i = { "<cmd>PackerInstall<cr>", "Install" },
	-- 	s = { "<cmd>PackerSync<cr>", "Sync" },
	-- 	S = { "<cmd>PackerStatus<cr>", "Status" },
	-- 	u = { "<cmd>PackerUpdate<cr>", "Update" },
	-- },

	g = {
		name = "Git",
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
		name = "LSP",
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
		name = "Search",
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
		name = "Terminal",
		n = { "<cmd>lua _NODE_TOGGLE()<cr>", "Node" },
		u = { "<cmd>lua _NCDU_TOGGLE()<cr>", "NCDU" },
		t = { "<cmd>lua _HTOP_TOGGLE()<cr>", "Htop" },
		p = { "<cmd>lua _PYTHON_TOGGLE()<cr>", "Python" },
		f = { "<cmd>ToggleTerm direction=float<cr>" .. trn, "Float" },
		h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" },
		v = { "<cmd>ToggleTerm size=80 direction=vertical<cr>" .. trn, "Vertical" },
	},
	r = {
		name = "Run",
		s = {
			'<cmd>autocmd bufwritepost [^_]*.sass,[^_]*.scss  silent exec "!sass %:p %:r.css"<CR>',
			"Auto Compile Sass",
		},
		r = { "<cmd>RunCode<CR>", "Run Code" },
		f = { "<cmd>RunFile<CR>", "Run File" },
		p = { "<cmd>RunProject<CR>", "Run Project" },
		g = { "<cmd>ToggleTerm size=70 direction=float<cr>clear<cr>gradle run<cr>" .. trn, "Run Gradle" },
		m = {
			"<cmd>ToggleTerm size=70 direction=float<cr>mvn exec:java -Dexec.mainClass=com.pojokcode.App<cr>",
			"Run MVN",
		},
	},
	-- D = {
	-- 	name = "Debug",
	-- 	b = {
	-- 		function()
	-- 			if is_dap then
	-- 				require("dap").toggle_breakpoint()
	-- 			else
	-- 				vim.notify("DAP Not Support", "info")
	-- 			end
	-- 		end,
	-- 		"Toggle Breakpoint",
	-- 	},
	-- 	B = {
	-- 		function()
	-- 			if is_dap then
	-- 				require("dap").clear_breakpoints()
	-- 			else
	-- 				vim.notify("DAP Not Support", "info")
	-- 			end
	-- 		end,
	-- 		"Clear Breakpoints",
	-- 	},
	-- 	c = {
	-- 		function()
	-- 			if is_dap then
	-- 				require("dap").continue()
	-- 			else
	-- 				vim.notify("DAP Not Support", "info")
	-- 			end
	-- 		end,
	-- 		"Start/Continue",
	-- 	},
	-- 	i = {
	-- 		function()
	-- 			if is_dap then
	-- 				require("dap").step_into()
	-- 			else
	-- 				vim.notify("DAP Not Support", "info")
	-- 			end
	-- 		end,
	-- 		"Step Into (F11)",
	-- 	},
	-- 	o = {
	-- 		function()
	-- 			if is_dap then
	-- 				require("dap").step_over()
	-- 			else
	-- 				vim.notify("DAP Not Support", "info")
	-- 			end
	-- 		end,
	-- 		"Step Over (F10)",
	-- 	},
	-- 	O = {
	-- 		function()
	-- 			if is_dap then
	-- 				require("dap").step_out()
	-- 			else
	-- 				vim.notify("DAP Not Support", "info")
	-- 			end
	-- 		end,
	-- 		"Step Out (S-F11)",
	-- 	},
	-- 	q = {
	-- 		function()
	-- 			if is_dap then
	-- 				require("dap").close()
	-- 			else
	-- 				vim.notify("DAP Not Support", "info")
	-- 			end
	-- 		end,
	-- 		"Close Session",
	-- 	},
	-- 	Q = {
	-- 		function()
	-- 			if is_dap then
	-- 				require("dap").terminate()
	-- 			else
	-- 				vim.notify("DAP Not Support", "info")
	-- 			end
	-- 		end,
	-- 		"Terminate Session (S-F5)",
	-- 	},
	-- 	p = {
	-- 		function()
	-- 			if is_dap then
	-- 				require("dap").pause()
	-- 			else
	-- 				vim.notify("DAP Not Support", "info")
	-- 			end
	-- 		end,
	-- 		"Pause (F6)",
	-- 	},
	-- 	r = {
	-- 		function()
	-- 			if is_dap then
	-- 				require("dap").restart_frame()
	-- 			else
	-- 				vim.notify("DAP Not Support", "info")
	-- 			end
	-- 		end,
	-- 		"Restart (C-F5)",
	-- 	},
	-- 	R = {
	-- 		function()
	-- 			if is_dap then
	-- 				require("dap").repl.toggle()
	-- 			else
	-- 				vim.notify("DAP Not Support", "info")
	-- 			end
	-- 		end,
	-- 		"Toggle REPL",
	-- 	},
	-- },
	-- d = {
	-- 	name = "Debug",
	-- 	t = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
	-- 	b = { "<cmd>lua require'dap'.step_back()<cr>", "Step Back" },
	-- 	c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
	-- 	C = { "<cmd>lua require'dap'.run_to_cursor()<cr>", "Run To Cursor" },
	-- 	d = { "<cmd>lua require'dap'.disconnect()<cr>", "Disconnect" },
	-- 	g = { "<cmd>lua require'dap'.session()<cr>", "Get Session" },
	-- 	i = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
	-- 	o = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over" },
	-- 	u = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },
	-- 	p = { "<cmd>lua require'dap'.pause()<cr>", "Pause" },
	-- 	r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Toggle Repl" },
	-- 	s = { "<cmd>lua require'dap'.continue()<cr>", "Start" },
	-- 	q = { "<cmd>lua require'dap'.close()<cr>", "Quit" },
	-- 	U = { "<cmd>lua require'dapui'.toggle({reset = true})<cr>", "Toggle UI" },
	-- },
	d = debug_key,
	p = {
		name = "Plugins(Lazy)",
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
