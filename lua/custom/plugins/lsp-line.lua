return {
	-- "ErichDonGubler/lsp_lines.nvim",
	-- event = "BufRead",
	-- config = function()
	-- 	require("lsp_lines").setup()
	-- 	vim.api.nvim_create_autocmd("FileType", {
	-- 		pattern = { "*" }, --ini untuk file yang tidak ingin dibaca
	-- 		callback = function()
	-- 			local exclude_ft = {
	-- 				"lazy",
	-- 			}
	-- 			if vim.tbl_contains(exclude_ft, vim.o.filetype) then
	-- 				vim.diagnostic.config({ virtual_lines = false })
	-- 			else
	-- 				vim.diagnostic.config({ virtual_lines = true })
	-- 			end
	-- 		end,
	-- 	})
	-- end,
}
