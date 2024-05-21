local run = 0
local frmt = vim.g.pcode_format_on_save or 0
if frmt == 1 then
	run = 1
else
	run = 0
end

local buf_clients = vim.lsp.get_clients()
if next(buf_clients) == nil then
	run = 0
end

if run == 1 then
	function FORMAT_FILTER(client)
		local filetype = vim.bo.filetype
		local n = require("null-ls")
		local s = require("null-ls.sources")
		local method = n.methods.FORMATTING
		local available_formatters = s.get_available(filetype, method)

		if #available_formatters > 0 then
			return client.name == "null-ls"
		elseif client.supports_method("textDocument/formatting") then
			return true
		else
			return false
		end
	end

	vim.cmd([[
  augroup _lsp
       autocmd!
       " autocmd BufWritePre * lua vim.lsp.buf.format{timeout_ms =200, filter=format_filter}
       autocmd BufWritePre * lua vim.lsp.buf.format{timeout_ms=2000 ,filter=FORMAT_FILTER}
    augroup end
  ]])
end
