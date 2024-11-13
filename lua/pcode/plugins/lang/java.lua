local M = {}
M = {
  {
    "williamboman/mason-lspconfig.nvim",
    opts = function(_, opts)
      opts.skip_config = opts.skip_config or {}
      vim.list_extend(opts.skip_config, { "jdtls" })
    end,
  },
  {
    "mfussenegger/nvim-jdtls",
    dependencies = { "pojokcodeid/auto-jdtls.nvim" },
    ft = { "java" },
    enabled = true,
    -- your opts go here
    opts = {},
    config = function(_, opts)
      require("auto-jdtls").setup(opts)
      require("auto-jdtls.utils").lsp_keymaps()
      require("auto-jdtls.utils").jdtls_keymaps()
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
      { "<leader>Js", "<cmd>SymbolsOutline<cr>", desc = "Toggle Outline" },
    },
  },
}

return M
