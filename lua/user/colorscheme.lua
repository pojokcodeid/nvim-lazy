local colorscheme = vim.g.pcode_colorscheme or "gruvbox-baby"

if substring(tostring(colorscheme), "sonokai") then
  colorscheme = "sonokai"
elseif substring(tostring(colorscheme), "material") then
  colorscheme = "material"
end

vim.cmd("colorscheme " .. colorscheme)
