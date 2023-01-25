local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
	debug = false,
	sources = {
		--formatting.prettier.with({ extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" } }),
		--formatting.prettier,
		-- formatting.prettierd,
		formatting.black.with({ extra_args = { "--fast" } }),
		formatting.stylua,
		-- formatting.eslint_d,
		-- formatting.google_java_format,
		-- formatting.phpcbf,
		-- formatting.clang_format,
		-- diagnostics.flake8
		-- diagnostics.eslint_d,
	},

	on_attach = function(client, bufnr)
		--if client.resolved_capabilities.document_formatting then
		--vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.format{async=true}")
		--end
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({ bufnr = bufnr })
					-- vim.lsp.buf.formatting_sync()
				end,
			})
		end
	end,
})
