local M = {}

M.setup = function(opt)
  opt = opt or {}
  require("auto-jdtls2.create_gradle_project")
  require("auto-jdtls2.create_maven_project")
  require("auto-jdtls2.create_springboot_project")
  require("auto-jdtls2.generate_java_class")
  require("auto-jdtls2.generate_java_interface")
  require("auto-jdtls2.generate_java_main_class")
  -- require("auto-jdtls2.utils").install()
  -- require("auto-jdtls2.utils").attach_jdtls(opt)
end

return M
