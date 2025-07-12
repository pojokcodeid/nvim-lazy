return {
  "sharpchen/Eva-Theme.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("Eva-Theme").setup({})
    local color = {}
    if pcode.localcode then
      color = require("Eva-Theme.palette").dark_base
    else
      color = require("Eva-Theme.palette").dark
    end
    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "*",
      callback = function()
        local hi = vim.api.nvim_set_hl
        hi(0, "LspInfoBorder", { fg = color.comment })
        hi(0, "FloatBorder", { fg = color.comment })
        hi(0, "StatusLine", { bg = color.background })
        hi(0, "StatusLineNC", { bg = color.background })
        hi(0, "WinBar", { bg = color.background })
        hi(0, "WinBarNC", { bg = color.background })
        hi(0, "NormalFloat", { bg = color.background })
        hi(0, "TabLine", { bg = color.background })
        hi(0, "NormalNC", { bg = color.background })
        hi(0, "MasonBackdrop", { link = "NormalFloat" })
        hi(0, "@tag.delimiter.javascript", { fg = color.punctuation })
        hi(0, "@tag.delimiter.tsx", { fg = color.punctuation })
        -- git
        hi(0, "NvimTreeGitNewIcon", { bg = color.dark, fg = color.git.added })
        hi(0, "NvimTreeGitRenamedIcon", { bg = color.dark, fg = color.git.added })
        hi(0, "NvimTreeGitDeletedIcon", { bg = color.dark, fg = color.git.stagedDeleted })
        hi(0, "NvimTreeGitDirtyIcon", { bg = color.dark, fg = color.git.diffModified })
        hi(0, "NvimTreeGitIgnoredIcon", { bg = color.dark, fg = color.git.ignored })
        hi(0, "NvimTreeGitMergeIcon", { bg = color.dark, fg = color.git.diffModified })
        hi(0, "NvimTreeGitStagedIcon", { bg = color.dark, fg = color.git.stagedModified })
        hi(0, "NvimTreeWinSeparator", { bg = color.dark, fg = color.comment })
        hi(0, "MiniIndentscopeSymbol", { bg = color.dark, fg = color.parameter })
        -- cursor
        -- hi(0, "Cursor", { bg = "#838FA7", fg = "#838FA7" })
        hi(0, "CursorColumn", { bg = color.dark, fg = color.punctuation })
        hi(0, "TermCursor", { bg = color.digit, fg = color.dark })
        hi(0, "TermCursorNC", { bg = color.digit, fg = color.dark })
        hi(0, "MiniIndentscopeSymbol", { fg = color.digit })
        hi(0, "MiniIndentscopeSymbolOff", { fg = color.digit })
      end,
    })
  end,
}
