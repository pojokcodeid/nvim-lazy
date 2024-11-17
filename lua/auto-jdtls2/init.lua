local M = {}

M.setup = function(opt)
  opt = opt or {}
  require("auto-jdtls.utils").install()
  require("auto-jdtls.create_gradle_project")
  require("auto-jdtls.create_maven_project")
  require("auto-jdtls.create_springboot_project")
  require("auto-jdtls.generate_java_class")
  require("auto-jdtls.generate_java_interface")
  require("auto-jdtls.generate_java_main_class")
  require("auto-jdtls.utils").attach_jdtls(opt)
end

return M
