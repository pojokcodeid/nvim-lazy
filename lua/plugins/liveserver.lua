return {
  "barrett-ruth/live-server.nvim",
  build = "npm i -g live-server",
  cmd = { "LiveServerStart", "LiveServerStop", "LiveServerToggle" },
  config = true,
  keys = {
    { "<leader>rl", "<cmd>LiveServerToggle<cr>", desc = "LiveServer" },
  },
}
