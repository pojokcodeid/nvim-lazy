local color = vim.g.pcode_colorscheme or "gruvbox-baby"
local transparent_mode = vim.g.pcode_transparent_mode or 0
local materialstyle = extract(color)[2] or "oceanic"
local material_style = (materialstyle == "deepocean") and "deep ocean" or materialstyle

if substring(tostring(color), "material") and true or false then
  return {
    "marko-cerovac/material.nvim",
    priority = 1000,
    enabled = substring(tostring(color), "material") and true or false,
    config = function()
      local colors = require "material.colors"
      vim.g.material_style = material_style
      require("material").setup {
        lualine_style = "stealth",
        disable = {
          background = (transparent_mode == 1) and true or false,
        },
        plugins = { -- Uncomment the plugins that you use to highlight them
          -- Available plugins:
          "dap",
          -- "dashboard",
          -- "eyeliner",
          "fidget",
          -- "flash",
          "gitsigns",
          -- "harpoon",
          -- "hop",
          "illuminate",
          "indent-blankline",
          -- "lspsaga",
          "mini",
          -- "neogit",
          -- "neotest",
          -- "neo-tree",
          -- "neorg",
          "noice",
          "nvim-cmp",
          "nvim-navic",
          "nvim-tree",
          "nvim-web-devicons",
          "rainbow-delimiters",
          -- "sneak",
          "telescope",
          -- "trouble",
          "which-key",
          "nvim-notify",
        },
        custom_highlights = {
          BufferLineFill = { bg = colors.bg },
          StatusLine = { fg = "#f8f8f2", bg = colors.bg },
          StatusLineTerm = { fg = "#f8f8f2", bg = colors.bg },
          WinBarNC = { fg = colors.fg, bg = colors.bg },
          CursorLine = { bg = "#333842" },
        },
      }
    end,
  }
else
  return {}
end
