local model = pcode.model
if model ~= nil then
  if model == 1 then
    require("user.startify")
  else
    require("user.dashboard")
  end
else
  require("user.startify")
end

-- Disable statusline in dashboard
vim.api.nvim_create_autocmd("FileType", {
  pattern = "alpha",
  callback = function()
    -- store current statusline value and use that
    local old_laststatus = vim.opt.laststatus
    vim.api.nvim_create_autocmd("BufUnload", {
      buffer = 0,
      callback = function()
        vim.opt.laststatus = old_laststatus
      end,
    })
    vim.opt.laststatus = 0
  end,
})
