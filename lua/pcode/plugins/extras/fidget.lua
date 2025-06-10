return {
  "j-hui/fidget.nvim",
  lazy = true,
  tag = "legacy",
  event = "BufRead",
  config = function()
    require("fidget").setup({
      window = {
        blend = 0,
        relative = "editor",
      },
    })
  end,
}
