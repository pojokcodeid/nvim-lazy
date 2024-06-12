local colorscheme = vim.g.pcode_colorscheme or "gruvbox-baby"

if substring(tostring(colorscheme), "sonokai") then
  colorscheme = "sonokai"
elseif substring(tostring(colorscheme), "material") then
  colorscheme = "material"
end

local ok, _ = pcall(vim.cmd.colorscheme, colorscheme)
if not ok then
  require "notify"("Colorscheme '" .. colorscheme .. "' not found!", "error")
end
