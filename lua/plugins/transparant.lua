local transparent = false
local clear_lualine = false

local transparent_mode = vim.g.pcode_transparent_mode or 0
if transparent_mode ~= nil then
  if transparent_mode == 1 then
    transparent = true
  end
end

local clear_line = vim.g.pcode_clear_lualine or 0
if clear_line ~= nil then
  if clear_line == 1 then
    clear_lualine = true
  end
end

if transparent then
  return {
    -- transparant config
    {
      "xiyaowong/transparent.nvim",
      lazy = true,
      enabled = transparent,
      event = "BufWinEnter",
      cmd = { "TransparentToggle", "TransparentEnable", "TransparentDisable" },
      config = function()
        require("transparent").setup {
          extra_groups = {
            "Normal",
            "NormalNC",
            "NormalFloat",
            "FloatBorder",
            "Comment",
            "Folded",
            "GitSignsAdd",
            "GitSignsDelete",
            "GitSignsChange",
            "FoldColumn",
          },
          exclude_groups = {
            -- disable active selection backgroun
            "CursorLine",
            "CursorLineNR",
            "CursorLineSign",
            "CursorLineFold",
            -- disable nvimtree CursorLine
            "NvimTreeCursorLine",
            -- disable Neotree CursorLine
            "NeoTreeCursorLine",
            -- disable Telescope active selection background
            "TelescopeSelection",
            -- disable lualine background color
            "LualineNormal",
          },
        }
        require("transparent").clear_prefix "BufferLine"
        -- clear prefix for which-key
        require("transparent").clear_prefix "WhichKey"
        -- clear prefix for lazy.nvim
        require("transparent").clear_prefix "Lazy"
        -- clear prefix for NvimTree
        require("transparent").clear_prefix "NvimTree"
        -- clear prefix for NeoTree
        require("transparent").clear_prefix "NeoTree"
        -- clear prefix for Telescope
        require("transparent").clear_prefix "Telescope"
        require("transparent").clear_prefix "mason"
        if clear_lualine then
          -- clear prefix for Lualine
          require("transparent").clear_prefix "Lualine"
          -- create auto command to set transparent
          vim.cmd "TransparentDisable"
          vim.cmd "TransparentEnable"
        end
      end,
    },
  }
else
  return {}
end
