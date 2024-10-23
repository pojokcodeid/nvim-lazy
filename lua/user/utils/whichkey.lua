local M = {}

function M._LAZYGIT_TOGGLE()
  local Terminal = require("toggleterm.terminal").Terminal
  local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })
  lazygit:toggle()
end

function M._NODE_TOGGLE()
  local Terminal = require("toggleterm.terminal").Terminal
  local node = Terminal:new({ cmd = "node", hidden = true })
  node:toggle()
end

function M._BTOP_TOGGLE()
  local Terminal = require("toggleterm.terminal").Terminal
  local htop = Terminal:new({ cmd = "btop", hidden = true })
  htop:toggle()
end

function M._PYTHON_TOGGLE()
  local Terminal = require("toggleterm.terminal").Terminal
  local python = Terminal:new({ cmd = "python", hidden = true })
  python:toggle()
end

function M._NEWTAB_TOGGLE()
  local Terminal = require("toggleterm.terminal").Terminal
  local pwsh = Terminal:new({ cmd = "pwsh", hidden = true, direction = "tab" })
  pwsh:toggle()
end

function M._OPEN_EXPLORER()
  local Terminal = require("toggleterm.terminal").Terminal
  local pwsh = Terminal:new({ cmd = "explorer .", hidden = true, direction = "tab" })
  pwsh:toggle()
end

function M._LIVE_SERVER()
  local Terminal = require("toggleterm.terminal").Terminal
  local live_server = Terminal:new({
    cmd = "live-server",
    hidden = true,
    direction = "tab",
  })
  live_server:toggle()
end

function M._OPEN_ALACRITTY()
  -- open alacritty new windows current directory
  vim.cmd("silent !alacritty --working-directory " .. vim.fn.getcwd())
end

function M._OPEN_WEZTERM()
  -- open wezterm new windows current directory
  vim.cmd("silent !wezterm start --cwd " .. vim.fn.getcwd())
end

-- get folder name from current directory
function M._get_folder_name()
  return vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
end

function M._OPEN_WEZTERM_TAB()
  -- open new tab wezterm current directory
  vim.cmd('silent !wezterm cli spawn --cwd "' .. vim.fn.getcwd() .. '"')
end

function M._SET_TAB_TITLE()
  -- set tab title
  vim.cmd('silent !wezterm cli set-tab-title "' .. M._get_folder_name() .. '"')
end

function M._CLOSE_BUFFER()
  local buf = vim.api.nvim_get_current_buf()
  --  delete current buffer
  require("auto-bufferline.configs.utils").bufremove(buf)
end

-- function for close all bufferline
function M._CLOSE_ALL_BUFFER()
  -- get all buffer
  local bufs = vim.api.nvim_list_bufs()
  -- loop through all buffer
  for _, buf in pairs(bufs) do
    require("auto-bufferline.configs.utils").bufremove(buf)
  end
end

M.mappings = {}
return M
