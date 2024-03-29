return {
	"kevinhwang91/nvim-ufo",
	dependencies = {
		"kevinhwang91/promise-async",
		{
			"luukvbaal/statuscol.nvim",
			config = function()
				local builtin = require("statuscol.builtin")
				require("statuscol").setup({
					-- relculright = true,
					-- segments = {
					-- 	{ text = { builtin.foldfunc }, click = "v:lua.ScFa" },
					-- 	{ text = { "%s" }, click = "v:lua.ScSa" },
					-- 	{ text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
					-- },
					setopt = true,
					relculright = true,
					segments = {
						{ text = { "%s" }, click = "v:lua.ScSa" },
						{
							text = { builtin.foldfunc },
							condition = { builtin.not_empty, true, builtin.not_empty },
							click = "v:lua.ScFa",
						},
						{ text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
					},
				})
			end,
		},
	},
	lazy = true,
	event = "BufReadPost",
	config = function()
		vim.o.foldcolumn = "1" -- '0' is not bad
		vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
		vim.o.foldlevelstart = 99
		vim.o.foldenable = true
		-- vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
		vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

		-- these are "extra", change them as you like
		vim.keymap.set("n", "zR", require("ufo").openAllFolds)
		vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
		vim.cmd("highlight FoldColumn guifg=" .. vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("Comment")), "fg"))
		-- Option 3: treesitter as a main provider instead
		-- Only depend on `nvim-treesitter/queries/filetype/folds.scm`,
		-- performance and stability are better than `foldmethod=nvim_treesitter#foldexpr()`
		require("ufo").setup({
			-- provider_selector = function(bufnr, filetype, buftype)
			-- 	return { "treesitter", "indent" }
			-- end,
			open_fold_hl_timeout = 150,

			preview = {
				win_config = {
					border = { "", "─", "", "", "", "─", "", "" },
					-- winhighlight = 'Normal:Normal',
					-- winhighlight = 'IncSearch:Folded',
					winhighlight = "Normal:UfoPreviewNormal,FloatBorder:UfoPreviewBorder,CursorLine:UfoPreviewCursorLine",
					winblend = 0,
				},
				mappings = {
					scrollU = "<C-u>",
					scrollD = "<C-d>",
					jumpTop = "[",
					jumpBot = "]",
				},
			},
			provider_selector = function(_, filetype)
				return { "treesitter", "indent" }
			end,
			fold_virt_text_handler = function(virt_text, lnum, end_lnum, width, truncate)
				local result = {}
				local _end = end_lnum - 1
				local final_text = vim.trim(vim.api.nvim_buf_get_text(0, _end, 0, _end, -1, {})[1])
				local suffix = final_text:format(end_lnum - lnum)
				local suffix_width = vim.fn.strdisplaywidth(suffix)
				local target_width = width - suffix_width
				local cur_width = 0
				for _, chunk in ipairs(virt_text) do
					local chunk_text = chunk[1]
					local chunk_width = vim.fn.strdisplaywidth(chunk_text)
					if target_width > cur_width + chunk_width then
						table.insert(result, chunk)
					else
						chunk_text = truncate(chunk_text, target_width - cur_width)
						local hl_group = chunk[2]
						table.insert(result, { chunk_text, hl_group })
						chunk_width = vim.fn.strdisplaywidth(chunk_text)
						-- str width returned from truncate() may less than 2nd argument, need padding
						if cur_width + chunk_width < target_width then
							suffix = suffix .. (" "):rep(target_width - cur_width - chunk_width)
						end
						break
					end
					cur_width = cur_width + chunk_width
				end
				table.insert(result, { " ⋯ ", "NonText" })
				table.insert(result, { suffix, "TSPunctBracket" })
				return result
			end,
		})
	end,
}
