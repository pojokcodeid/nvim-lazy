return {
  "barrett-ruth/live-server.nvim",
  build = "npm i -g live-server",
  cmd = { "LiveServerStart", "LiveServerStop", "LiveServerToggle" },
  config = true,
  keys = {
    -- open http://localhost:5555/ jika menggunakan wsl
    { "<leader>rl", "<cmd>LiveServerToggle<cr>", desc = "LiveServer" },
  },
}
