-- activate config spesific languages
pcode.lang = {
  angular = false,
  cpp = false,
  deno = false,
  golang = false,
  java = false,
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
  sql = false,
  tailwind = false,
}
-- activate config extras
pcode.extras = {
  autosave = false,
  bigfiles = false,
  bufferline = true,
  cheatsheet = false,
  codeium = false,
  codeiumnvim = false,
  colorizer = false,
  dap = false,
  deviconcolor = false,
  dressing = true,
  fidget = false,
  illuminate = true,
  indentscupe = false,
  liveserver = false,
  lspsignatur = false,
  minianimate = false,
  navic = true,
  neocodeium = true,
  neoscroll = false,
  nvimmenu = false,
  nvimufo = false,
  rainbowdelimiters = true,
  refactoring = false,
  rest = false,
  scrollview = false,
  showkeys = true,
  smartsplit = true,
  telescopediff = false,
  telescopetreesiterinfo = false,
  tinydignostic = false,
  treesittercontex = false,
  verticalcolumn = true,
  visualmulti = true,
  yanky = true,
  zenmode = false,
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
pcode.use_nvimtree = true
pcode.nvimtree_float = false
