return {
	"simrat39/rust-tools.nvim",
	event = "BufRead",
	dependencies = {
		"mason-lspconfig.nvim",
		{
			"saecki/crates.nvim",
			tag = "v0.3.0",
			dependencies = { "nvim-lua/plenary.nvim" },
			config = function()
				require("crates").setup({
					null_ls = {
						enabled = true,
						name = "crates.nvim",
					},
					popup = {
						border = "rounded",
					},
				})
			end,
		},
	},
	config = function()
		local mason_path = vim.fn.glob(vim.fn.stdpath("data") .. "/mason/")
		local codelldb_adapter = {
			type = "server",
			port = "${port}",
			executable = {
				command = mason_path .. "bin/codelldb",
				args = { "--port", "${port}" },
				-- On windows you may have to uncomment this:
				-- detached = false,
			},
		}

		local rt = require("rust-tools")
		rt.setup({
			tools = {
				executor = require("rust-tools/executors").termopen, -- can be quickfix or termopen
				reload_workspace_from_cargo_toml = true,
				runnables = {
					use_telescope = true,
				},
				inlay_hints = {
					auto = true,
					only_current_line = false,
					show_parameter_hints = false,
					parameter_hints_prefix = "<-",
					other_hints_prefix = "=>",
					max_len_align = false,
					max_len_align_padding = 1,
					right_align = false,
					right_align_padding = 7,
					highlight = "Comment",
				},
				hover_actions = {
					border = "rounded",
				},
				on_initialized = function()
					vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "CursorHold", "InsertLeave" }, {
						pattern = { "*.rs" },
						callback = function()
							local _, _ = pcall(vim.lsp.codelens.refresh)
						end,
					})
				end,
			},
			dap = {
				adapter = codelldb_adapter,
			},
			server = {
				on_attach = function(client, bufnr)
					require("user.lsp.handlers").on_attach(client, bufnr)
					local rt = require("rust-tools")
					vim.keymap.set("n", "K", rt.hover_actions.hover_actions, { buffer = bufnr })
				end,
				capabilities = require("user.lsp.handlers").capabilities,
				settings = {
					["rust-analyzer"] = {
						lens = {
							enable = true,
						},
						checkOnSave = {
							enable = true,
							command = "clippy",
						},
					},
				},
			},
		})
		local dap = require("dap")
		dap.adapters.codelldb = codelldb_adapter
		dap.configurations.rust = {
			{
				name = "Launch file",
				type = "codelldb",
				request = "launch",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
				stopOnEntry = false,
			},
		}
		vim.api.nvim_set_keymap("n", "<m-d>", "<cmd>RustOpenExternalDocs<Cr>", { noremap = true, silent = true })
	end,
}
