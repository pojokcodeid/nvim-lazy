local color = vim.g.pcode_colorscheme or "gruvbox-baby"
local transparent_mode = vim.g.pcode_transparent_mode or 0

if substring(tostring(color), "sonokai") and true or false then
  return {
    "sainnhe/sonokai",
    priority = 1000,
    enabled = substring(tostring(color), "sonokai") and true or false,
    config = function()
      vim.api.nvim_create_autocmd("ColorScheme", {
        group = vim.api.nvim_create_augroup("custom_highlights_sonokai", {}),
        pattern = "sonokai",
        callback = function()
          local config = vim.fn["sonokai#get_configuration"]()
          local palette = vim.fn["sonokai#get_palette"](config.style, config.colors_override)
          local set_hl = vim.fn["sonokai#highlight"]

          set_hl("StatusLine", palette.fg, palette.none)
          set_hl("StatusLineTerm", palette.fg, palette.none)
          set_hl("StatusLineNC", palette.fg, palette.none)
          set_hl("StatusLineTermNC", palette.fg, palette.none)
          set_hl("LualineNormal", palette.fg, palette.none)
          set_hl("NvimTreeNormal", palette.fg, palette.bg0)
          set_hl("NvimTreeCursorLine", palette.fg, palette.bg1)
          set_hl("NvimTreeEndOfBuffer", palette.fg, palette.bg0)
          set_hl("Pmenu", palette.fg, palette.bg0)
          set_hl("WhichKeyFloat", palette.fg, palette.bg0)
          set_hl("WhichKey", palette.fg, palette.bg0)
          set_hl("WhichKeyBorder", palette.fg, palette.bg0)
          set_hl("NormalFloat", palette.fg, palette.bg0)
          set_hl("Normal", palette.fg, palette.bg0)
          set_hl("NormalNC", palette.fg, palette.bg0)
          set_hl("FloatBorder", palette.fg, palette.bg0)
          set_hl("LspInfoNormal", palette.fg, palette.bg0)
        end,
      })
      vim.g.sonokai_style = extract(color)[2] or "default"
      vim.g.sonokai_transparent_background = (transparent_mode == 1) and 2 or 0
    end,
  }
else
  return {}
end
