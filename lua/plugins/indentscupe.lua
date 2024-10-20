local icons = pcode.icons
if pcode.indentscope and true or false then
  return {
    "echasnovski/mini.indentscope",
    version = false, -- wait till new 0.7.0 release to put it back on semver
    event = "BufReadPre",
    enabled = pcode.indentscope and true or false,
    opts = {
      symbol = icons.ui.LineMiddle,
      options = { try_as_border = true },
    },
    config = function(_, opts)
      require("mini.indentscope").setup(opts)
    end,
  }
else
  return {}
end
