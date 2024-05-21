local function ambilKataDariKiri(kalimat, jumlahKata)
	local hasil = ""
	local posisiAwal = 1
	local kataKe = 0

	while kataKe < jumlahKata do
		local posisiSpasi = string.find(kalimat, " ", posisiAwal)
		if posisiSpasi then
			hasil = hasil .. string.sub(kalimat, posisiAwal, posisiSpasi - 1) .. " "
			posisiAwal = posisiSpasi + 1
		else
			hasil = hasil .. string.sub(kalimat, posisiAwal)
			break
		end
		kataKe = kataKe + 1
	end

	return hasil
end

local fidget = true
local lualine = false
if vim.g.pcode_progress == 1 then
	fidget = false
	lualine = true
elseif vim.g.pcode_progress == 2 then
	fidget = true
	lualine = false
elseif vim.g.pcode_progress == 0 then
	fidget = false
	lualine = false
else
	fidget = true
	lualine = false
end
return {
	{
		"j-hui/fidget.nvim",
		lazy = true,
		enabled = fidget,
		tag = "legacy",
		event = "BufRead",
		config = function()
			require("fidget").setup({
				window = {
					blend = 0,
					relative = "editor",
				},
			})
		end,
	},
	{
		"linrongbin16/lsp-progress.nvim",
		enabled = lualine,
		lazy = true,
		branch = "main",
		event = { "BufRead" },
		config = function()
			require("lsp-progress").setup({
				client_format = function(client_name, spinner, series_messages)
					return #series_messages > 0
							and (spinner .. " " .. ambilKataDariKiri(table.concat(series_messages, ", "), 4) .. "...")
						or nil
				end,
				format = function(client_messages)
					local sign = ""
					return #client_messages > 0
							and (sign .. " " .. ambilKataDariKiri(table.concat(client_messages, " "), 4) .. "...")
						or sign
				end,
			})
		end,
	},
}
