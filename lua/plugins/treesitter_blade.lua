local ts_list = {
  "lua",
  "vim",
  "vimdoc",
}
for _, ts in pairs(pcode.treesitter_ensure_installed or {}) do
  table.insert(ts_list, ts)
end
return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = ts_list,
    },
    config = function(_, opts)
      local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

      parser_config.blade = {
        install_info = {
          url = "https://github.com/EmranMR/tree-sitter-blade",
          files = { "src/parser.c" },
          branch = "main",
        },
        filetype = "blade",
      }

      vim.filetype.add({
        pattern = {
          [".*%.blade%.php"] = "blade",
        },
      })

      require("nvim-treesitter.configs").setup(opts)
    end,
  },
}
