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
m.colorscheme = "gruvbox-baby"

return m
