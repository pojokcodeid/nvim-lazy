local path = require("mason-registry").get_package("php-debug-adapter"):get_install_path()
return {
  ype = "executable",
  command = "node",
  args = { path .. "/extension/out/phpDebug.js" },
}
