local fidget = true
local lualine = false
local data_exists, custom_ui = pcall(require, "core.config")
if data_exists then
	if type(custom_ui) == "table" then
		if custom_ui.progress == 1 then
			fidget = false
			lualine = true
		elseif custom_ui.progress == 2 then
			fidget = true
			lualine = false
		elseif custom_ui.progress == 0 then
			fidget = false
			lualine = false
		else
			fidget = true
			lualine = false
		end
	end
else
	fidget = true
	lualine = false
end
return {
	{
		"j-hui/fidget.nvim",
		enabled = fidget,
		event = "BufRead",
		config = function()
			require("fidget").setup()
		end,
	},
	{
		"linrongbin16/lsp-progress.nvim",
		enabled = lualine,
		branch = "main",
		event = { "BufRead" },
		config = function()
			require("lsp-progress").setup({
				client_format = function(client_name, spinner, series_messages)
					return #series_messages > 0 and (spinner .. " " .. table.concat(series_messages, ", ")) or nil
				end,
				format = function(client_messages)
					local sign = ""
					return #client_messages > 0 and (sign .. " " .. table.concat(client_messages, " ")) or sign
				end,
			})
		end,
	},
}
