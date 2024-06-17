local M = {}
if pcode.codeium then
  M.codeium = {
    "Exafunction/codeium.vim",
    enabled = true,
    -- for fix notwork new version
    -- https://github.com/Exafunction/codeium.vim/issues/376#issuecomment-2159643405
    -- version = "1.8.37",
    -- event = "BufWinEnter",
    event = "BufEnter",
    -- event = "InsertEnter",
    config = function()
      vim.g.codeium_disable_bindings = 1
      -- Change '<C-g>' here to any keycode you like.
      vim.keymap.set("i", "<C-g>", function()
        return vim.fn["codeium#Accept"]()
      end, { expr = true, silent = true })
      vim.keymap.set("i", "<c-;>", function()
        return vim.fn["codeium#CycleCompletions"](1)
      end, { expr = true, silent = true })
      vim.keymap.set("i", "<C-Up>", function()
        return vim.fn["codeium#CycleCompletions"](1)
      end, { expr = true, silent = true })
      vim.keymap.set("i", "<c-,>", function()
        return vim.fn["codeium#CycleCompletions"](-1)
      end, { expr = true, silent = true })
      vim.keymap.set("i", "<C-Down>", function()
        return vim.fn["codeium#CycleCompletions"](-1)
      end, { expr = true, silent = true })
      vim.keymap.set("i", "<c-x>", function()
        return vim.fn["codeium#Clear"]()
      end, { expr = true, silent = true })
    end,
  }
else
  M.codeium = {}
end

return M.codeium
