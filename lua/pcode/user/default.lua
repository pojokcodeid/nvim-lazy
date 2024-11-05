-- activate config spesific languages
pcode.lang = {
  angular = false,
  cpp = false,
  sql = false,
  deno = false,
  golang = false,
  java = false,
  javascript = false,
  kotlin = false,
  markdown = false,
  php = true,
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
  refactoring = false,
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
}
-- activate config transparent_bg
pcode.transparent = false
pcode.localcode = true
pcode.snippets_path = vim.fn.stdpath("config") .. "/mysnippets"
