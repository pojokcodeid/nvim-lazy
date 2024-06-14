return {
  -- dashboard
  {
    "goolord/alpha-nvim",
    lazy = true,
    event = "VimEnter",
    config = function()
      require("user.alpha")
    end,
  },
}
