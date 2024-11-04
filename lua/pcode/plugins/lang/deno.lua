return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			opts.ensure_installed = opts.ensure_installed or {}
			vim.list_extend(
				opts.ensure_installed,
				{ "html", "javascript", "typescript", "tsx", "css", "json", "jsonc" }
			)
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		opts = function(_, opts)
			opts.ensure_installed = opts.ensure_installed or {}
			vim.list_extend(opts.ensure_installed, { "html", "eslint", "cssls", "emmet_ls", "jsonls", "denols" })
		end,
	},
	{
		"pojokcodeid/auto-conform.nvim",
		event = "VeryLazy",
		opts = function(_, opts)
			opts.formatters_by_ft = opts.formatters_by_ft or {}
			local package = "prettier"
			vim.list_extend(opts.ensure_installed, { package })
			opts.formatters_by_ft.javascript = { package }
		end,
	},
	{
		"pojokcodeid/auto-lint.nvim",
		opts = function(_, opts)
			opts.linters_by_ft = opts.linters_by_ft or {}
			vim.list_extend(opts.ensure_installed, { "eslint_d" })
			opts.linters_by_ft.javascript = { "eslint_d" }
		end,
	},
	{
		"rcarriga/nvim-dap-ui",
		lazy = true,
		event = "BufRead",
		dependencies = {
			{ "mfussenegger/nvim-dap", lazy = true },
			{ "nvim-neotest/nvim-nio", lazy = true },
			{
				"mxsdev/nvim-dap-vscode-js",
				dependencies = {
					"microsoft/vscode-js-debug",
					version = "1.x",
					build = "npm i && npm run compile vsDebugServerBundle && mv dist out",
				},
				config = function()
					require("dap-vscode-js").setup({
						-- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
						debugger_path = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug",
						-- debugger_cmd = { "extension" }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
						adapters = {
							"chrome",
							"pwa-node",
							"pwa-chrome",
							"pwa-msedge",
							"node-terminal",
							"pwa-extensionHost",
							"node",
							"chrome",
						}, -- which adapters to register in nvim-dap
						-- log_file_path = "(stdpath cache)/dap_vscode_js.log" -- Path for file logging
						-- log_file_level = false -- Logging level for output to file. Set to false to disable file logging.
						-- log_console_level = vim.log.levels.ERROR -- Logging level for output to console. Set to false to disable console output.
					})
				end,
			},
		},
		config = function()
			require("pcode.user.dapui")
			local js_based_languages = { "typescript" }

			for _, language in ipairs(js_based_languages) do
				require("dap").configurations[language] = {
					{
						type = "pwa-node",
						request = "launch",
						name = "Launch file",
						runtimeExecutable = "deno",
						runtimeArgs = {
							"run",
							"--inspect-wait",
							"--allow-all",
						},
						program = "${file}",
						cwd = "${workspaceFolder}",
						attachSimplePort = 9229,
					},
				}
			end
		end,
		-- stylua: ignor
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
			{ "<leader>T", "", desc = "  Test" },
			{ "<leader>Tr", "<cmd>terminal deno test<cr>", desc = "Run Test" },
			{ "<leader>Tp", "<cmd>terminal deno test --parallel<cr>", desc = "Run Parallel" },
			{
				"<leader>Ts",
				function()
					vim.cmd("terminal deno test " .. vim.fn.expand("%"))
				end,
				desc = "Run Current File",
			},
			{
				"<leader>Tu",
				function()
					-- local current_word = vim.fn.expand("<cword>")
					local extracted_text = ""
					local input = vim.fn.getline(".")
					local contains_double_quotes = input:match('"')
					local contains_single_quotes = input:match("'")
					if contains_double_quotes then
						-- process jika ada double quote
						input = input:gsub('"', "'")
						local start_index, end_index = input:find("'([^']*)'") -- Mencari teks di dalam tanda petik satu
						extracted_text = input:sub(start_index, end_index)
					elseif contains_single_quotes then
						input = input:gsub('"', "'")
						local start_index, end_index = input:find("'([^']*)'") -- Mencari teks di dalam tanda petik satu
						extracted_text = input:sub(start_index, end_index)
					else
						extracted_text = (input:gsub("Deno.test%(function", "")):gsub("%(%) %{", "")
					end
					vim.cmd("terminal deno test --filter " .. extracted_text)
				end,
				desc = "Run Under Cursor",
			},
		},
	},
}
