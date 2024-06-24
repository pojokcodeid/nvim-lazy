local null_ls = require("null-ls")
local M = {}

M.list_registered = function(filetype)
  local method = null_ls.methods.FORMATTING
  local registered_providers = require("user.utils.lsp").list_registered_providers_names(filetype)
  return registered_providers[method] or {}
end

M.list_registered_all = function()
  local registered_providers = require("user.utils.lsp").list_all_registerd()
  local method = null_ls.methods.FORMATTING
  return registered_providers[method] or {}
end

return M
