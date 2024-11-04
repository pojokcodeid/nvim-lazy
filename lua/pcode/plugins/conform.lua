return {
	"pojokcodeid/auto-conform.nvim",
	dependencies = {
		"williamboman/mason.nvim",
		"stevearc/conform.nvim",
	},
	event = "VeryLazy",
	opts = function(_, opts)
		opts.formatters = opts.formatters or {}
		opts.formatters_by_ft = opts.formatters_by_ft or {}
		opts.ensure_installed = opts.ensure_installed or {}
		-- vim.list_extend(opts.ensure_installed, { "stylua" })
		opts.lang_maps = opts.lang_maps or {}
		opts.name_maps = opts.name_maps or {}
		opts.add_new = opts.add_new or {}
		opts.ignore = opts.ignore or {}
		opts.format_on_save = opts.format_on_save or true
		opts.format_timeout_ms = opts.format_timeout_ms or 5000
	end,
	config = function(_, opts)
		require("auto-conform").setup(opts)
		-- other conform config
		local conform = require("conform")
		if opts.format_on_save then
			conform.setup({
				format_on_save = {
					lsp_fallback = true,
					timeout_ms = opts.format_timeout_ms or 5000,
				},
			})
		end
		vim.keymap.set({ "n", "v" }, "<leader>lF", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = opts.format_timeout_ms or 5000,
			})
		end, { desc = "Format file or range (in visual mode)" })
	end,
}
