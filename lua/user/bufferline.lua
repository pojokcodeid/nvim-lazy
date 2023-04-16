local status_ok, bufferline = pcall(require, "bufferline")
if not status_ok then
	return
end

local icons = require("user.icons")
local use_icons = true

local function diagnostics_indicator(num, _, diagnostics, _)
	local result = {}
	local symbols = {
		error = icons.diagnostics.Error,
		warning = icons.diagnostics.Warning,
		info = icons.diagnostics.Information,
	}
	if not use_icons then
		return "(" .. num .. ")"
	end
	for name, count in pairs(diagnostics) do
		if symbols[name] and count > 0 then
			table.insert(result, symbols[name] .. " " .. count)
		end
	end
	result = table.concat(result, " ")
	return #result > 0 and result or ""
end

vim.opt.termguicolors = true

bufferline.setup({
	options = {
		color_icons = true,
		numbers = "none", -- | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
		close_command = function(bufnum)
			require("bufdelete").bufdelete(bufnum, true)
		end,
		right_mouse_command = function(bufnum)
			require("bufdelete").bufdelete(bufnum, true)
		end,
		indicator_icon = nil,
		indicator = { style = "icon", icon = "▎" },
		buffer_close_icon = icons.ui.Close,
		modified_icon = icons.ui.Circle,
		close_icon = icons.ui.BoldClose,
		left_trunc_marker = icons.ui.ArrowCircleLeft,
		right_trunc_marker = icons.ui.ArrowCircleRight,
		max_name_length = 30,
		max_prefix_length = 30,
		tab_size = 21,
		diagnostics = false, -- | "nvim_lsp" | "coc",
		diagnostics_update_in_insert = false,
		diagnostics_indicator = diagnostics_indicator,
		offsets = {
			{
				filetype = "NvimTree",
				text = "Explorer",
				highlight = "Directory",
				text_align = "left",
				padding = 1,
			},
			{
				filetype = "neo-tree",
				text = "Explorer",
				highlight = "Directory",
				text_align = "left",
				padding = 1,
			},
		},
		show_buffer_icons = true,
		show_buffer_close_icons = true,
		show_close_icon = true,
		show_tab_indicators = true,
		persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
		separator_style = "thin", -- | "thick" | "thin" | { 'any', 'any' },
		enforce_regular_tabs = true,
		always_show_bufferline = true,
	},
	highlights = {
		background = {
			fg = { attribute = "fg", highlight = "TabLine" },
			bg = { attribute = "bg", highlight = "TabLine" },
		},
		buffer_visible = {
			fg = { attribute = "fg", highlight = "TabLine" },
			bg = { attribute = "bg", highlight = "TabLine" },
		},
		close_button = {
			fg = { attribute = "fg", highlight = "TabLine" },
			bg = { attribute = "bg", highlight = "TabLine" },
		},
		close_button_visible = {
			fg = { attribute = "fg", highlight = "TabLine" },
			bg = { attribute = "bg", highlight = "TabLine" },
		},
		tab_selected = {
			fg = { attribute = "fg", highlight = "Normal" },
			bg = { attribute = "bg", highlight = "Normal" },
		},
		tab = {
			fg = { attribute = "fg", highlight = "TabLine" },
			bg = { attribute = "bg", highlight = "TabLine" },
		},
		tab_close = {
			-- fg = {attribute='fg',highlight='LspDiagnosticsDefaultError'},
			fg = { attribute = "fg", highlight = "TabLineSel" },
			bg = { attribute = "bg", highlight = "Normal" },
		},
		duplicate_selected = {
			fg = { attribute = "fg", highlight = "TabLineSel" },
			bg = { attribute = "bg", highlight = "TabLineSel" },
			underline = true,
		},
		duplicate_visible = {
			fg = { attribute = "fg", highlight = "TabLine" },
			bg = { attribute = "bg", highlight = "TabLine" },
			underline = true,
		},
		duplicate = {
			fg = { attribute = "fg", highlight = "TabLine" },
			bg = { attribute = "bg", highlight = "TabLine" },
			underline = true,
		},

		modified = {
			fg = { attribute = "fg", highlight = "TabLine" },
			bg = { attribute = "bg", highlight = "TabLine" },
		},
		modified_selected = {
			fg = { attribute = "fg", highlight = "Normal" },
			bg = { attribute = "bg", highlight = "Normal" },
		},
		modified_visible = {
			fg = { attribute = "fg", highlight = "TabLine" },
			bg = { attribute = "bg", highlight = "TabLine" },
		},

		separator = {
			fg = { attribute = "bg", highlight = "TabLine" },
			bg = { attribute = "bg", highlight = "TabLine" },
		},
		separator_selected = {
			fg = { attribute = "bg", highlight = "Normal" },
			bg = { attribute = "bg", highlight = "Normal" },
		},
		indicator_selected = {
			fg = { attribute = "fg", highlight = "LspDiagnosticsDefaultHint" },
			bg = { attribute = "bg", highlight = "Normal" },
		},
	},
})
