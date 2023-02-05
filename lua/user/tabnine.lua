vim.schedule(function()
	require("cmp_tabnine.config").setup({
		ignored_file_types = {
			["aerial"] = true,
			["checkhealth"] = true,
			["dap-repl"] = true,
			["dapui_breakpoints"] = true,
			["dapui_console"] = true,
			["dapui_hover"] = true,
			["dapui_scopes"] = true,
			["dapui_stacks"] = true,
			["dapui_watches"] = true,
			["DressingInput"] = true,
			["DressingSelect"] = true,
			["fern"] = true,
			["lazy"] = true,
			["lspinfo"] = true,
			["mason"] = true,
			["nerdterm"] = true,
			["noice"] = true,
			["notify"] = true,
			["null-ls-info"] = true,
			["qf"] = true,
			["TelescopePrompt"] = true,
		},
	})
end)
