vim.filetype.add({
  extension = {
    ["http"] = "http",
  },
})
return {
  {
    "mistweaverco/kulala.nvim",
    ft = "http",
    keys = {
      { "<leader>R", "", desc = " 󰖟 Rest" },
      { "<leader>Rs", "<cmd>lua require('kulala').run()<cr>", desc = "Send the request" },
      { "<leader>Rt", "<cmd>lua require('kulala').toggle_view()<cr>", desc = "Toggle headers/body" },
      { "<leader>Rp", "<cmd>lua require('kulala').jump_prev()<cr>", desc = "Jump to previous request" },
      { "<leader>Rn", "<cmd>lua require('kulala').jump_next()<cr>", desc = "Jump to next request" },
    },
    opts = {
      ui = {
        winbar = true,
        winbar_labels_keymaps = true,
        show_request_summary = false,
        -- display mode: possible values: "split", "float"
        display_mode = "float",
        default_view = "headers_body",
        disable_news_popup = true,
        win_opts = {
          title = "Pojok Code",
        },
        icons = {
          inlay = {
            loading = " ",
            done = " ", -- dari FontAwesome atau emoji
            error = " ",
          },
          lualine = "🐼",
          textHighlight = "WarningMsg", -- highlight group for request elapsed time
        },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "http", "graphql" })
      return opts
    end,
  },
}
