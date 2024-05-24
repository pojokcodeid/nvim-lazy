local colorscheme = vim.g.pcode_colorscheme or "gruvbox-baby"
local transparent_mode = vim.g.pcode_transparent_mode or 0
if transparent_mode ~= nil then
  if transparent_mode == 1 then
    vim.g.gruvbox_baby_transparent_mode = 1
    vim.g.sonokai_transparent_background = 2
  end
end

if substring(tostring(colorscheme), "sonokai") then
  colorscheme = "sonokai"
elseif substring(tostring(colorscheme), "material") then
  colorscheme = "material"
end

vim.cmd("colorscheme " .. colorscheme)
