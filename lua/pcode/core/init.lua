_G.pcode = _G.pcode or {}
require("pcode.user.default")
require("pcode.config.lazy_lib")
require("pcode.user.colorscheme")
require("pcode.core.neovide")

vim.keymap.set({ "n", "v", "x" }, "<C-i>", function()
  require("gemini").ask_gemini()
end, { noremap = true, silent = true, desc = "Prompt Gemini CLI" })
