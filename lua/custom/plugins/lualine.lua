return {
	{
		"nvim-lualine/lualine.nvim",
		event = "BufWinEnter",
		config = function()
			local hide_in_width = function()
				return vim.fn.winwidth(0) > 80
			end
			local icons = require("user.icons")

			-- start for lsp
			local list_registered_providers_names = function(filetype)
				local s = require("null-ls.sources")
				local available_sources = s.get_available(filetype)
				local registered = {}
				for _, source in ipairs(available_sources) do
					for method in pairs(source.methods) do
						registered[method] = registered[method] or {}
						table.insert(registered[method], source.name)
					end
				end
				return registered
			end

			local null_ls = require("null-ls")
			-- for formatter
			local list_registered = function(filetype)
				local method = null_ls.methods.FORMATTING
				local registered_providers = list_registered_providers_names(filetype)
				return registered_providers[method] or {}
			end

			--- for linter
			local alternative_methods = {
				null_ls.methods.DIAGNOSTICS,
				null_ls.methods.DIAGNOSTICS_ON_OPEN,
				null_ls.methods.DIAGNOSTICS_ON_SAVE,
			}

			local linter_list_registered = function(filetype)
				local registered_providers = list_registered_providers_names(filetype)
				local providers_for_methods = vim.tbl_flatten(vim.tbl_map(function(m)
					return registered_providers[m] or {}
				end, alternative_methods))

				return providers_for_methods
			end
			-- end for lsp

			local lsp_info = {
				function()
					local msg = "LS Inactive"
					local buf_ft = vim.bo.filetype
					local clients = vim.lsp.get_active_clients()
					-- start register
					local buf_clients = vim.lsp.buf_get_clients()
					local buf_client_names = {}
					if next(buf_clients) == nil then
						-- TODO: clean up this if statement
						if type(msg) == "boolean" or #msg == 0 then
							return "LS Inactive"
						end
						return msg
					end
					-- add client
					for _, client in pairs(buf_clients) do
						if client.name ~= "null-ls" and client.name ~= "copilot" then
							table.insert(buf_client_names, client.name)
						end
					end
					-- add formatter
					local supported_formatters = list_registered(buf_ft)
					vim.list_extend(buf_client_names, supported_formatters)
					-- add linter
					local supported_linters = linter_list_registered(buf_ft)
					vim.list_extend(buf_client_names, supported_linters)
					-- decomple
					local unique_client_names = vim.fn.uniq(buf_client_names)
					local msg = table.concat(unique_client_names, ", ")
					return msg
				end,
				--icon = " ",
				icon = icons.ui.Gear .. "",
				padding = 1,
			}

			local diagnostics = {
				"diagnostics",
				sources = { "nvim_diagnostic" },
				sections = { "error", "warn" },
				-- symbols = { error = " ", warn = " " },
				symbols = {
					error = icons.diagnostics.BoldError .. " ",
					warn = icons.diagnostics.BoldWarning .. " ",
				},
				colored = true,
				update_in_insert = false,
				always_visible = false,
			}

			local diff = {
				"diff",
				colored = true,
				-- symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
				symbols = {
					added = icons.git.LineAdded .. " ",
					modified = icons.git.LineModified .. " ",
					removed = icons.git.LineRemoved .. " ",
				}, -- changes diff symbols
				cond = hide_in_width,
			}

			local spaces = function()
				-- return " " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
				return icons.ui.Tab .. " " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
			end

			local mode = {
				"mode",
				padding = 1,
				separator = { left = " " },
				-- right_padding = 3,
				fmt = function(str)
					return icons.ui.Neovim .. " " .. str
				end,
			}
			local branch = {
				"branch",
				padding = 1,
			}

			local get_branch = function()
				if vim.b.gitsigns_head ~= nil then
					return " " .. vim.b.gitsigns_head
				else
					return "" .. vim.fn.fnamemodify("", ":t")
				end
			end

			local lsp_progress = {}
			local data_ok, lspprogress = pcall(require, "lsp-progress")
			if data_ok then
				lsp_progress = lspprogress.progress
			end
      -- stylua: ignore
      local colors = {
        blue              = '#50fa7b',
        cyan              = '#f1fa8c',
        black             = '#1a1b26',
        black_transparant = 'none',
        white             = '#c6c6c6',
        red               = "#ff757f",
        skyblue_1         = '#bd93f9',
        grey              = '#5f6a8e',
        yellow            = "#ffb86c",
        fg_gutter         = "#3b4261",
        green1            = "#bd93f9",
      }

			-- check config for theme
			local set_theme
			local bubbles_theme = {}
			local data_exists, config = pcall(require, "core.config")
			if data_exists then
				if config.colorscheme ~= nil then
					local color = config.colorscheme
					switch(color, {
						["tokyonight"] = function()
							set_theme = "auto"
						end,
						["tokyonight-night"] = function()
							set_theme = "auto"
						end,
						["tokyonight-storm"] = function()
							set_theme = "auto"
						end,
						["tokyonight-day"] = function()
							set_theme = "auto"
						end,
						["tokyonight-moon"] = function()
							set_theme = "auto"
						end,
						["dracula"] = function()
							local clr = require("dracula").colors()
							colors.blue = clr.green
							colors.black = clr.black
							colors.cyan = clr.yellow
							set_theme = bubbles_theme
						end,
						default = function()
							set_theme = "auto"
						end,
					})
				end
			end

			bubbles_theme = {
				normal = {
					a = { fg = colors.black, bg = colors.skyblue_1 },
					b = { fg = colors.white, bg = colors.grey },
					c = { fg = colors.white, bg = colors.black_transparant },
				},

				insert = {
					a = { fg = colors.black, bg = colors.blue },
					b = { fg = colors.blue, bg = colors.grey },
				},
				visual = {
					a = { fg = colors.black, bg = colors.cyan },
					b = { fg = colors.cyan, bg = colors.grey },
				},
				replace = {
					a = { bg = colors.red, fg = colors.black },
					b = { bg = colors.fg_gutter, fg = colors.red },
				},
				command = {
					a = { bg = colors.yellow, fg = colors.black },
					b = { bg = colors.fg_gutter, fg = colors.yellow },
				},
				terminal = {
					a = { bg = colors.green1, fg = colors.black },
					b = { bg = colors.fg_gutter, fg = colors.green1 },
				},
				inactive = {
					a = { fg = colors.white, bg = colors.black_transparant },
					b = { fg = colors.white, bg = colors.black_transparant },
					c = { fg = colors.black, bg = colors.black_transparant },
				},
			}

			if set_theme == "auto" then
				bubbles_theme = vim.fn.fnamemodify("auto", ":t")
			end

			require("lualine").setup({
				options = {
					theme = bubbles_theme,
					-- theme = "auto",
					component_separators = { left = "", right = "" },
					section_separators = { left = "", right = "" },
					disabled_filetypes = {
						"TelescopePrompt",
						"packer",
						"alpha",
						"dashboard",
						"NvimTree",
						"Outline",
						"DressingInput",
						"toggleterm",
						"lazy",
						"mason",
						"neo-tree",
						"startuptime",
					},
					always_divide_middle = true,
				},
				sections = {
					lualine_a = {
						mode,
					},
					lualine_b = { get_branch },
					lualine_c = { lsp_info, diagnostics, lsp_progress },
					lualine_x = { diff, spaces, "filetype" },
					lualine_y = { "progress" },
					lualine_z = {
						{ "location", separator = { right = " " }, padding = 1 },
					},
				},
				inactive_sections = {
					lualine_a = { "filename" },
					lualine_b = {},
					lualine_c = {},
					lualine_x = {},
					lualine_y = {},
					lualine_z = { "location" },
				},
				tabline = {},
				extensions = {},
			})
		end,
	},
}
