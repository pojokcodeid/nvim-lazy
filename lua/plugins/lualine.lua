return {
  {
    "pojokcodeid/auto-lualine.nvim",
    event = { "InsertEnter", "BufRead", "BufNewFile" },
    dependencies = { "nvim-lualine/lualine.nvim" },
    config = function()
      local lualine = require("auto-lualine")
      -- tokyonight, tokyonight-night, tokyonight-storm, tokyonight-day, tokyonight-moon
      -- gruvbox-baby (default)
      -- sonokai, sonokai_atlantis,
      -- sonokai_andromeda,sonokai_shusia,sonokai_maia,sonokai_espresso
      -- material, material_deepocean, material_palenight, material_lighter, material_darker
      -- onedark, onedark_vivid, onedark_dark
      -- nord
      -- catppuccin, catppuccin-latte, catppuccin-frappe, catppuccin-macchiato, catppuccin-mocha
      -- dracula
      -- nightfox, dayfox, dawnfox, duskfox, nordfox, terafox, carbonfox
      -- github_dark, github_dark_default, github_dark_colorblind, github_dark_dimmed
      -- solarized-osaka
      -- darcula-dark
      -- juliana
      -- Eva-Dark, Eva-Dark-Italic, Eva-Dark-Bold
      local color = pcode.colorscheme or "auto"
      -- rounded
      -- roundedall
      -- square
      -- triangle
      -- parallelogram
      -- transparent
      -- default
      local options = pcode.lualinetheme or "roundedall"
      -- 0 = on full text mode info,
      -- 1 = on initial mode + logo
      -- 2 = logo only
      -- 3 = initial only
      -- 4 = off
      -- 5 = icon
      local show_mode = pcode.show_mode or 0
      lualine.setup({
        setColor = color,
        setOption = options,
        setMode = show_mode,
      })
    end,
  },
}
