return {
	--- masukan plugin tambahan disini
	{ "folke/trouble.nvim", enabled = false }, -- ini untuk disable plugin
	-- {
	-- 	"linrongbin16/lsp-progress.nvim",
	-- 	branch = "main",
	-- 	event = { "VimEnter" },
	-- 	config = function()
	-- 		require("lsp-progress").setup({
	-- 			format = function(client_messages)
	-- 				local sign = "" -- nf-fa-gear \uf013
	-- 				return #client_messages > 0 and (sign .. " " .. table.concat(client_messages, " ")) or sign
	-- 			end,
	-- 		})
	-- 	end,
	-- -- },
	-- { "arkav/lualine-lsp-progress", event = "BufRead" },
	-- { "j-hui/fidget.nvim", enabled = false },
}
