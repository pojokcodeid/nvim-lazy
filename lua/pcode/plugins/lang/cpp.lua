return {
	{
		"nvim-treesitter/nvim-treesitter",
		event = "VeryLazy",
		opts = function(_, opts)
			opts.ensure_installed = opts.ensure_installed or {}
			vim.list_extend(opts.ensure_installed, { "cpp", "c" })
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		opts = function(_, opts)
			opts.ensure_installed = opts.ensure_installed or {}
			vim.list_extend(opts.ensure_installed, { "clangd" })
		end,
	},
	{
		"jay-babu/mason-nvim-dap.nvim",
		event = "VeryLazy",
		opts = function(_, opts)
			opts.ensure_installed = opts.ensure_installed or {}
			vim.list_extend(opts.ensure_installed, { "codelldb" })
		end,
	},
	{
		"pojokcodeid/auto-conform.nvim",
		event = "VeryLazy",
		opts = function(_, opts)
			local package = "clang-format"
			vim.list_extend(opts.ensure_installed, { package })
			opts.formatters_by_ft.cpp = { package }
			opts.formatters_by_ft.c = { package }
		end,
	},
	{
		"nvim-neotest/neotest",
		ft = { "cpp" },
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-neotest/nvim-nio",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-lua/plenary.nvim",
			"alfaix/neotest-gtest",
		},
		config = function()
			require("neotest").setup({
				adapters = {
					require("neotest-gtest").setup({}),
				},
			})
		end,
    -- stylua: ignore
    keys = {
      { "<leader>T","",desc="  Test"},
      { "<leader>Tt", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run File" },
      { "<leader>Tr", function() require("neotest").run.run() end, desc = "Run Nearest" },
      { "<leader>TT", function() require("neotest").run.run(vim.loop.cwd()) end, desc = "Run All Test Files" },
      { "<leader>Tl", function() require("neotest").run.run_last() end, desc = "Run Last" },
      { "<Leader>Ts", function() require("neotest").summary.toggle() end, desc = "Toggle Summary" },
      { "<leader>To", function() require("neotest").output.open({ enter = true, auto_close = true }) end, desc = "Show Output" },
      { "<Leader>TO", function() require("neotest").output_panel.toggle() end, desc = "Toggle Output Panel" },
      { "<Leader>TS", function() require("neotest").run.stop() end, desc = "Stop" },
      { "<leader>rc", "<cmd>terminal<cr>g++ --debug main.cpp -o main<cr>", desc = "Compile Debug main.cpp" },
    },
	},
}
