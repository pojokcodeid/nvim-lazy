return {
  "shellRaining/hlchunk.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("hlchunk").setup({
      chunk = {
        enable = true,
        -- ...
      },
      indent = {
        enable = true,
        -- ...
      },
      exclude_filetypes = {
        aerial = true,
        dashboard = true,
        alpha = true,
        -- some other filetypes
      },
    })
  end,
}
