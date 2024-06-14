return {
  {
    "rafamadriz/friendly-snippets",
    event = "InsertEnter",
    lazy = true,
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
      require("user.snippets")
      require("user.snip")
    end,
  },
  {
    "L3MON4D3/LuaSnip",
    lazy = true,
    opts = {
      history = true,
      delete_check_events = "TextChanged",
    },
    -- stylua: ignore
    keys = {
      { "<tab>",   function() require("luasnip").jump(1) end,  mode = "s" },
      { "<s-tab>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
    },
  },
}
