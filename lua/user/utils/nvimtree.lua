local M = {}
local HEIGHT_RATIO = 0.9 -- You can change this
local WIDTH_RATIO = 0.5 -- You can change this too

M.float = {
  adaptive_size = false,
  centralize_selection = true,
  -- width = 30,
  side = "left",
  preserve_window_proportions = false,
  number = false,
  relativenumber = false,
  signcolumn = "yes",
  float = {
    enable = true,
    open_win_config = function()
      local screen_w = vim.opt.columns:get()
      local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
      local window_w = screen_w * WIDTH_RATIO
      local window_h = screen_h * HEIGHT_RATIO
      local window_w_int = math.floor(window_w)
      local window_h_int = math.floor(window_h)
      local center_x = (screen_w - window_w) / 2
      local center_y = ((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get()
      return {
        border = "rounded",
        relative = "editor",
        row = center_y,
        col = center_x,
        width = window_w_int,
        height = window_h_int,
      }
    end,
  },
  width = function()
    return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
  end,
}

M.normal = {
  adaptive_size = false,
  centralize_selection = true,
  width = 30,
  side = "left",
  preserve_window_proportions = false,
  number = false,
  relativenumber = false,
  signcolumn = "yes",
  float = {
    enable = false,
    quit_on_focus_loss = true,
    open_win_config = {
      relative = "editor",
      border = "rounded",
      width = 30,
      height = 30,
      row = 1,
      col = 1,
    },
  },
}
return M
