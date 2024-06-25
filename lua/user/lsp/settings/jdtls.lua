return {
  cmd = { "jdtls" },
  filetypes = { "java" },
  root_dir = require("lspconfig.util").root_pattern(
    -- Single-module projects
    {
      "build.xml", -- Ant
      "pom.xml", -- Maven
      "settings.gradle", -- Gradle
      "settings.gradle.kts", -- Gradle
    },
    -- Multi-module projects
    { "build.gradle", "build.gradle.kts" }
  ) or vim.fn.getcwd(),
  singe_file_support = true,
}
