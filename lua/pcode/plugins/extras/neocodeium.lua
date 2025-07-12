return {
  "monkoose/neocodeium",
  event = "VeryLazy",
  config = function()
    local neocodeium = require("neocodeium")
    neocodeium.setup()
    vim.keymap.set("i", "<C-g>", function()
      neocodeium.accept()
    end)
    vim.keymap.set("i", "<c-Down>", function()
      neocodeium.cycle()
    end)
    vim.keymap.set("i", "<c-Up>", function()
      require("neocodeium").cycle(-1)
    end)
    vim.keymap.set("i", "<c-x>", function()
      require("neocodeium").clear()
    end)
  end,
}
