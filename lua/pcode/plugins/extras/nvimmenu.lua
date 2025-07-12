return {
  {
    "nvzone/menu",
    lazy = true,
    event = { "VeryLazy" },
    dependencies = {
      { "nvzone/volt", lazy = true },
      { "nvzone/showkeys", cmd = "ShowkeysToggle", lazy = true },
      {
        "nvzone/minty",
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
      vim.keymap.set({ "n", "v" }, "<RightMouse>", function()
        require("menu.utils").delete_old_menus()
        vim.cmd.exec('"normal! \\<RightMouse>"')

        local buf = vim.api.nvim_win_get_buf(vim.fn.getmousepos().winid)
        local options = vim.bo[buf].ft == "NvimTree" and "nvimtree" or "default"
        require("menu").open(options, opts)
      end, {})
    end,
  },
}
