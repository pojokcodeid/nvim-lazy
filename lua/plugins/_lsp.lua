return {
  {
    "williamboman/mason-lspconfig.nvim",
    event = { "VeryLazy", "BufReadPre", "BufNewFile", "BufRead" },
    dependencies = {
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
      return opts
    end,
    config = function(_, opts)
      require("mason-lspconfig").setup(opts)

      local option = {}
      require("mason-lspconfig").setup_handlers({
        function(server_name) -- default handler (optional)
          local capabilities = require("user.lsp.handlers").capabilities
          if server_name == "clangd" then
            capabilities.offsetEncoding = { "utf-16" }
          end
          local is_skip = false
          local my_index = idxOf(opts.skip_config, server_name)
          if my_index ~= nil then
            is_skip = true
          end
          if not is_skip then
            option = {
              on_attach = require("user.lsp.handlers").on_attach,
              capabilities = capabilities,
            }

            server_name = vim.split(server_name, "@")[1]

            local require_ok, conf_opts = pcall(require, "user.lsp.settings." .. server_name)
            if require_ok then
              option = vim.tbl_deep_extend("force", conf_opts, option)
            end
            require("lspconfig")[server_name].setup(option)
          end
        end,
        -- ["jdtls"] = function()
        --   require("lspconfig").jdtls.setup({
        --     on_attach = require("user.lsp.handlers").on_attach,
        --     capabilities = require("user.lsp.handlers").capabilities,
        --     cmd = {
        --       "jdtls",
        --       "-configuration",
        --       vim.fn.expand("$HOME") .. "/.cache/jdtls/config",
        --       "-data",
        --       vim.fn.expand("$HOME") .. "/.cache/jdtls/workspace",
        --     },
        --     filetypes = { "java" },
        --     root_dir = require("lspconfig.util").root_pattern(
        --       -- Single-module projects
        --       {
        --         "build.xml", -- Ant
        --         "pom.xml", -- Maven
        --         "settings.gradle", -- Gradle
        --         "settings.gradle.kts", -- Gradle
        --       },
        --       -- Multi-module projects
        --       { "build.gradle", "build.gradle.kts" }
        --     ) or vim.fn.getcwd(),
        --     singe_file_support = true,
        --   })
        -- end,
      })
      require("user.lsp.handlers").setup()
    end,
  },
}
