return {
  { "nvim-lua/plenary.nvim", event = "VeryLazy" },
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufRead", "VeryLazy" },
    version = false,
    build = ":TSUpdate",
    lazy = true,
    cmd = {
      "TSInstall",
      -- "TSInstallInfo",
      "TSInstallSync",
      "TSUpdate",
      "TSUpdateSync",
      "TSUninstall",
      "TSUninstallInfo",
      "TSInstallFromGrammar",
    },
    opts = function()
      return {
        highlight = { enable = true },
        indent = { enable = true },
        ensure_installed = { "lua", "luadoc", "printf", "vim", "vimdoc" },
        incremental_selection = {
          enable = true,
        },
        autopairs = {
          enable = true,
        },
      }
    end,
    config = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        ---@type table<string, boolean>
        local added = {}
        opts.ensure_installed = vim.tbl_filter(function(lang)
          if added[lang] then
            return false
          end
          added[lang] = true
          return true
        end, opts.ensure_installed)
      end
      require("nvim-treesitter.configs").setup(opts)
      vim.api.nvim_create_user_command("TSInstallInfo", function()
        vim.cmd("Telescope treesitter_info")
      end, {})
    end,
  },
}
