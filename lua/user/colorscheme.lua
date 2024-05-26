local colorscheme = vim.g.pcode_colorscheme or "gruvbox-baby"

if substring(tostring(colorscheme), "sonokai") then
  colorscheme = "sonokai"
elseif substring(tostring(colorscheme), "material") then
  colorscheme = "material"
end

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  return
end
