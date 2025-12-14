return {
  "ray-x/lsp_signature.nvim",
  event = "InsertEnter",
  opts = function()
    local is_enabled = true
    return {
      -- Window mode
      floating_window = is_enabled, -- Display it as floating window.
      hi_parameter = "IncSearch", -- Color to highlight floating window.
      handler_opts = { border = "rounded" }, -- Window style

      -- Hint mode
      hint_enable = false, -- Display it as hint.
      hint_prefix = "󰍩 ",

      -- Additionally, you can use <space>uH to toggle inlay hints.
      toggle_key_flip_floatwin_setting = is_enabled,
    }
  end,
  config = function(_, opts)
    require("lsp_signature").setup(opts)
  end,
}
