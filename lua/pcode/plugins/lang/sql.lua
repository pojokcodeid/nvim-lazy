return {
	"kristijanhusak/vim-dadbod-ui",
	dependencies = {
		{ "tpope/vim-dadbod", lazy = true },
		{ "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
	},
	init = function()
		-- Your DBUI configuration
		vim.g.db_ui_show_database_icon = 1
		vim.g.db_ui_use_nerd_fonts = 1
		vim.g.db_ui_show_help = 0
	end,
	config = function()
		local function db_completion()
			require("cmp").setup.buffer({
				sources = { { name = "vim-dadbod-completion" } },
			})
		end
		vim.g.db_ui_save_location = vim.fn.stdpath("config") .. require("plenary.path").path.sep .. "db_ui"

		vim.api.nvim_create_autocmd("FileType", {
			pattern = {
				"sql",
			},
			command = [[setlocal omnifunc=vim_dadbod_completion#omni]],
		})

		vim.api.nvim_create_autocmd("FileType", {
			pattern = {
				"sql",
				"mysql",
				"plsql",
			},
			callback = function()
				vim.schedule(db_completion)
			end,
		})
	end,
	cmd = {
		"DBUIToggle",
		"DBUI",
		"DBUIAddConnection",
		"DBUIFindBuffer",
		"DBUIRenameBuffer",
		"DBUILastQueryInfo",
	},
  -- stylua: ignore
  keys = {
    { "<leader>D", "", desc = " 󰆼 DBUI" },
    { "<leader>Dd", "<cmd>Alpha<cr><cmd>NvimTreeClose<cr><cmd>DBUI<cr>", desc = "󰆼 DBUI Open" },
    { "<leader>Dq",
      "<cmd>DBUIClose<cr><cmd>BufferLineCloseOthers<cr><cmd>bd!<cr><cmd>lua require('auto-bufferline.configs.utils').bufremove()<cr><cmd>Alpha<cr>",
      desc = "󰅙 DBUI Close",
    },
  },
}
