return {
  "rcarriga/nvim-notify",
  lazy = true,
  event = "VeryLazy",
  keys = {
    {
      "<leader>un",
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
      return math.floor(vim.o.columns * 0.75)
    end,
    render = "wrapped-compact",
  },
  -- event = "BufWinEnter",
  config = function(_, opts)
    local notify = require("notify")
    -- this for transparency
    -- notify.setup { background_colour = "#000000", render = "compact" }
    -- notify.setup({ render = "compact" })
    notify.setup(opts)
    -- this overwrites the vim notify function
    vim.notify = notify.notify
  end,
}
