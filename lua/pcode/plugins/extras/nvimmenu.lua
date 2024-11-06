return {
  {
    "nvchad/menu",
    lazy = true,
    event = { "VeryLazy" },
    dependencies = {
      { "nvchad/volt", lazy = true },
      {
        "nvchad/minty",
        cmd = { "Shades", "Huefy" },
        lazy = true,
      },
    },
    opts = {
      mouse = true,
      border = true,
    },
    config = function(_, opts)
      -- Keyboard users
      vim.keymap.set("n", "<C-t>", function()
        require("menu").open("default")
      end, {})

      -- mouse users + nvimtree users!
      vim.keymap.set("n", "<RightMouse>", function()
        vim.cmd.exec('"normal! \\<RightMouse>"')

        local options = vim.bo.ft == "NvimTree" and "nvimtree" or "default"
        require("menu").open(options, opts)
      end, {})
    end,
  },
}
