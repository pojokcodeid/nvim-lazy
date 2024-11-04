-- https://github.com/nvim-neotest/neotest-python
-- https://docs.pytest.org/en/7.1.x/getting-started.html
-- (ini untuk windows)*********************************************
-- https://stackoverflow.com/questions/17737203/python-and-virtualenv-on-windows
-- pip install virtualenv
-- python -m virtualenv demoEnv
-- demoEnv\Scripts\activate
-- deactivate
-- (di bawah ini untuk
-- linux)***********************************************************
-- python3 -m venv my-virtual-env
-- sudo python3 -m venv my-virtual-env
-- . ./my-virtual-env/bin/activate
-- sudo apt-get install python3-pytest

-- DAP untuik linux tidak perlu tambahan pakai defaultnya saja
-- ini config khusus windows
local nvim_dap = {
	"mfussenegger/nvim-dap",
	event = "BufReadPre",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"theHamsta/nvim-dap-virtual-text",
		"nvim-neotest/nvim-nio",
		"williamboman/mason.nvim",
		"jay-babu/mason-nvim-dap.nvim",
		"mfussenegger/nvim-dap-python",
	},
	config = function()
		require("nvim-dap-virtual-text").setup({
			virt_text_pos = "eol",
			commented = true,
		})
		local dap_python = require("dap-python")

		require("mason-nvim-dap").setup({
			automatic_installation = true,
			automatic_setup = true,
			handlers = {},
			ensure_installed = { "python" },
		})
		local mason_path = vim.fn.glob(vim.fn.stdpath("data") .. "/mason/")
		local debugpy_path = mason_path .. "packages/debugpy/venv/Scripts/python"

		dap_python.setup(debugpy_path)
		dap_python.default_port = 38000

		require("pcode.user.dapui")
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
}
local M = {
	{
		"nvim-neotest/neotest",
		dependencies = {
			"mfussenegger/nvim-dap-python",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-neotest/nvim-nio",
			"nvim-neotest/neotest-python",
		},
		config = function()
			local mason_path = vim.fn.glob(vim.fn.stdpath("data") .. "/mason/")
			pcall(function()
				require("dap-python").setup(mason_path .. "packages/debugpy/venv/bin/python")
			end)
			require("neotest").setup({
				adapters = {
					require("neotest-python")({
						dap = { justMyCode = false },
						args = { "--log-level", "DEBUG" },
						runner = "pytest",
						python = vim.fn.has("win32") == 0 and "python3" or "python",
					}),
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
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			opts.ensure_installed = opts.ensure_installed or {}
			vim.list_extend(opts.ensure_installed, { "python" })
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		opts = function(_, opts)
			opts.ensure_installed = opts.ensure_installed or {}
			vim.list_extend(opts.ensure_installed, { "pyright" })
		end,
	},
	{
		"pojokcodeid/auto-conform.nvim",
		event = "VeryLazy",
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, { "flake8", "black", "debugpy" })
			opts.formatters_by_ft.python = { "black" }
		end,
	},
}

if vim.fn.has("win32") ~= 0 then
	table.insert(M, nvim_dap)
end

return M
