local ok, null_ls = pcall(require, "null-ls")
local M = {}

if ok then
  M.alternative_methods = {
    null_ls.methods.DIAGNOSTICS,
    null_ls.methods.DIAGNOSTICS_ON_OPEN,
    null_ls.methods.DIAGNOSTICS_ON_SAVE,
  }
else
  M.alternative_methods = {}
end

M.linter_list_registered = function(filetype)
  if ok then
    local registered_providers = require("user.utils.lsp").list_registered_providers_names(filetype)
    local providers_for_methods = vim.iter(vim.tbl_map(function(m)
      return registered_providers[m] or {}
    end, M.alternative_methods))

    return providers_for_methods
  else
    return {}
  end
end

return M
