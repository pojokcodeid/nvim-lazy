return {
  "pojokcodeid/nvim-juliana",
  lazy = false,
  priority = 1000,
  opts = {},
  config = function()
    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "*",
      callback = function()
        -- get colors
        local colors = require("nvim-juliana").colors()
        -- custom hilights
        local hi = vim.api.nvim_set_hl
        hi(0, "FoldColumn", { bg = colors.bg2 })
        hi(0, "MasonBackdrop", { link = "NormalFloat" })
      end,
    })
  end,
}
