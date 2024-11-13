-- activate config spesific languages
pcode.lang = {
  angular = false,
  cpp = false,
  sql = false,
  deno = false,
  golang = false,
  java = true,
  java2 = false,
  java3 = false,
  java4 = false,
  javascript = false,
  kotlin = false,
  markdown = false,
  php = false,
  prisma = false,
  python = false,
  rust = false,
  tailwind = false,
}
-- activate config extras
pcode.extras = {
  autosave = false,
  bigfiles = false,
  codeiumnvim = false,
  liveserver = false,
  minianimate = false,
  neoscroll = false,
  nvimufo = false,
  refactoring = true,
  rest = false,
  treesittercontex = false,
  codeium = true,
  colorizer = true,
  dap = true,
  deviconcolor = true,
  illuminate = true,
  indentscupe = true,
  navic = true,
  nvimmenu = true,
  rainbowdelimiters = true,
  scrollview = true,
  smartsplit = true,
  verticalcolumn = true,
  visualmulti = true,
  yanky = true,
  zenmode = true,
  lspsignatur = true,
  telescopetreesiterinfo = true,
}
-- activate config themes
pcode.themes = {
  -- note: open remark only one
  -- **:: Eva Theme ::** --
  evatheme = "Eva-Dark",
  -- evatheme = "Eva-Dark-Italic",
  -- evatheme = "Eva-Dark-Bold",
  -- evatheme = "Eva-Light",
  --
  -- **:: Dracula Theme ::** --
  -- dracula = "dracula",
  -- dracula = "dracula-soft",
  --
  -- **:: Onedarkpro Theme ::** --
  -- onedarkpro = "onedark",
  -- onedarkpro = "onedark_vivid",
  -- onedarkpro = "onedark_dark",
  --
  -- **:: Jetbrains Theme ::** --
  -- jetbrains = "darcula-dark",
  --
  -- **:: Sublimetext Theme ::** --
  -- sublimetext = "juliana",
  --
  -- **:: Tokyonight Theme ::** --
  -- tokyonight = "tokyonight-night",
  -- tokyonight = "tokyonight-storm",
  -- tokyonight = "tokyonight-day",
  -- tokyonight = "tokyonight-moon",
  --
  -- **:: Catppuccin Theme ::** --
  -- catppuccin = "catppuccin",
  -- catppuccin = "catppuccin-latte",
  -- catppuccin = "catppuccin-frappe",
  -- catppuccin = "catppuccin-macchiato",
  -- catppuccin = "catppuccin-macchiato",
  --
  -- **:: Gruvbox Theme ::** --
  -- gruvbox = "gruvbox",
  --
  -- **:: Github Theme ::** --
  -- github = "github_dark_dimmed",
}
-- activate config transparent_bg
pcode.transparent = false
pcode.localcode = true
pcode.snippets_path = vim.fn.stdpath("config") .. "/mysnippets"
