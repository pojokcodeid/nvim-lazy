return {
  "rcarriga/nvim-notify",
  lazy = true,
  event = "VeryLazy",
  keys = {
    {
      "<leader>uN",
      function()
        require("notify").dismiss({ silent = true, pending = true })
      end,
      desc = "Delete all Notifications",
    },
  },
  opts = {
    timeout = 3000,
    max_height = function()
      return math.floor(vim.o.lines * 0.75)
    end,
    max_width = function()
      return math.floor(vim.o.columns * 0.4)
    end,
    render = "wrapped-compact",
    -- background_colour = "#00000000",
  },
  config = function(_, opts)
    local notify = require("notify")
    notify.setup(opts)
    vim.notify = notify.notify
  end,
}
