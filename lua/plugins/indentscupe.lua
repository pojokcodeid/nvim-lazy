local icons = vim.g.pcode_icons
if vim.g.pcode_indentscope and true or false then
  return {
    "echasnovski/mini.indentscope",
    version = false, -- wait till new 0.7.0 release to put it back on semver
    event = "BufReadPre",
    enabled = vim.g.pcode_indentscope and true or false,
    opts = {
      symbol = icons.ui.LineMiddle,
      options = { try_as_border = true },
    },
    config = function(_, opts)
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "help", "alpha", "dashboard", "NvimTree", "Trouble", "lazy", "mason" },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
      require("mini.indentscope").setup(opts)
    end,
  }
else
  return {}
end
