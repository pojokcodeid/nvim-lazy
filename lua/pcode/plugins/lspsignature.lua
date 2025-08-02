return {
  "ray-x/lsp_signature.nvim",
  event = "InsertEnter",
  opts = {
    bind = true,
    handler_opts = {
      border = "rounded",
    },
    hint_prefix = "󰍩 ",
  },
  -- or use config
  -- config = function(_, opts) require'lsp_signature'.setup({you options}) end
}
