_G.pcode = _G.pcode or {}
vim.filetype.add({
  pattern = {
    [".*%.blade%.php"] = "blade",
  },
})
require("custom.default")
require("custom.dashboard")
require("config.lazy_lib")
require("user.colorscheme")
require("user.keymaps")
require("core.neovide")
require("custom.autocmd")
require("custom.keymaps")
-- require("user.snip")
-- require("user.nvim-tree")
-- require("user.options")
-- require("user.keymaps")
-- require("user.autocommands")
-- require("user.format_onsave")
-- require("user.snip")
-- require("user.bufferline")
-- require("user.chat_gpt")
-- vim.cmd("colorscheme one_monokai")
-- vim.cmd("colorscheme onedark")
-- vim.cmd("colorscheme github_dark_dimmed")
-- vim.cmd("colorscheme github_dark_high_contrast")

-- local mason_reg = require("mason-registry")
-- for _, pkg in pairs(mason_reg.get_installed_packages()) do
--   for _, type in pairs(pkg.spec.categories) do
--     if type == "LSP" and pkg.spec.name == "jdtls" then
--       print("JDTLS READY")
--     end
--   end
-- end
