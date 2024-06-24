local run = 0
local frmt = pcode.format_on_save or 0
if frmt == 1 then
  run = 1
else
  run = 0
end

local buf_clients = vim.lsp.get_clients()
if next(buf_clients) == nil then
  run = 0
end

if run == 1 then
  -- function FORMAT_FILTER(client)
  --   local filetype = vim.bo.filetype
  --   local n = require("null-ls")
  --   local s = require("null-ls.sources")
  --   local method = n.methods.FORMATTING
  --   local available_formatters = s.get_available(filetype, method)
  --
  --   if #available_formatters > 0 then
  --     return client.name == "null-ls"
  --   elseif client.supports_method("textDocument/formatting") then
  --     return true
  --   else
  --     return false
  --   end
  -- end
  --
  -- vim.cmd([[
  -- augroup _lsp
  --      autocmd!
  --      " autocmd BufWritePre * lua vim.lsp.buf.format{timeout_ms =200, filter=format_filter}
  --      autocmd BufWritePre * lua vim.lsp.buf.format{timeout_ms=pcode.format_timeout_ms or 5000 ,filter=FORMAT_FILTER}
  --   augroup end
  -- ]])

  ---filter passed to vim.lsp.buf.format
  ---always selects null-ls if it's available and caches the value per buffer
  ---@param client table client attached to a buffer
  ---@return boolean if client matches
  function FORMAT_FILTER(client)
    local filetype = vim.bo.filetype
    local n = require("null-ls")
    local s = require("null-ls.sources")
    local method = n.methods.FORMATTING
    local available_formatters = s.get_available(filetype, method)

    if #available_formatters > 0 then
      return client.name == "null-ls"
    elseif client.supports_method("textDocument/formatting") then
      return true
    else
      return false
    end
  end
  vim.api.nvim_create_autocmd("BufWritePre", {
    group = "lsp_format_on_save",
    pattern = "*",
    callback = function()
      vim.lsp.buf.format({ timeout_ms = pcode.format_timeout_ms or 5000, filter = FORMAT_FILTER })
    end,
  })
else
  vim.schedule(function()
    pcall(function()
      vim.api.nvim_clear_autocmds({ group = "lsp_format_on_save" })
    end)
  end)
end
