return {
  "pojokcodeid/darcula-dark.nvim",
  priority = 1000,
  lazy = false,
  config = function()
    require("darcula").setup({
      colors = {
        lavender = "#9876AA",
        statusline = "NONE",
      },
    })
    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "*",
      callback = function()
        local colors = require("darcula").colors()
        local hi = vim.api.nvim_set_hl
        hi(0, "@property.json", { fg = colors.lavender })
        hi(0, "@property.jsonc", { fg = colors.lavender })
        hi(0, "LineNr", { ctermfg = 11, fg = colors._39 })
        -- hi(0, "@variable.member.sql", { fg = colors.olive_green })
        -- telescope
        hi(0, "TelescopePromptBorder", { fg = colors.medium_gray })
        hi(0, "TelescopeResultsBorder", { fg = colors.medium_gray })
        hi(0, "TelescopePreviewBorder", { fg = colors.medium_gray })
        hi(0, "TelescopeSelection", { bg = colors.dark_charcoal_gray })
        hi(0, "TelescopeMultiSelection", { bg = colors.dark_charcoal_gray })
        hi(0, "TelescopeNormal", { bg = colors.dark })
        hi(0, "TelescopeMatching", { fg = colors.olive_green })
        hi(0, "TelescopePromptPrefix", { fg = colors.red })
        hi(0, "TelescopeResultsDiffDelete", { fg = colors.red })
        hi(0, "TelescopeResultsDiffChange", { fg = colors.bright_cyan })
        hi(0, "TelescopeResultsDiffAdd", { fg = colors.olive_green })
        hi(0, "TelescopePromptNormal", { bg = colors.dark, fg = colors.grey })
        hi(0, "TelescopePromptPrefix", { bg = colors.dark, fg = colors.red })
        hi(0, "TelescopeResultsTitle", { bg = colors.olive_green, fg = colors.very_dark_gray })
        hi(0, "MasonBackdrop", { link = "NormalFloat" })
      end,
    })
    local colorscheme = pcode.themes.jetbrains or "darcula-dark"
    vim.cmd("colorscheme " .. colorscheme)
  end,
}
