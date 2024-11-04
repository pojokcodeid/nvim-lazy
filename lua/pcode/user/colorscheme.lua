if pcode.themes then
  local theme = ""
  for _, value in pairs(pcode.themes or {}) do
    theme = value
  end
  pcall(vim.cmd.colorscheme, theme)
end
