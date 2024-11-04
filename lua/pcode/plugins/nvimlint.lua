return {
	"pojokcodeid/auto-lint.nvim",
	dependencies = {
		"mfussenegger/nvim-lint",
		event = "VeryLazy",
	},
	event = "VeryLazy",
	opts = function(_, opts)
		opts.map_lang = opts.map_lang or {}
		opts.map_name = opts.map_name or {}
		opts.add_new = opts.add_new or {}
		opts.ignore = opts.ignore or {}
		opts.ensure_installed = opts.ensure_installed or {}
	end,
	config = function(_, opts)
		require("auto-lint").setup(opts)
	end,
}
