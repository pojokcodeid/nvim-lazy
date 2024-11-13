return {
  "nvim-java/nvim-java",
  -- event = "VeryLazy",
  ft = { "java" },
  dependencies = {
    "MunifTanjim/nui.nvim",
    "neovim/nvim-lspconfig",
    "mfussenegger/nvim-dap",
    "williamboman/mason.nvim",
  },
  config = function()
    require("java").setup({
      notifications = {
        dap = false,
      },
      jdk = {
        auto_install = false,
      },
    })
    require("lspconfig").jdtls.setup({
      settings = {
        java = {
          configuration = {
            runtimes = {
              {
                name = "JavaSE-17",
                path = os.getenv("JAVA_HOME") or "",
                default = true,
              },
            },
          },
        },
      },
    })
  end,
  keys = {
    { "<leader>rg", "", desc = "Gradle" },
    { "<leader>rgp", "<cmd>JavaProfile<cr>", desc = "Java Profile" },
    { "<leader>rgg", "<cmd>terminal<cr>gradle run<cr>", desc = "Run Gradle" },
    { "<leader>rgb", "<cmd>JavaBuildBuildWorkspace<cr>", desc = "Java Build Workspace" },
    { "<leader>rgd", "<cmd>JavaDapConfig<cr>", desc = "Java Configure DAP" },
    { "<leader>T", "", desc = "Test" },
    { "<leader>Tc", "<cmd>JavaTestRunCurrentClass<cr>", desc = "Test Current Class" },
    { "<leader>Tm", "<cmd>JavaTestRunCurrentMethod<cr>", desc = "Test Current Method" },
    { "<leader>Th", "<cmd>JavaTestViewLastReport<cr>", desc = "View Test Last Report" },
  },
}
