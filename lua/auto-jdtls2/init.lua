local M = {}

M.setup = function(opt)
  opt = opt or {}
  require("auto-jdtls.utils").attach_jdtls(opt)
end

return M
