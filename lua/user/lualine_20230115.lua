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

local mode = {
	"mode",
	fmt = function(str)
		return "-- " .. str .. " --"
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
}

local location = {
	"location",
	padding = 0,
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

local spaces = function()
	-- return "->| " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
	return icons.ui.Tab .. " " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
end

local file_name = {
	"filename",
	cond = conditions.buffer_not_empty,
}

local lsp_info = {
	function()
		--local msg = "No Active Lsp"
		local msg = "LS Inactive"
		local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
		local clients = vim.lsp.get_active_clients()
		if next(clients) == nil then
			for i, name in ipairs(clients) do
				msg = msg .. " " .. name
			end
			return msg
		end
		for _, client in ipairs(clients) do
			local filetypes = client.config.filetypes
			if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
				if msg == "LS Inactive" then
					msg = ""
					msg = msg .. client.name
				else
					msg = msg .. ", " .. client.name
				end
			end
		end
		return msg
	end,
	--icon = " ",
	icon = icons.ui.Gear .. "",
}

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
		},
		always_divide_middle = true,
	},
	sections = {
		lualine_a = { branch },
		lualine_b = { mode },
		lualine_c = { diagnostics, lsp_info },
		-- lualine_c = { file_name, lsp_info },
		-- lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_x = { diff, spaces, "encoding", filetype },
		lualine_y = { location },
		lualine_z = { progress },
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
