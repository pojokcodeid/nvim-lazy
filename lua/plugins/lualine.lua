return {
  {
    "nvim-lualine/lualine.nvim",
    event = { "InsertEnter", "BufRead", "BufNewFile" },
    config = function()
      local component = require "user.utils.lualine_component"
      local colors = component.colors

      -- check config for theme
      local set_theme = "auto"
      local bubbles_theme
      local color = vim.g.pcode_colorscheme
      switch(color, {
        ["tokyonight"] = function()
          set_theme = "auto"
        end,
        ["tokyonight-night"] = function()
          set_theme = "auto"
        end,
        ["tokyonight-storm"] = function()
          set_theme = "auto"
        end,
        ["tokyonight-day"] = function()
          set_theme = "auto"
        end,
        ["tokyonight-moon"] = function()
          set_theme = "auto"
        end,
        ["dracula"] = function()
          local clr = require("dracula").colors()
          colors.blue = clr.green
          colors.black = clr.black
          colors.cyan = clr.yellow
          set_theme = "bubbles_theme"
        end,
        default = function()
          set_theme = "auto"
        end,
      })

      bubbles_theme = component.bubbles_theme(colors)
      if set_theme == "auto" then
        bubbles_theme = vim.fn.fnamemodify("auto", ":t")
      end

      local gettheme = require "user.utils.lualine_template"
      local theme_option = vim.g.pcode_lualinetheme or "rounded"
      local theme = gettheme.rounded(bubbles_theme)
      if theme_option == "rounded" then
        theme = gettheme.rounded(bubbles_theme)
      elseif theme_option == "roundedall" then
        theme = gettheme.roundedall(bubbles_theme)
      elseif theme_option == "square" then
        theme = gettheme.square(bubbles_theme)
      elseif theme_option == "transparent" then
        theme = gettheme.square(component.transparent(colors))
      elseif theme_option == "triangle" then
        theme = gettheme.triangle(bubbles_theme)
      elseif theme_option == "parallelogram" then
        theme = gettheme.parallelogram(bubbles_theme)
      elseif theme_option == "default" then
        theme = {}
      end
      require("lualine").setup {
        options = theme.options,
        sections = theme.sections,
        inactive_sections = theme.inactive_sections,
        tabline = theme.tabline,
        extensions = theme.extensions,
      }
    end,
  },
}
