local alpha = require("alpha")
local startify = require("alpha.themes.startify")
local dash_model = {}
dash_model = {
  [[                _      __                __    ]],
  [[    ___ ___    (____  / /__  _______ ___/ ___  ]],
  [[   / _ / _ \  / / _ \/  '_/ / __/ _ / _  / -_) ]],
  [[  / .__\_____/ /\___/_/\_\  \__/\___\_,_/\__/  ]],
  [[ /_/      |___/                                ]],
  [[              Powered By  eovim              ]],
}

local board = pcode.header1
if board ~= nil then
  dash_model = board
end

startify.section.header.val = dash_model
startify.section.top_buttons.val = {
  startify.button("F", "󰈞  Find file", ":Telescope find_files <CR>"),
  startify.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
  startify.button("p", "󰉋  Find project", ":Telescope projects <CR>"),
  startify.button("r", "󰦛  Recently used files", ":Telescope oldfiles <CR>"),
  startify.button("t", "󰊄  Find text", ":Telescope live_grep <CR>"),
  startify.button("c", "  Configuration", ":e $MYVIMRC <CR>"),
  startify.button("z", "󰒲  Lazy", ":Lazy<CR>"),
}
-- disable MRU
startify.section.mru.val = { { type = "padding", val = 4 } }
-- disable MRU cwd
startify.section.mru_cwd.val = { { type = "padding", val = 0 } }
-- disable nvim_web_devicons
startify.nvim_web_devicons.enabled = false
-- startify.nvim_web_devicons.highlight = false
-- startify.nvim_web_devicons.highlight = 'Keyword'
--
startify.section.bottom_buttons.val = {
  startify.button("q", "󰅚  Quit", ":qa<CR>"),
}

local footer_text = "Pojok Code"
local data_txt = pcode.footer
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
    startify.section.footer.val = {
      -- {
      --   type = "text",
      --   val = {
      --     "───────────────────────────────────────────────",
      --   },
      -- },
      {
        type = "text",
        val = {
          footer_text .. " " .. stats.loaded .. "/" .. stats.count .. " plugins  in " .. ms .. "ms",
        },
      },
      -- {
      --   type = "text",
      --   val = {
      --     "───────────────────────────────────────────────",
      --   },
      -- },
    }
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
-- ignore filetypes in MRU
local default_mru_ignore = {}
startify.mru_opts.ignore = function(path, ext)
  return (string.find(path, "COMMIT_EDITMSG")) or (vim.tbl_contains(default_mru_ignore, ext))
end
alpha.setup(startify.config)
