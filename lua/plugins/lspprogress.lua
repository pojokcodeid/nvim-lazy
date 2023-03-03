local fidget = true
local lualine = false
local data_exists, custom_ui = pcall(require, "custom.ui")
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
				format = function(client_messages)
					local sign = "" -- nf-fa-gear \uf013
					return #client_messages > 0 and (sign .. " " .. table.concat(client_messages, " ")) or sign
				end,
			})
		end,
	},
}
