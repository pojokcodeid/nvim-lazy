return {
  "dstein64/nvim-scrollview",
  lazy = true,
  event = { "BufRead", "InsertEnter", "BufNewFile" },
  opts = {
    bg = "LightCyan",
    ctermbg = 160,
  },
  config = function(_, opts)
    require("scrollview").setup(opts)
    vim.g.scrollview_excluded_filetypes = { "NvimTree", "vista_kind", "Outline", "neo-tree" }
  end,
}
