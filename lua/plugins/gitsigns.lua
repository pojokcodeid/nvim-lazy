local icons = pcode.icons
return {
  "lewis6991/gitsigns.nvim",
  lazy = true,
  enabled = vim.fn.executable("git") == 1,
  ft = "gitcommit",
  event = "BufRead",
  opts = {
    signs = {
      add = {
        hl = "GitSignsAdd",
        text = icons.ui.BoldLineLeft,
        numhl = "GitSignsAddNr",
        linehl = "GitSignsAddLn",
      },
      change = {
        hl = "GitSignsChange",
        text = icons.ui.BoldLineLeft,
        numhl = "GitSignsChangeNr",
        linehl = "GitSignsChangeLn",
      },
      delete = {
        hl = "GitSignsDelete",
        text = icons.ui.Triangle,
        numhl = "GitSignsDeleteNr",
        linehl = "GitSignsDeleteLn",
      },
      topdelete = {
        hl = "GitSignsDelete",
        text = icons.ui.Triangle,
        numhl = "GitSignsDeleteNr",
        linehl = "GitSignsDeleteLn",
      },
      changedelete = {
        hl = "GitSignsChange",
        text = icons.ui.BoldLineLeft,
        numhl = "GitSignsChangeNr",
        linehl = "GitSignsChangeLn",
      },
    },
    signcolumn = true,
    numhl = false,
    linehl = false,
    word_diff = false,
    watch_gitdir = {
      interval = 1000,
      follow_files = true,
    },
    attach_to_untracked = true,
    current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
      delay = 1000,
      ignore_whitespace = false,
    },
    current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
    sign_priority = 6,
    status_formatter = nil, -- Use default
    update_debounce = 200,
    max_file_length = 40000,
    preview_config = {
      -- Options passed to nvim_open_win
      border = "rounded",
      style = "minimal",
      relative = "cursor",
      row = 0,
      col = 1,
    },
    yadm = { enable = false },
  },
  config = function(_, opts)
    require("gitsigns").setup(opts)
  end,
  keys = {
    { "<leader>g", "", desc = "  Git" },
    {
      "<leader>gg",
      function()
        require("user.utils.whichkey")._LAZYGIT_TOGGLE()
      end,
      desc = "Lazygit",
    },
    {
      "<leader>gj",
      function()
        require("gitsigns").next_hunk()
      end,
      desc = "Next Hunk",
    },
    {
      "<leader>gk",
      function()
        require("gitsigns").prev_hunk()
      end,
      desc = "Prev Hunk",
    },
    {
      "<leader>gl",
      function()
        require("gitsigns").blame_line()
      end,
      desc = "Blame",
    },
    {
      "<leader>gp",
      function()
        require("gitsigns").preview_hunk()
      end,
      desc = "Preview Hunk",
    },
    {
      "<leader>gr",
      function()
        require("gitsigns").reset_hunk()
      end,
      desc = "Reset Hunk",
    },
    {
      "<leader>gR",
      function()
        require("gitsigns").reset_buffer()
      end,
      desc = "Reset Buffer",
    },
    {
      "<leader>gs",
      function()
        require("gitsigns").stage_hunk()
      end,
      desc = "Stage Hunge",
    },
    {
      "<leader>gu",
      function()
        require("gitsigns").undo_stage_hunk()
      end,
      desc = "Undo Stage Hunge",
    },
    {
      "<leader>go",
      "<cmd>Telescope git_status<cr>",
      desc = "Opened Changed File",
    },
    {
      "<leader>gb",
      "<cmd>Telescope git_branches<cr>",
      desc = "Checkout Branch",
    },
    {
      "<leader>gc",
      "<cmd>Telescope git_commits<cr>",
      desc = "Checkout Commit",
    },
    {
      "<leader>gd",
      "<cmd>Gitsigns diffthis HEAD<cr>",
      desc = "Diff",
    },
  },
}
