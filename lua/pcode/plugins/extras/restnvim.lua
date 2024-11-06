-- install luarock
-- sudo apt-get install luarocks lua5.4 (untuk linux)
-- https://github.com/luarocks/luarocks/wiki/Installation-instructions-for-Windows

-- manual penggunaan
-- https://www.jetbrains.com/help/idea/exploring-http-syntax.html
return {
  "rest-nvim/rest.nvim",
  -- NOTE: Follow https://github.com/rest-nvim/rest.nvim/issues/306
  -- commit = "91badd46c60df6bd9800c809056af2d80d33da4c",
  event = "VeryLazy",
  enabled = vim.fn.executable("luarocks") == 1,
  dependencies = {
    {
      "nvim-treesitter/nvim-treesitter",
      opts = function(_, opts)
        vim.list_extend(opts.ensure_installed, { "http" })
      end,
    },
  },
  config = function()
    require("rest-nvim").setup()
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "http", "httpResult" },
      callback = function()
        local opt = vim.opt
        opt.number = false -- Print line number
        opt.preserveindent = false -- Preserve indent structure as much as possible
        opt.relativenumber = false
      end,
    })
  end,
  ft = "http",
  keys = {
    {
      "<Leader>rh",
      "<cmd>Rest run<cr>",
      desc = "Run http request under cursor",
    },
    {
      "<Leader>rH",
      "<cmd>Rest last<cr>",
      desc = "Run last http request",
    },
  },
}
