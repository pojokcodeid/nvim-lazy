local ok, null_ls = pcall(require, "null-ls")
local M = {}

M.list_registered = function(filetype)
  if ok then
    local method = null_ls.methods.FORMATTING
    local registered_providers = require("user.utils.lsp").list_registered_providers_names(filetype)
    return registered_providers[method] or {}
  else
    return {}
  end
end

M.list_registered_all = function()
  local registered_providers = require("user.utils.lsp").list_all_registerd()
  local method = null_ls.methods.FORMATTING
  return registered_providers[method] or {}
end

return M
