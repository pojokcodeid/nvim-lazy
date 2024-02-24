local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	return
end
local icons = require("user.icons")
local hide_in_width = function()
	return vim.fn.winwidth(0) > 80
end

local conditions = {
	buffer_not_empty = function()
		return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
	end,
	hide_in_width = function()
		return vim.fn.winwidth(0) > 80
	end,
	check_git_workspace = function()
		local filepath = vim.fn.expand("%:p:h")
		local gitdir = vim.fn.finddir(".git", filepath .. ";")
		return gitdir and #gitdir > 0 and #gitdir < #filepath
	end,
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

-- for config style
local component_separators = { left = "", right = "" }
local section_separators = { left = "", right = "" }
local icon_mode = ""
local sts_mode = 0

local data_exists, custom_ui = pcall(require, "core.config")
if data_exists then
	local ui_style = custom_ui.lualine_style
	if ui_style ~= nil then
		if custom_ui.lualine_style == 1 then
			component_separators = { left = "", right = "" }
			section_separators = { left = "", right = "" }
		elseif custom_ui.lualine_style == 2 then
			component_separators = { left = "", right = "" }
			section_separators = { left = " ", right = " " }
		elseif custom_ui.lualine_style == 3 then
			component_separators = { left = "", right = "" }
			section_separators = { left = "", right = "" }
		end
	end
	local ui_icon = custom_ui.status_icon
	if ui_icon ~= nil then
		if custom_ui.status_icon == 1 then
			icon_mode = " "
			sts_mode = 1
		elseif custom_ui.status_icon == 2 then
			icon_mode = " "
			sts_mode = 1
		end
	end
	local custom_style = custom_ui.custom_lualine
	if custom_style ~= nil and custom_style == true then
		local comp = custom_ui.component_separators
		local section = custom_ui.section_separators
		if comp ~= nil and section ~= nil then
			component_separators = comp
			section_separators = section
		end
	end
end

local mode = {
	"mode",
	padding = 1,
	fmt = function(str)
		-- if str == "NORMAL" then
		-- 	str = "NOR"
		-- elseif str == "INSERT" then
		-- 	str = "INS"
		-- elseif str == "VISUAL" then
		-- 	str = "VIS"
		-- elseif str == "COMMAND" then
		-- 	str = "CMD"
		-- else
		-- 	str = str
		-- end

		if sts_mode == 0 then
			-- return "--" .. str .. "--"
			return " " .. str
		else
			return icon_mode
		end
	end,
}

local filetype = {
	"filetype",
	icons_enabled = true,
	icon = nil,
}

local branch = {
	"branch",
	icons_enabled = true,
	--icon = "",
	icon = icons.git.Branch,
	padding = 1,
}

local location = {
	"location",
	padding = 1,
}

-- cool function for progress
local progress = function()
	local current_line = vim.fn.line(".")
	local total_lines = vim.fn.line("$")
	local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
	local line_ratio = current_line / total_lines
	local index = math.ceil(line_ratio * #chars)
	return chars[index]
end

local time = function()
	return " " .. os.date("%R")
end

local spaces = function()
	-- return "->| " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
	return icons.ui.Tab .. " " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
end

local file_name = {
	"filename",
	cond = conditions.buffer_not_empty,
}

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
		--local msg = "No Active Lsp"
		local msg = "LS Inactive"
		-- local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
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
local lsp_progress = {}
local data_exists, lspprogress = pcall(require, "lsp-progress")
if data_exists then
	lsp_progress = lspprogress.progress
end

local clear_lualine = require("core.config").clear_lualine
if clear_lualine ~= nil then
	if clear_lualine == 1 then
		lualine.setup({
			options = {
				icons_enabled = true,
				theme = "auto",
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
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
				},
				always_divide_middle = true,
			},

			sections = {
				lualine_a = {},
				lualine_b = { mode, branch },
				lualine_c = { lsp_info, diagnostics, lsp_progress },
				-- lualine_c = { file_name, lsp_info },
				-- lualine_x = { "encoding", "fileformat", "filetype" },
				-- lualine_x = { diff, spaces, "encoding", filetype },
				lualine_x = { diff, spaces, filetype },
				lualine_y = { location, time },
				--[[ 	lualine_z = { progress }, ]]
				lualine_z = {},
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {},
			extensions = {},
		})
	else
		lualine.setup({
			options = {
				icons_enabled = true,
				theme = "auto",
				component_separators = component_separators,
				section_separators = section_separators,
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
				},
				always_divide_middle = true,
			},

			sections = {
				lualine_a = { mode },
				lualine_b = { branch },
				lualine_c = { lsp_info, diagnostics, lsp_progress },
				-- lualine_c = { file_name, lsp_info },
				-- lualine_x = { "encoding", "fileformat", "filetype" },
				-- lualine_x = { diff, spaces, "encoding", filetype },
				lualine_x = { diff, spaces, filetype },
				lualine_y = { location },
				--[[ 	lualine_z = { progress }, ]]
				lualine_z = { time },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {},
			extensions = {},
		})
	end
else
	lualine.setup({
		options = {
			icons_enabled = true,
			theme = "auto",
			component_separators = component_separators,
			section_separators = section_separators,
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
			},
			always_divide_middle = true,
		},

		sections = {
			lualine_a = { mode },
			lualine_b = { branch },
			lualine_c = { lsp_info, diagnostics, lsp_progress },
			-- lualine_c = { file_name, lsp_info },
			-- lualine_x = { "encoding", "fileformat", "filetype" },
			-- lualine_x = { diff, spaces, "encoding", filetype },
			lualine_x = { diff, spaces, filetype },
			lualine_y = { location },
			--[[ 	lualine_z = { progress }, ]]
			lualine_z = { time },
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = { "filename" },
			lualine_x = { "location" },
			lualine_y = {},
			lualine_z = {},
		},
		tabline = {},
		extensions = {},
	})
end

-- lualine.setup({
-- 	options = {
-- 		icons_enabled = true,
-- 		theme = "auto",
-- 		component_separators = component_separators,
-- 		section_separators = section_separators,
-- 		disabled_filetypes = {
-- 			"TelescopePrompt",
-- 			"packer",
-- 			"alpha",
-- 			"dashboard",
-- 			"NvimTree",
-- 			"Outline",
-- 			"DressingInput",
-- 			"toggleterm",
-- 			"lazy",
-- 			"mason",
-- 			"neo-tree",
-- 		},
-- 		always_divide_middle = true,
-- 	},
--
-- 	sections = {
-- 		lualine_a = { mode },
-- 		lualine_b = { branch },
-- 		lualine_c = { lsp_info, diagnostics, lsp_progress },
-- 		-- lualine_c = { file_name, lsp_info },
-- 		-- lualine_x = { "encoding", "fileformat", "filetype" },
-- 		-- lualine_x = { diff, spaces, "encoding", filetype },
-- 		lualine_x = { diff, spaces, filetype },
-- 		lualine_y = { location },
-- 		--[[ 	lualine_z = { progress }, ]]
-- 		lualine_z = { time },
-- 	},
-- 	inactive_sections = {
-- 		lualine_a = {},
-- 		lualine_b = {},
-- 		lualine_c = { "filename" },
-- 		lualine_x = { "location" },
-- 		lualine_y = {},
-- 		lualine_z = {},
-- 	},
-- 	tabline = {},
-- 	extensions = {},
-- })
