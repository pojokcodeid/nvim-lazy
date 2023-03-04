local m = {}
-- 0 disable progress
-- 1 lualine lsp progress
-- 2 fidget progress
m.progress = 1
-- style
-- 0 =  default
-- 1 = { left = "", right = "" },
-- 2 = { left = " ", right = " " },
-- 3 = { left = "", right = "" },
m.lualine_style = 0
-- style status icon
-- 0 = default
-- 1 = vim icon " "
-- 2 = vim icon " "
m.status_icon = 0
-- start custom lualine style
-- contoh style
--   {
--     { left = "│", right = "│" },
--     { left = " ", right = " " },
--   },
--   {
--     { left = " ", right = " " },
--     { left = " ", right = "" },
--   },
--   {
--     { left = " ", right = " " },
--     { left = "", right = "" },
--   },
--   {
--     { left = "", right = "" },
--     { left = "", right = "" },
--   },
--   {
--     { left = " ", right = " " },
--     { left = "", right = "" },
--   },
-- }
m.custom_lualine = false
m.component_separators = { left = " ", right = " " }
m.section_separators = { left = "", right = " " }
-- end custom lualine style

-- custom colorscheme
-- colorscheme ready :
-- tokyonight
-- tokyonight-night
-- tokyonight-storm
-- tokyonight-day
-- tokyonight-moon
-- gruvbox-baby (default)
-- sonokai
-- material
-- onedark
-- lunar
-- nord
-- catppuccin
-- dracula
m.colorscheme = "sonokai"
-- custom transparent mode
-- support gruvbox-baby, tokyonight, sonokai
-- 0 =off   1= on
m.transparent_mode = 1
return m
