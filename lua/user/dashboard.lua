local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
  return
end

local board = {
  [[             _       _                    _      ]],
  [[            (_)     | |                  | |     ]],
  [[ _ __   ___  _  ___ | | __   ___ ___   __| | ___ ]],
  [[| '_ \ / _ \| |/ _ \| |/ /  / __/ _ \ / _` |/ _ \]],
  [[| |_) | (_) | | (_) |   <  | (_| (_) | (_| |  __/]],
  [[| .__/ \___/| |\___/|_|\_\  \___\___/ \__,_|\___|]],
  [[| |        _/ |                                  ]],
  [[|_|       |__/                                   ]],
}

local data_board = vim.g.pcode_header2
if data_board ~= nil then
  board = data_board
end

local dashboard = require("alpha.themes.dashboard")
dashboard.section.header.val = board
dashboard.section.buttons.val = {
  dashboard.button("F", "󰈞  Find file", ":Telescope find_files <CR>"),
  dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
  dashboard.button("p", "󰉋  Find project", ":Telescope projects <CR>"),
  dashboard.button("r", "󰦛  Recently used files", ":Telescope oldfiles <CR>"),
  dashboard.button("t", "󰊄  Find text", ":Telescope live_grep <CR>"),
  dashboard.button("c", "  Configuration", ":e $MYVIMRC <CR>"),
  dashboard.button("z", "󰒲  Lazy", ":Lazy<CR>"),
  dashboard.button("q", "󰅚  Quit", ":qa<CR>"),
}

dashboard.section.footer.opts.hl = "Type"
dashboard.section.header.opts.hl = "Include"
dashboard.section.buttons.opts.hl = "Keyword"

dashboard.opts.opts.noautocmd = true
-- vim.cmd([[autocmd User AlphaReady echo 'ready']])
alpha.setup(dashboard.opts)

local footer_text = "Pojok Code"
local data_txt = vim.g.pcode_footer
if data_txt ~= nil then
  footer_text = data_txt
end

vim.api.nvim_create_autocmd("User", {
  pattern = "LazyVimStarted",
  desc = "Add Alpha dashboard footer",
  once = true,
  callback = function()
    local stats = require("lazy").stats()
    local ms = math.floor(stats.startuptime * 100 + 0.5) / 100
    dashboard.section.footer.val =
      { footer_text .. " " .. stats.loaded .. "/" .. stats.count .. " plugins  in " .. ms .. "ms" }
    pcall(vim.cmd.AlphaRedraw)
  end,
})

vim.api.nvim_create_autocmd({ "User" }, {
  pattern = { "AlphaReady" },
  callback = function()
    vim.cmd([[
      set laststatus=0 | autocmd BufUnload <buffer> set laststatus=3
    ]])
  end,
})
