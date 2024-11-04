if vim.g.vscode then
  -- config vscode
  Map = vim.keymap.set
  Cmd = vim.cmd

  VSCodeNotify = vim.fn.VSCodeNotify
  VSCodeCall = vim.fn.VSCodeCall

  require("_vscode.functions")
  require("_vscode.mappings")
else
  -- config neovim
  require("pcode.core")
end
