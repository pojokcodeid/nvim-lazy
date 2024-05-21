return {
	{
		"nvim-lualine/lualine.nvim",
		event = { "InsertEnter", "BufRead", "BufNewFile" },
		config = function()
			local component = require("user.utils.lualine_component")
			local treesitter = component.treesitter
			local lsp_info = component.lsp_info
			local diagnostics = component.diagnostics
			local diff = component.diff
			local spaces = component.spaces
			local mode = component.mode
			local get_branch = component.get_branch
			local lsp_progress = {}
			local data_ok, lspprogress = pcall(require, "lsp-progress")
			if data_ok then
				lsp_progress = lspprogress.progress
			end
			local colors = component.colors

			-- check config for theme
			local set_theme = "auto"
			local bubbles_theme
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
							set_theme = "bubbles_theme"
						end,
						default = function()
							set_theme = "auto"
						end,
					})
				end
			end

			bubbles_theme = component.bubbles_theme(colors)
			if set_theme == "auto" then
				bubbles_theme = vim.fn.fnamemodify("auto", ":t")
			end

			require("lualine").setup({
				options = {
					theme = bubbles_theme,
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
					lualine_c = { diff, lsp_info, lsp_progress },
					lualine_x = { diagnostics, spaces, treesitter, "filetype" },
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
