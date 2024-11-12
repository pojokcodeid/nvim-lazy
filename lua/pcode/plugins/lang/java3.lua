local M = {}
local java_filetypes = { "java" }
local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }

-- Utility function to extend or override a config table, similar to the way
-- that Plugin.opts works.
---@param config table
---@param custom function | table | nil
local function extend_or_override(config, custom, ...)
  if type(custom) == "function" then
    config = custom(config, ...) or config
  elseif custom then
    config = vim.tbl_deep_extend("force", config, custom) --[[@as table]]
  end
  return config
end

local function capabilities()
  local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
  if status_ok then
    return cmp_nvim_lsp.default_capabilities()
  end

  local CAPABILITIES = vim.lsp.protocol.make_client_capabilities()
  CAPABILITIES.textDocument.completion.completionItem.snippetSupport = true
  CAPABILITIES.textDocument.completion.completionItem.resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  }

  return CAPABILITIES
end

M = {
  {
    "williamboman/mason-lspconfig.nvim",
    -- stylua: ignore
    opts = function(_, opts)
      opts.skip_config = opts.skip_config or {}
      vim.list_extend(opts.skip_config, { "jdtls" })
      -- Set vim motion for <Space> + l + h to show code documentation about the code the cursor is currently over if available
      vim.keymap.set("n", "<leader>lh", vim.lsp.buf.hover, { desc = "Code Hover Documentation" })
      -- Set vim motion for <Space> + l + d to go where the code/variable under the cursor was defined
      vim.keymap.set("n", "<leader>ld", vim.lsp.buf.definition, { desc = "Code Goto Definition" })
      -- Set vim motion for <Space> + l + a for display code action suggestions for code diagnostics in both normal and visual mode
      vim.keymap.set({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, { desc = "Code Actions" })
      -- Set vim motion for <Space> + l + r to display references to the code under the cursor
      vim.keymap.set("n", "<leader>lr", require("telescope.builtin").lsp_references, { desc = "Code Goto References" })
      -- Set vim motion for <Space> + l + i to display implementations to the code under the cursor
      vim.keymap.set("n", "<leader>li", require("telescope.builtin").lsp_implementations, { desc = "Code Goto Implementations" })
      -- Set a vim motion for <Space> + l + <Shift>R to smartly rename the code under the cursor
      vim.keymap.set("n", "<leader>lR", vim.lsp.buf.rename, { desc = "Code Rename" })
      -- Set a vim motion for <Space> + l + <Shift>D to go to where the code/object was declared in the project (class file)
      vim.keymap.set("n", "<leader>lD", vim.lsp.buf.declaration, { desc = "Code Goto Declaration" })
    end,
    keys = {
      { "<leader>l", "", desc = "LSP", mode = { "n", "v" } },
    },
  },
  {
    "mfussenegger/nvim-jdtls",
    ft = java_filetypes,
    enabled = true,
    opts = function()
      return {
        root_dir = require("jdtls.setup").find_root(root_markers),
        project_name = function()
          return vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
        end,

        -- Where are the config and workspace dirs for a project?
        jdtls_config_dir = function(project_name)
          return vim.fn.stdpath("cache") .. "/jdtls/" .. project_name .. "/config"
        end,
        jdtls_workspace_dir = function(project_name)
          return vim.fn.stdpath("cache") .. "/jdtls/" .. project_name .. "/workspace"
        end,
        cmd = { vim.fn.exepath("jdtls") },
        full_cmd = function(opts)
          local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
          local cmd = vim.deepcopy(opts.cmd)
          if project_name then
            vim.list_extend(cmd, {
              "-configuration",
              opts.jdtls_config_dir(project_name),
              "-data",
              opts.jdtls_workspace_dir(project_name),
            })
          end
          return cmd
        end,

        -- These depend on nvim-dap, but can additionally be disabled by setting false here.
        dap = { hotcodereplace = "auto", config_overrides = {} },
        dap_main = {},
        test = true,
        settings = {
          java = {
            inlayHints = {
              parameterNames = {
                enabled = "all",
              },
            },
          },
        },
      }
    end,
    config = function(_, opts)
      local opt = vim.opt
      opt.shiftwidth = 4
      opt.tabstop = 4
      opt.softtabstop = 4
      opt.ts = 4
      opt.expandtab = true

      local mason_registry = require("mason-registry")
      local bundles = {} ---@type string[]
      if opts.dap and mason_registry.is_installed("java-debug-adapter") then
        local java_dbg_pkg = mason_registry.get_package("java-debug-adapter")
        local java_dbg_path = java_dbg_pkg:get_install_path()
        local jar_patterns = {
          java_dbg_path .. "/extension/server/com.microsoft.java.debug.plugin-*.jar",
        }
        -- java-test also depends on java-debug-adapter.
        if opts.test and mason_registry.is_installed("java-test") then
          local java_test_pkg = mason_registry.get_package("java-test")
          local java_test_path = java_test_pkg:get_install_path()
          vim.list_extend(jar_patterns, {
            java_test_path .. "/extension/server/*.jar",
          })
        end
        for _, jar_pattern in ipairs(jar_patterns) do
          for _, bundle in ipairs(vim.split(vim.fn.glob(jar_pattern), "\n")) do
            table.insert(bundles, bundle)
          end
        end
      end

      local function attach_jdtls()
        -- Configuration can be augmented and overridden by opts.jdtls
        local config = extend_or_override({
          cmd = opts.full_cmd(opts),
          root_dir = require("jdtls.setup").find_root(root_markers),
          init_options = {
            bundles = bundles,
          },
          settings = opts.settings,
          -- enable CMP capabilities
          -- capabilities = require("user.lsp.handlers").capabilities or nil,
          -- capabilities = require("auto-lsp.lsp.handlers").capabilities or nil,
          capabilities = capabilities() or nil,
        }, opts.jdtls)

        -- Existing server will be reused if the root_dir matches.
        require("jdtls").start_or_attach(config)
        -- not need to require("jdtls.setup").add_commands(), start automatically adds commands
      end

      vim.api.nvim_create_autocmd("FileType", {
        pattern = java_filetypes,
        callback = attach_jdtls,
      })

      -- Setup keymap and dap after the lsp is fully attached.
      -- https://github.com/mfussenegger/nvim-jdtls#nvim-dap-configuration
      -- https://neovim.io/doc/user/lsp.html#LspAttach
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          -- stylua: ignore
          if client and client.name == "jdtls" then
            -- add keymaps
            vim.keymap.set('n', '<leader>J', "", { desc = "Java" })
            -- Set a Vim motion to <Space> + <Shift>J + o to organize imports in normal mode
            vim.keymap.set('n', '<leader>Jo', "<Cmd> lua require('jdtls').organize_imports()<CR>", { desc = "Java Organize Imports" })
            -- Set a Vim motion to <Space> + <Shift>J + v to extract the code under the cursor to a variable
            vim.keymap.set('n', '<leader>Jv', "<Cmd> lua require('jdtls').extract_variable()<CR>", { desc = "Java Extract Variable" })
            -- Set a Vim motion to <Space> + <Shift>J + v to extract the code selected in visual mode to a variable
            vim.keymap.set('v', '<leader>Jv', "<Esc><Cmd> lua require('jdtls').extract_variable(true)<CR>", { desc = "Java Extract Variable" })
            -- Set a Vim motion to <Space> + <Shift>J + <Shift>C to extract the code under the cursor to a static variable
            vim.keymap.set('n', '<leader>JC', "<Cmd> lua require('jdtls').extract_constant()<CR>", { desc = "Java Extract Constant" })
            -- Set a Vim motion to <Space> + <Shift>J + <Shift>C to extract the code selected in visual mode to a static variable
            vim.keymap.set('v', '<leader>JC', "<Esc><Cmd> lua require('jdtls').extract_constant(true)<CR>", { desc = "Java Extract Constant" })
            -- Set a Vim motion to <Space> + <Shift>J + t to run the test method currently under the cursor
            vim.keymap.set('n', '<leader>Jt', "<Cmd> lua require('jdtls').test_nearest_method()<CR>", { desc = "Java Test Method" })
            -- Set a Vim motion to <Space> + <Shift>J + t to run the test method that is currently selected in visual mode
            vim.keymap.set('v', '<leader>Jt', "<Esc><Cmd> lua require('jdtls').test_nearest_method(true)<CR>", { desc = "Java Test Method" })
            -- Set a Vim motion to <Space> + <Shift>J + <Shift>T to run an entire test suite (class)
            vim.keymap.set('n', '<leader>JT', "<Cmd> lua require('jdtls').test_class()<CR>", { desc = "Java Test Class" })
            -- Set a Vim motion to <Space> + <Shift>J + u to update the project configuration
            vim.keymap.set('n', '<leader>Ju', "<Cmd> JdtUpdateConfig<CR>", { desc = "Java Update Config" })
            if opts.dap and mason_registry.is_installed("java-debug-adapter") then
              -- custom init for Java debugger
              require("jdtls").setup_dap(opts.dap)
              require("jdtls.dap").setup_dap_main_class_configs(opts.dap_main)
            end

            -- User can set additional keymaps in opts.on_attach
            if opts.on_attach then
              opts.on_attach(args)
            end
          end
        end,
      })

      -- Avoid race condition by calling attach the first time, since the autocmd won't fire.
      attach_jdtls()
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "java" })
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "jdtls" })
    end,
  },
  {
    "pojokcodeid/auto-conform.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "java-debug-adapter", "java-test" })
      opts.formatters_by_ft.java = { "lsp_fmt" }
    end,
  },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "andy-bell101/neotest-java",
    },
    config = function()
      local project_type = "maven"
      local gradle_file = vim.fn.findfile("build.gradle", vim.fn.getcwd())
      if gradle_file then
        project_type = "gradle"
      end

      require("neotest").setup({
        adapters = {
          require("neotest-java")({
            -- function to determine which runner to use based on project path
            determine_runner = function(project_root_path)
              -- return should be "maven" or "gradle"
              return project_type
            end,
            -- override the builtin runner discovery behaviour to always use given
            -- tool. Default is "nil", so no override
            force_runner = nil,
            -- if the automatic runner discovery can't uniquely determine whether
            -- to use Gradle or Maven, fallback to using this runner. Default is
            -- "gradle or maven"
            fallback_runner = project_type,
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
      	{ "<leader>rg", "<cmd>terminal<cr>gradle run<cr>", desc = "Run Gradle", mode = "n" },
      },
  },
  {
    "rockerBOO/symbols-outline.nvim",
    cmd = "SymbolsOutline",
    config = function()
      require("symbols-outline").setup({
        symbols = {
          File = { icon = "󰈔", hl = "@text.uri" },
          Module = { icon = "", hl = "@namespace" },
          Namespace = { icon = "󰅪", hl = "@namespace" },
          Package = { icon = "", hl = "@namespace" },
          Class = { icon = "𝓒", hl = "@type" },
          Method = { icon = "ƒ", hl = "@method" },
          Property = { icon = "", hl = "@method" },
          Field = { icon = "", hl = "@field" },
          Constructor = { icon = "", hl = "@constructor" },
          Enum = { icon = "ℰ", hl = "@type" },
          Interface = { icon = "", hl = "@type" },
          Function = { icon = "", hl = "@function" },
          Variable = { icon = "", hl = "@constant" },
          Constant = { icon = "", hl = "@constant" },
          String = { icon = "𝓐", hl = "@string" },
          Number = { icon = "#", hl = "@number" },
          Boolean = { icon = "󰨙 ", hl = "@boolean" },
          Array = { icon = "", hl = "@constant" },
          Object = { icon = "⦿", hl = "@type" },
          Key = { icon = "🔐", hl = "@type" },
          Null = { icon = "NULL", hl = "@type" },
          EnumMember = { icon = "", hl = "@field" },
          Struct = { icon = "𝓢", hl = "@type" },
          Event = { icon = "🗲", hl = "@type" },
          Operator = { icon = "+", hl = "@operator" },
          TypeParameter = { icon = "𝙏", hl = "@parameter" },
          Component = { icon = "󰅴", hl = "@function" },
          Fragment = { icon = "󰅴", hl = "@constant" },
        },
      })
    end,
    keys = {
      { "<leader>S", "<cmd>SymbolsOutline<cr>", desc = "Toggle Outline" },
    },
  },
}

return M
