local null_ls = require("null-ls")
local M = {}

M.alternative_methods = {
  null_ls.methods.DIAGNOSTICS,
  null_ls.methods.DIAGNOSTICS_ON_OPEN,
  null_ls.methods.DIAGNOSTICS_ON_SAVE,
}

M.linter_list_registered = function(filetype)
  local registered_providers = require("user.utils.lsp").list_registered_providers_names(filetype)
  local providers_for_methods = vim.iter(vim.tbl_map(function(m)
    return registered_providers[m] or {}
  end, M.alternative_methods))

  return providers_for_methods
end

return M
