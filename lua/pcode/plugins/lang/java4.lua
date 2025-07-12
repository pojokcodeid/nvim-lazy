return {
  "nvim-java/nvim-java",
  -- ft = { "java" },
  dependencies = {
    "MunifTanjim/nui.nvim",
    "neovim/nvim-lspconfig",
    "mfussenegger/nvim-dap",
    "williamboman/mason.nvim",
  },
  opts = {
    notifications = {
      dap = false,
    },
    jdk = {
      auto_install = false,
    },

    -- NOTE: One of these files must be in your project root directory.
    --       Otherwise the debugger will end in the wrong directory and fail.
    root_markers = {
      "settings.gradle",
      "settings.gradle.kts",
      "pom.xml",
      "build.gradle",
      "mvnw",
      "gradlew",
      "build.gradle",
      "build.gradle.kts",
      ".git",
    },
  },
}
