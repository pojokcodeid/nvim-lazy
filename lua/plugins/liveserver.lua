return {
  "barrett-ruth/live-server.nvim",
  build = "npm i -g live-server",
  cmd = { "LiveServerStart", "LiveServerStop", "LiveServerToggle" },
  config = true,
  keys = {
    { "<leader>rl", "", desc = " LiveServer" },
    { "<leader>rls", "<cmd>LiveServerStart<cr>", desc = "LiveServerStart" },
    { "<leader>rlq", "<cmd>LiveServerStop<cr>", desc = "LiveServerStop" },
  },
}
