return {
  "akinsho/toggleterm.nvim",
  lazy = true,
  cmd = {
    "ToggleTerm",
    "TermExec",
    "ToggleTermToggleAll",
    "ToggleTermSendCurrentLine",
    "ToggleTermSendVisualLines",
    "ToggleTermSendVisualSelection",
  },
  branch = "main",
  enabled = true,
  opts = {
    size = 20,
    open_mapping = [[<c-\>]],
    hide_numbers = true,
    shade_filetypes = {},
    shade_terminals = true,
    shading_factor = 2,
    start_in_insert = true,
    insert_mappings = true,
    persist_size = true,
    direction = "float",
    close_on_exit = true,
    shell = vim.o.shell,
    float_opts = {
      border = "curved",
      winblend = 0,
      highlights = {
        border = "Normal",
        background = "Normal",
      },
    },
  },
  config = function(_, opts)
    require("toggleterm").setup(opts)
    function _G.set_terminal_keymaps()
      local optsn = { noremap = true }
      vim.api.nvim_buf_set_keymap(0, "t", "<esc>", [[<C-\><C-n>]], optsn)
      vim.api.nvim_buf_set_keymap(0, "t", "jk", [[<C-\><C-n>]], optsn)
      vim.api.nvim_buf_set_keymap(0, "t", "<C-h>", [[<C-\><C-n><C-W>h]], optsn)
      vim.api.nvim_buf_set_keymap(0, "t", "<C-j>", [[<C-\><C-n><C-W>j]], optsn)
      vim.api.nvim_buf_set_keymap(0, "t", "<C-k>", [[<C-\><C-n><C-W>k]], optsn)
      vim.api.nvim_buf_set_keymap(0, "t", "<C-l>", [[<C-\><C-n><C-W>l]], optsn)
    end
    vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
  end,
  keys = {
    { "<leader>t", "", desc = "  Terminal", mode = "n" },
    { "<leader>tl", "<cmd>terminal live-server<cr>", desc = "Live Server", mode = "n" },
    { "<leader>tP", "<cmd>lua require('user.utils.whichkey')._NEWTAB_TOGGLE()<cr>", desc = "Power Shell", mode = "n" },
    { "<leader>tx", "<cmd>ToggleTermToggleAll!<cr>", desc = "Close Tab", mode = "n" },
    { "<leader>tn", "<cmd>lua require('user.utils.whichkey')._NODE_TOGGLE()<cr>", desc = "Node", mode = "n" },
    { "<leader>tb", "<cmd>lua require('user.utils.whichkey')._BTOP_TOGGLE()<cr>", desc = "Btop", mode = "n" },
    { "<leader>tp", "<cmd>lua require('user.utils.whichkey')._PYTHON_TOGGLE()<cr>", desc = "Python", mode = "n" },
    { "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", desc = "Float", mode = "n" },
    { "<leader>th", "<cmd>ToggleTerm size=10 direction=horizontal<cr>", desc = "Horizontal", mode = "n" },
    { "<leader>tv", "<cmd>ToggleTerm size=80 direction=vertical<cr>", desc = "Vertical", mode = "n" },
    { "<leader>ts", "<cmd>ToggleTerm direction=tab<cr>", desc = "New Tab", mode = "n" },
    { "<leader>ta", "<cmd>lua require('user.utils.whichkey')._OPEN_ALACRITTY()<cr>", desc = "Open Alacritty", mode = "n" },
    { "<leader>tw", "<cmd>lua require('user.utils.whichkey')._OPEN_WEZTERM()<cr>", desc = "Open Wezterm", mode = "n" },
    {
      "<leader>tt",
      "<cmd>lua require('user.utils.whichkey')._OPEN_WEZTERM_TAB()<cr>",
      desc = "Open Tab Wezterm",
      mode = "n",
    },
    { "<leader>tj", "<cmd>lua _SET_TAB_TITLE()<cr>", desc = "Set Tab Title", mode = "n" },
  },
}
