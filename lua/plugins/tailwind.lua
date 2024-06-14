local M = {}
if pcode.tailwindcolorizer then
  M.tailwind = {
    {
      "NvChad/nvim-colorizer.lua",
      opts = {
        user_default_options = {
          tailwind = true,
        },
      },
    },
    {
      "hrsh7th/nvim-cmp",
      dependencies = {
        { "roobert/tailwindcss-colorizer-cmp.nvim", config = true },
      },
      opts = function(_, opts)
        -- original kind icon formatter
        local format_kinds = opts.formatting.format
        opts.formatting.format = function(entry, item)
          format_kinds(entry, item) -- add icons
          local lspkind = require("tailwindcss-colorizer-cmp").formatter(entry, item)
          if lspkind.kind == "XX" then
            lspkind.kind = " "
          end
          return lspkind
        end
      end,
    },
  }
else
  M.tailwind = {}
end

return {
  M.tailwind,
}
