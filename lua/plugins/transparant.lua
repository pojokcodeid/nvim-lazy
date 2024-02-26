local transparent = false
local clear_lualine = false
local data_exists, config = pcall(require, "core.config")
if not data_exists then
	return
end

local transparent_mode = config.transparent_mode
if transparent_mode ~= nil then
	if transparent_mode == 1 then
		transparent = true
	end
end

local clear_line = config.clear_lualine
if clear_line ~= nil then
	if clear_line == 1 then
		clear_lualine = true
	end
end

return {
	-- transparant config
	{
		"xiyaowong/transparent.nvim",
		enabled = transparent,
		event = "BufWinEnter",
		cmd = { "TransparentToggle", "TransparentEnable", "TransparentDisable" },
		config = function()
			require("transparent").setup({
				extra_groups = {},
				exclude_groups = {
					-- disable active selection backgroun
					"CursorLine",
					"CursorLineNR",
					"CursorLineSign",
					"CursorLineFold",
					-- disable nvimtree CursorLine
					"NvimTreeCursorLine",
					-- disable Neotree CursorLine
					"NeoTreeCursorLine",
				},
			})
			require("transparent").clear_prefix("BufferLine")
			-- clear prefix for which-key
			require("transparent").clear_prefix("WhichKey")
			-- clear prefix for lazy.nvim
			require("transparent").clear_prefix("Lazy")
			-- clear prefix for NvimTree
			require("transparent").clear_prefix("NvimTree")
			-- clear prefix for NeoTree
			require("transparent").clear_prefix("NeoTree")
			if clear_lualine then
				-- clear prefix for Lualine
				require("transparent").clear_prefix("Lualine")
			end
			-- clear prefix for Telescope
			require("transparent").clear_prefix("Telescope")
			-- create auto command to set transparent
			vim.cmd("TransparentEnable")
		end,
	},
}
