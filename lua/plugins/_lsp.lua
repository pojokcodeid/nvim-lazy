return {
  {
    "pojokcodeid/auto-lsp.nvim",
    event = { "VeryLazy", "BufReadPre", "BufNewFile", "BufRead" },
    dependencies = {
      { "williamboman/mason-lspconfig.nvim" },
      {
        "neovim/nvim-lspconfig",
        lazy = true,
        cmd = {
          "LspInfo",
          "LspInstall",
          "LspUninstall",
        },
        config = function()
          require("lspconfig.ui.windows").default_options.border = "rounded"
        end,
      },
      {
        "williamboman/mason.nvim",
        lazy = true,
        cmd = {
          "Mason",
          "MasonInstall",
          "MasonUninstall",
          "MasonUninstallAll",
          "MasonLog",
        },
        opts = function()
          local icons = pcode.icons.ui
          return {
            ui = {
              -- border = "none",
              border = icons.Border,
              icons = {
                package_pending = icons.DotCircle,
                package_installed = icons.CheckCircle,
                package_uninstalled = icons.BlankCircle,
              },
              keymaps = {
                -- Keymap to expand a server in the UI
                toggle_server_expand = "<CR>",
                -- Keymap to install the server under the current cursor position
                install_server = "i",
                -- Keymap to reinstall/update the server under the current cursor position
                update_server = "u",
                -- Keymap to check for new version for the server under the current cursor position
                check_server_version = "c",
                -- Keymap to update all installed servers
                update_all_servers = "U",
                -- Keymap to check which installed servers are outdated
                check_outdated_servers = "C",
                -- Keymap to uninstall a server
                uninstall_server = "X",
              },
            },
            log_level = vim.log.levels.INFO,
            max_concurrent_installers = 4,
          }
        end,
        config = function(_, opts)
          require("mason").setup(opts)
        end,
      },
    },
    opts = function(_, opts)
      opts.skip_config = opts.skip_config or {}
      opts.ensure_installed = opts.ensure_installed or {}
      local servers = { "lua_ls" }
      local mason_install = pcode.mason_ensure_installed or {}
      local unregis_lsp = pcode.unregister_lsp or {}
      vim.list_extend(servers, mason_install)
      vim.list_extend(opts.ensure_installed, servers)
      vim.list_extend(opts.skip_config, unregis_lsp)
      opts.automatic_installation = true
      opts.format_on_save = pcode.format_on_save or false -- config format on save none-ls
      opts.virtual_text = pcode.lsp_virtualtext or false
      opts.timeout_ms = pcode.format_timeout_ms or 5000
      return opts
    end,
    config = function(_, opts)
      require("auto-lsp").setup(opts)
    end,
    keys = {
      { "<leader>l", "", desc = "  LSP", mode = "n" },
      { "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "Code Action", mode = "n" },
      { "<leader>ld", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document Diagnostics", mode = "n" },
      { "<leader>lw", "<cmd>Telescope diagnostics<cr>", desc = "Workspace Diagnostics", mode = "n" },
      { "<leader>lf", "<cmd>lua vim.lsp.buf.format{async=true}<cr>", desc = "Format", mode = "n" },
      { "<leader>li", "<cmd>LspInfo<cr>", desc = "Info", mode = "n" },
      { "<leader>lI", "<cmd>Mason<cr>", desc = "Mason", mode = "n" },
      { "<leader>lj", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", desc = "Next Diagnostic", mode = "n" },
      { "<leader>lk", "<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>", desc = "Prev Diagnostic", mode = "n" },
      { "<leader>ll", "<cmd>lua vim.lsp.codelens.run()<cr>", desc = "Code Lens Action", mode = "n" },
      { "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<cr>", desc = "Quickfix", mode = "n" },
      { "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", desc = "Rename", mode = "n" },
      { "<leader>ls", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document Symbols", mode = "n" },
      { "<leader>lS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "Workspace Symbols", mode = "n" },
    },
  },
}
