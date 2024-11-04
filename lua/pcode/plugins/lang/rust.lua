return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			opts.ensure_installed = opts.ensure_installed or {}
			vim.list_extend(opts.ensure_installed, { "rust" })
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		opts = function(_, opts)
			opts.skip_config = opts.skip_config or {}
			opts.ensure_installed = opts.ensure_installed or {}
			vim.list_extend(opts.ensure_installed, { "rust_analyzer" })
			vim.list_extend(opts.skip_config, { "rust_analyzer" })
		end,
	},
	{
		"pojokcodeid/auto-conform.nvim",
		event = "VeryLazy",
		opts = function(_, opts)
			opts.formatters_by_ft.rust = { "lsp_fmt" }
		end,
	},
	-- disable none-ls
	{
		"nvimtools/none-ls.nvim",
		enabled = false,
	},
	{
		"rust-lang/rust.vim",
		ft = "rust",
		init = function()
			vim.g.rustfmt_autosave = 1
		end,
	},
	{
		"saecki/crates.nvim",
		tag = "stable",
		ft = { "toml" },
		config = function()
			require("crates").setup()
		end,
	},
	{
		"mrcjkb/rustaceanvim",
		version = "^4",
		ft = { "rust" },
		dependencies = "neovim/nvim-lspconfig",
		config = function()
			-- local on_attach = require("user.lsp.handlers").on_attach
			-- local capabilities = require("user.lsp.handlers").capabilities
			local on_attach = require("auto-lsp.lsp.handlers").on_attach
			local capabilities = require("auto-lsp.lsp.handlers").capabilities

			vim.g.rustaceanvim = {
				server = {
					on_attach = on_attach,
					capabilities = capabilities,
				},
			}
		end,
		keys = {
			{ "<leader>rt", "<cmd>lua vim.cmd.RustLsp('run')<cr>", desc = "Run Rust" },
		},
	},
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("neotest").setup({
				adapters = {
					require("rustaceanvim.neotest"),
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
    },
	},
	{
		"mfussenegger/nvim-dap",
		event = "BufReadPre",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"theHamsta/nvim-dap-virtual-text",
			"nvim-neotest/nvim-nio",
			"williamboman/mason.nvim",
			"jay-babu/mason-nvim-dap.nvim",
		},
		config = function()
			require("nvim-dap-virtual-text").setup({
				virt_text_pos = "eol",
				commented = true,
			})

			require("mason-nvim-dap").setup({
				automatic_installation = true,
				automatic_setup = true,
				handlers = {},
				ensure_installed = { "codelldb" },
			})
			local mason_path = vim.fn.glob(vim.fn.stdpath("data") .. "/mason/")
			local debugrs_path = mason_path .. "packages/codelldb/extension/adapter/codelldb"
			require("pcode.user.dapui")
			local dap = require("dap")
			dap.adapters.codelldb = {
				type = "server",
				port = "${port}",
				executable = {
					-- CHANGE THIS to your path!
					command = debugrs_path,
					args = { "--port", "${port}" },

					-- On windows you may have to uncomment this:
					detached = vim.fn.has("win32") and false or true,
				},
			}
		end,
		keys = {
			{ "<leader>d", "", desc = "  Debug" },
			{ "<leader>dt", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", desc = "Toggle Breakpoint" },
			{ "<leader>db", "<cmd>lua require'dap'.step_back()<cr>", desc = "Step Back" },
			{ "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", desc = "Continue" },
			{ "<leader>dC", "<cmd>lua require'dap'.run_to_cursor()<cr>", desc = "Run To Cursor" },
			{ "<leader>dd", "<cmd>lua require'dap'.disconnect()<cr>", desc = "Disconnect" },
			{ "<leader>dg", "<cmd>lua require'dap'.session()<cr>", desc = "Get Session" },
			{ "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", desc = "Step Into" },
			{ "<leader>do", "<cmd>lua require'dap'.step_over()<cr>", desc = "Step Over" },
			{ "<leader>du", "<cmd>lua require'dap'.step_out()<cr>", desc = "Step Out" },
			{ "<leader>dp", "<cmd>lua require'dap'.pause()<cr>", desc = "Pause" },
			{ "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", desc = "Toggle Repl" },
			{ "<leader>ds", "<cmd>lua require'dap'.continue()<cr>", desc = "Start" },
			{ "<leader>dq", "<cmd>lua require'dap'.close()<cr>", desc = "Quit" },
			{ "<leader>dU", "<cmd>lua require'dapui'.toggle({reset = true})<cr>", desc = "Toggle UI" },
		},
	},
}
