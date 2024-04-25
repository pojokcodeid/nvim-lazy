return {
	{
		"kyazdani42/nvim-tree.lua",
		lazy = true,
		event = "VeryLazy",
		cmd = { "NvimTree", "NvimTreeOpen", "NvimTreeToggle", "NvimTreeFocus", "NvimTreeClose" },
		-- dependencies = "kyazdani42/nvim-web-devicons",
		config = function()
			local data_exists, treeconfig = pcall(require, "core.config")
			if data_exists then
				if treeconfig.loadnvimtree_lazy then
					vim.g.loaded_netrw = 1
					vim.g.loaded_netrwPlugin = 1

					-- set termguicolors to enable highlight groups
					vim.opt.termguicolors = true
					local status_ok, nvim_tree = pcall(require, "nvim-tree")
					if not status_ok then
						return
					end

					local HEIGHT_RATIO = 0.9 -- You can change this
					local WIDTH_RATIO = 0.5 -- You can change this too

					local icons = require("user.icons")
					nvim_tree.setup({
						auto_reload_on_write = false,
						disable_netrw = false,
						hijack_cursor = false,
						hijack_netrw = true,
						hijack_unnamed_buffer_when_opening = false,
						sort_by = "name",
						root_dirs = {},
						prefer_startup_root = false,
						sync_root_with_cwd = true,
						reload_on_bufenter = false,
						respect_buf_cwd = false,
						on_attach = "default",
						select_prompts = false,
						view = {
							adaptive_size = false,
							centralize_selection = true,
							-- width = 30,
							side = "left",
							preserve_window_proportions = false,
							number = false,
							relativenumber = false,
							signcolumn = "yes",
							-- float = {
							-- 	enable = true,
							-- 	quit_on_focus_loss = true,
							-- 	open_win_config = {
							-- 		relative = "editor",
							-- 		border = "rounded",
							-- 		width = 30,
							-- 		height = 30,
							-- 		row = 1,
							-- 		col = 1,
							-- 	},
							-- },
							float = {
								enable = true,
								open_win_config = function()
									local screen_w = vim.opt.columns:get()
									local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
									local window_w = screen_w * WIDTH_RATIO
									local window_h = screen_h * HEIGHT_RATIO
									local window_w_int = math.floor(window_w)
									local window_h_int = math.floor(window_h)
									local center_x = (screen_w - window_w) / 2
									local center_y = ((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get()
									return {
										border = "rounded",
										relative = "editor",
										row = center_y,
										col = center_x,
										width = window_w_int,
										height = window_h_int,
									}
								end,
							},
							width = function()
								return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
							end,
						},
						renderer = {
							add_trailing = false,
							group_empty = false,
							highlight_git = true,
							full_name = false,
							highlight_opened_files = "none",
							root_folder_label = ":t",
							-- root_folder_label = false,
							indent_width = 2,
							indent_markers = {
								enable = true,
								inline_arrows = true,
								icons = {
									corner = "└",
									edge = "│",
									item = "│",
									none = " ",
								},
							},
							icons = {
								webdev_colors = true,
								git_placement = "before",
								padding = " ",
								symlink_arrow = " ➛ ",
								show = {
									file = true,
									folder = true,
									folder_arrow = true,
									git = true,
								},
								glyphs = {
									default = icons.ui.Text,
									symlink = icons.ui.FileSymlink,
									bookmark = icons.ui.BookMark,
									folder = {
										-- arrow_closed = icons.ui.TriangleShortArrowRight,
										arrow_closed = icons.ui.ChevronShortRight,
										-- arrow_open = icons.ui.TriangleShortArrowDown,
										arrow_open = icons.ui.ChevronShortDown,
										default = icons.ui.Folder,
										open = icons.ui.FolderOpen,
										empty = icons.ui.EmptyFolder,
										empty_open = icons.ui.EmptyFolderOpen,
										symlink = icons.ui.FolderSymlink,
										symlink_open = icons.ui.FolderOpen,
									},
									git = {
										unstaged = icons.git.FileUnstaged,
										staged = icons.git.FileStaged,
										unmerged = icons.git.FileUnmerged,
										renamed = icons.git.FileRenamed,
										untracked = icons.git.FileUntracked,
										deleted = icons.git.FileDeleted,
										ignored = icons.git.FileIgnored,
									},
								},
							},
							special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
							symlink_destination = true,
						},
						hijack_directories = {
							enable = false,
							auto_open = true,
						},
						update_focused_file = {
							enable = true,
							debounce_delay = 15,
							update_root = true,
							ignore_list = {},
						},
						diagnostics = {
							enable = true,
							show_on_dirs = false,
							show_on_open_dirs = true,
							debounce_delay = 50,
							severity = {
								min = vim.diagnostic.severity.HINT,
								max = vim.diagnostic.severity.ERROR,
							},
							icons = {
								hint = icons.diagnostics.BoldHint,
								info = icons.diagnostics.BoldInformation,
								warning = icons.diagnostics.BoldWarning,
								error = icons.diagnostics.BoldError,
							},
						},
						filters = {
							dotfiles = false,
							git_clean = false,
							no_buffer = false,
							custom = { "node_modules", "\\.cache", "\\.git" },
							exclude = {
								".gitignore",
								".prettierignore",
							},
						},
						filesystem_watchers = {
							enable = true,
							debounce_delay = 50,
							ignore_dirs = {},
						},
						git = {
							enable = true,
							ignore = false,
							show_on_dirs = true,
							show_on_open_dirs = true,
							disable_for_dirs = {},
							timeout = 400,
						},
						actions = {
							use_system_clipboard = true,
							change_dir = {
								enable = true,
								global = false,
								restrict_above_cwd = false,
							},
							expand_all = {
								max_folder_discovery = 300,
								exclude = {},
							},
							file_popup = {
								open_win_config = {
									col = 1,
									row = 1,
									relative = "cursor",
									border = "shadow",
									style = "minimal",
								},
							},
							open_file = {
								quit_on_open = false,
								resize_window = false,
								window_picker = {
									enable = true,
									picker = "default",
									chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
									exclude = {
										filetype = { "notify", "lazy", "qf", "diff", "fugitive", "fugitiveblame" },
										buftype = { "nofile", "terminal", "help" },
									},
								},
							},
							remove_file = {
								close_window = true,
							},
						},
						trash = {
							cmd = "trash",
							require_confirm = true,
						},
						live_filter = {
							prefix = "[FILTER]: ",
							always_show_folders = true,
						},
						tab = {
							sync = {
								open = false,
								close = false,
								ignore = {},
							},
						},
						notify = {
							threshold = vim.log.levels.INFO,
							-- threshold = vim.log.levels.ERROR,
						},
						log = {
							enable = false,
							truncate = false,
							types = {
								all = false,
								config = false,
								copy_paste = false,
								dev = false,
								diagnostics = false,
								git = false,
								profile = false,
								watcher = false,
							},
						},
						system_open = {
							cmd = nil,
							args = {},
						},
					})
				end
			end
			-- auto open file if creation
			local api = require("nvim-tree.api")
			api.events.subscribe(api.events.Event.FileCreated, function(file)
				vim.cmd("edit " .. file.fname)
			end)
		end,
	},
}
