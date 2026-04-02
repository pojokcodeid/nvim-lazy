return {
  {
    "mason-org/mason-lspconfig.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      {
        "mason-org/mason.nvim",
        build = ":MasonUpdate",
        opts_extend = { "ensure_installed" },
        cmd = {
          "Mason",
          "MasonInstall",
          "MasonUninstall",
          "MasonUninstallAll",
          "MasonLog",
        },
        opts = function(_, opts)
          local icons = require("pcode.user.icons").ui
          opts.ensure_installed = opts.ensure_installed or {}
          vim.list_extend(opts.ensure_installed, { "stylua" })
          opts.ui = {
            border = icons.Border,
            icons = {
              package_pending = icons.Pending,
              package_installed = icons.CheckCircle,
              package_uninstalled = icons.BlankCircle,
            },
            keymaps = {
              toggle_server_expand = "<CR>",
              install_server = "i",
              update_server = "u",
              check_server_version = "c",
              update_all_servers = "U",
              check_outdated_servers = "C",
              uninstall_server = "X",
            },
          }
          opts.log_level = vim.log.levels.INFO
          opts.max_concurrent_installers = 4
          return opts
        end,
        config = function(_, opts)
          require("mason").setup(opts)
          local mr = require("mason-registry")
          mr:on("package:install:success", function()
            vim.defer_fn(function()
              -- trigger FileType event to possibly load this newly installed LSP server
              require("lazy.core.handler.event").trigger({
                event = "FileType",
                buf = vim.api.nvim_get_current_buf(),
              })
            end, 100)
          end)

          mr.refresh(function()
            for _, tool in ipairs(opts.ensure_installed) do
              local p = mr.get_package(tool)
              if not p:is_installed() then
                p:install()
              end
            end
          end)
        end,
      },
      "neovim/nvim-lspconfig",
    },
    opts = {
      ensure_installed = { "lua_ls" },
      skip_config = {},
    },
    config = function(_, opts)
      opts.skip_config = opts.skip_config or {}
      require("mason-lspconfig").setup(opts)
      local option = {}
      local installed_servers = require("mason-lspconfig").get_installed_servers()
      vim.diagnostic.config({ virtual_lines = { current_line = true } })
      vim.diagnostic.config({
        underline = false,
        virtual_text = false,
        update_in_insert = false,
        severity_sort = true,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.HINT] = " ",
            [vim.diagnostic.severity.INFO] = " ",
          },
        },
      })
      -- register lsp
      for _, server_name in ipairs(installed_servers) do
        local is_skip = false
        local my_index = idxOf(opts.skip_config, server_name)
        if my_index ~= nil then
          is_skip = true
        end
        if not is_skip then
          local capabilities = {
            textDocument = {
              foldingRange = {
                dynamicRegistration = false,
                lineFoldingOnly = true,
              },
            },
          }
          capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
          option = {
            on_attach = function(client, bufnr)
              local map = function(keys, func, desc, mode)
                mode = mode or "n"
                vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = desc })
              end
              map("gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", "Goto declaration", "n")
              map("gd", "<cmd>lua vim.lsp.buf.definition()<CR>", "Goto definition", "n")
              map("<C-LeftMouse>", "<cmd>lua vim.lsp.buf.definition()<CR>", "Goto definition", "n")
              map("K", "<cmd>lua vim.lsp.buf.hover()<CR>", "Hover", "n")
              map("gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", "Goto implementation", "n")
              map("gr", "<cmd>lua vim.lsp.buf.references()<CR>", "References", "n")
              map("gl", "<cmd>lua vim.diagnostic.open_float()<CR>", "Show line diagnostics", "n")
              map("<leader>l", "", "LSP", "n")
              map("<leader>lf", "<cmd>lua vim.lsp.buf.format{ async = true }<cr>", "Format", "n")
              map("<leader>li", "<cmd>LspInfo<cr>", "Information", "n")
              map("<leader>lI", "<cmd>Mason<cr>", "Mason Information", "n")
              map("<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action", "n")
              map("<leader>lj", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>", "Next Diagnostic", "n")
              map("<leader>lk", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>", "Prev Diagnostic", "n")
              map("<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename", "n")
              map("<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Signature help", "n")
              map("<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", "Quickfix", "n")
            end,
            capabilities = capabilities,
          }
          server_name = vim.split(server_name, "@")[1]
          local require_ok, conf_opts = pcall(require, "pcode.plugins.lsp." .. server_name)
          if require_ok then
            option = vim.tbl_deep_extend("force", conf_opts, option)
          end
          vim.lsp.config(server_name, option)
          vim.lsp.enable(server_name)
        end
      end
    end,
  },
}
