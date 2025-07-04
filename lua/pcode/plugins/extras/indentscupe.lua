local icons = require("pcode.user.icons")
return {
  "echasnovski/mini.indentscope",
  version = false, -- wait till new 0.7.0 release to put it back on semver
  event = "BufReadPre",
  opts = {
    symbol = icons.ui.LineMiddle,
    options = { try_as_border = true },
  },
  init = function()
    vim.api.nvim_create_autocmd("FileType", {
      pattern = {
        "alpha",
        "dashboard",
        "fzf",
        "help",
        "lazy",
        "lazyterm",
        "mason",
        "neo-tree",
        "NvimTree",
        "notify",
        "toggleterm",
        "Trouble",
        "trouble",
        "term",
        "terminal",
        "zsh",
        "keymaps_table",
      },
      callback = function()
        vim.b.miniindentscope_disable = true
      end,
    })
  end,
}
