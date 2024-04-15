function TABLE_CONTAINS(tbl, x)
	local found = false
	for _, v in pairs(tbl) do
		if v == x then
			found = true
		end
	end
	return found
end

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
							-- text = { builtin.foldfunc, " " },
							text = { builtin.foldfunc },
							condition = { builtin.not_empty, true, builtin.not_empty },
							click = "v:lua.ScFa",
						},
						{ text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
						-- { text = { builtin.lnumfunc }, click = "v:lua.ScLa" },
					},
				})
			end,
		},
	},
	enabled = true,
	lazy = true,
	-- event = "BufReadPost",
	event = { "BufReadPost", "BufRead", "InsertEnter", "BufNewFile" },
	config = function()
		vim.o.foldcolumn = "1" -- '0' is not bad
		vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
		vim.o.foldlevelstart = 99
		vim.o.foldenable = true
		-- vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
		-- vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
		-- vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep:│,foldclose:]]
		-- vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep:│,foldclose:]]
		-- vim.o.fillchars = [[eob: ,fold: ,foldopen:󰛲,foldsep:│,foldclose:󰜄]]
		-- vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep:│,foldclose:]]
		vim.o.fillchars = [[eob: ,fold: ,foldopen:▾,foldsep:│,foldclose:▸]]
		-- vim.opt.fillchars = {
		-- 	vert = "▕", -- alternatives │
		-- 	fold = " ",
		-- 	eob = " ", -- suppress ~ at EndOfBuffer
		-- 	diff = "╱", -- alternatives = ⣿ ░ ─
		-- 	msgsep = "‾",
		-- 	foldopen = "▾",
		-- 	foldsep = "│",
		-- 	foldclose = "▸",
		-- }
		-- these are "extra", change them as you like
		vim.keymap.set("n", "zR", require("ufo").openAllFolds)
		vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
		vim.cmd("highlight FoldColumn guifg=" .. vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("Comment")), "fg"))
		-- vim.cmd("highlight FoldColumn guifg=" .. vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("IblIndent")), "fg"))
		-- Option 3: treesitter as a main provider instead
		-- Only depend on `nvim-treesitter/queries/filetype/folds.scm`,
		-- performance and stability are better than `foldmethod=nvim_treesitter#foldexpr()`

		--[[require("ufo").setup({
			-- provider_selector = function(bufnr, filetype, buftype)
			-- 	return { "treesitter", "indent" }
			-- end,
			open_fold_hl_timeout = 150,
			close_fold_kinds_for_ft = {
				default = { "imports", "comment" },
				json = { "array" },
				c = { "comment", "region" },
			},
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
				if vim.bo.filetype ~= "json" then
					table.insert(result, { suffix, "TSPunctBracket" })
				end
				return result
			end,
		})]]
		--

		-- start ini bagian code support comment dan import
		local ftMap = {
			vim = "indent",
			python = { "indent" },
			git = "",
			-- javascriptreact = { "treesitter", "indent" },
			-- typescriptreact = { "treesitter", "indent" },
		}

		local function customizeSelector(bufnr)
			local function handleFallbackException(err, providerName)
				if type(err) == "string" and err:match("UfoFallbackException") then
					return require("ufo").getFolds(bufnr, providerName)
				else
					return require("promise").reject(err)
				end
			end

			return require("ufo")
				.getFolds(bufnr, "lsp")
				:catch(function(err)
					return handleFallbackException(err, "treesitter")
				end)
				:catch(function(err)
					return handleFallbackException(err, "indent")
				end)
		end

		require("ufo").setup({
			open_fold_hl_timeout = 150,
			close_fold_kinds_for_ft = {
				default = { "imports", "comment" },
				-- json = { "array" },
				c = { "comment", "region" },
			},
			preview = {
				win_config = {
					border = { "", "─", "", "", "", "─", "", "" },
					winhighlight = "Normal:Folded",
					winblend = 0,
				},
				mappings = {
					scrollU = "<C-u>",
					scrollD = "<C-d>",
					jumpTop = "[",
					jumpBot = "]",
				},
			},
			provider_selector = function(bufnr, filetype, buftype)
				-- if you prefer treesitter provider rather than lsp,
				-- return ftMap[filetype]
				-- return ftMap[filetype] or {'treesitter', 'indent'}
				return ftMap[filetype] or customizeSelector

				-- refer to ./doc/example.lua for detail
			end,

			fold_virt_text_handler = function(virt_text, lnum, end_lnum, width, truncate)
				local result = {}
				local closed_fold_text = "comments ..." -- Teks yang ingin ditampilkan
				local import_fold_text = "import ..." -- Teks yang ingin ditampilkan
				local is_comment = false -- Variabel untuk mengecek apakah ini komentar
				local is_import = false
				local is_bracket = false

				-- Memeriksa apakah baris awal dari fold adalah komentar
				local start_line = vim.api.nvim_buf_get_lines(0, lnum - 1, lnum, false)[1]
				if start_line:find("^%s*%/%*") then -- Regex untuk mengecek komentar javascript
					is_comment = true
				elseif start_line:find("^%s*<!--") then
					is_comment = true
				elseif start_line:find("^%s*%-%-") then
					is_comment = true
				end
				if start_line:find("^%s*import") then
					is_import = true
				end
				if start_line:find("%s*{") then
					is_bracket = true
				end
				if is_comment then
					local suffix = string.format(" %s ", closed_fold_text)
					local target_width = width - vim.fn.strdisplaywidth(suffix)
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
							break
						end
						cur_width = cur_width + chunk_width
					end
					-- Menambahkan teks 'Comments ...' ke akhir baris yang dilipat
					table.insert(result, { suffix, "NonText" })
				elseif is_import then
					--[[
					local suffix = string.format(" %s ", import_fold_text)
					local target_width = width - vim.fn.strdisplaywidth(suffix)
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
							break
						end
						cur_width = cur_width + chunk_width
					end
					-- Menambahkan teks 'Comments ...' ke akhir baris yang dilipat
					table.insert(result, { suffix, "NonText" })
					]]
					--

					local suffix = (" 󰁂 %d "):format(end_lnum - lnum)
					local sufWidth = vim.fn.strdisplaywidth(suffix)
					local targetWidth = width - sufWidth
					local curWidth = 0
					for _, chunk in ipairs(virt_text) do
						local chunkText = chunk[1]
						local chunkWidth = vim.fn.strdisplaywidth(chunkText)
						if targetWidth > curWidth + chunkWidth then
							table.insert(result, chunk)
						else
							chunkText = truncate(chunkText, targetWidth - curWidth)
							local hlGroup = chunk[2]
							table.insert(result, { chunkText, hlGroup })
							chunkWidth = vim.fn.strdisplaywidth(chunkText)
							-- str width returned from truncate() may less than 2nd argument, need padding
							if curWidth + chunkWidth < targetWidth then
								suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
							end
							break
						end
						curWidth = curWidth + chunkWidth
					end
					table.insert(result, { " import⋯ ", "NonText" })
					table.insert(result, { suffix, "MoreMsg" })
				else
					-- Jika bukan komentar, tampilkan teks asli
					-- for _, chunk in ipairs(virt_text) do
					-- 	table.insert(result, chunk)
					-- end
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
					local l = { "javascriptreact", "typescriptreact" }
					if TABLE_CONTAINS(l, vim.bo.filetype) and not is_bracket then
						table.insert(result, { suffix, "TSPunctBracket" })
					end
				end
				return result
			end,
		})
		-- end bagian code support comment dan import
	end,
}
