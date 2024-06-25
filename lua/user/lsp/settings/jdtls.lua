local function directory_exists(path)
  local f = io.popen("cd " .. path)
  local ff = f:read("*all")

  if ff:find("ItemNotFoundException") then
    return false
  else
    return true
  end
end

-- calculate workspace dir
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = vim.fn.stdpath("data") .. "/site/java/workspace-root/" .. project_name
if directory_exists(workspace_dir) then
else
  os.execute("mkdir " .. workspace_dir)
end
-- get the mason install path
local install_path = require("mason-registry").get_package("jdtls"):get_install_path()

-- get the current OS
local os
if vim.fn.has("macunix") then
  os = "mac"
elseif vim.fn.has("win32") then
  os = "win"
else
  os = "linux"
end

return {
  cmd = {
    "java",
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-javaagent:" .. install_path .. "/lombok.jar",
    "-Xms1g",
    "--add-modules=ALL-SYSTEM",
    "--add-opens",
    "java.base/java.util=ALL-UNNAMED",
    "--add-opens",
    "java.base/java.lang=ALL-UNNAMED",
    "-jar",
    vim.fn.glob(install_path .. "/plugins/org.eclipse.equinox.launcher_*.jar"),
    "-configuration",
    install_path .. "/config_" .. os,
    "-data",
    workspace_dir,
  },
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
