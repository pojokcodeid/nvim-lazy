local hide_in_width = function()
  return vim.fn.winwidth(0) > 75
end
local icons = require "user.icons"
local formatter = require "user.utils.formatter"
local linter = require "user.utils.linter"

local getLeftSubstring = function(word, length)
  if #word > length then
    return string.sub(word, 1, length) .. "..."
  else
    return word
  end
end

local unique_list = function(list)
  local seen = {}
  local result = {}

  for _, val in ipairs(list) do
    if not seen[val] then
      table.insert(result, val)
      seen[val] = true
    end
  end

  return result
end

return {
  -- treesitter info
  treesitter = {
    function()
      -- return icons.ui.Paint .. " TS"
      return icons.ui.Tree
    end,
    color = function()
      local buf = vim.api.nvim_get_current_buf()
      local ts = vim.treesitter.highlighter.active[buf]
      return { fg = ts and not vim.tbl_isempty(ts) and "#50fa7b" or "#FF5555" }
    end,
    cond = hide_in_width,
  },

  -- Lsp info
  lsp_info = {
    function()
      local msg = "LSP Inactive"
      local buf_ft = vim.bo.filetype
      -- start register
      local buf_clients = {}
      buf_clients = vim.lsp.get_clients { bufnr = 0 }
      local buf_client_names = {}
      if next(buf_clients) == nil then
        -- TODO: clean up this if statement
        if type(msg) == "boolean" or #msg == 0 then
          return "LSP Inactive"
        end
        return msg
      end
      -- add client
      for _, client in pairs(buf_clients) do
        if client.name ~= "null-ls" and client.name ~= "copilot" then
          table.insert(buf_client_names, client.name)
        end
      end

      -- add formatter
      local supported_formatters = formatter.list_registered(buf_ft)
      vim.list_extend(buf_client_names, supported_formatters)

      -- add linter
      local supported_linters = linter.linter_list_registered(buf_ft)
      vim.list_extend(buf_client_names, supported_linters)

      -- decomple
      -- local unique_client_names = vim.fn.uniq(buf_client_names)
      local unique_client_names = unique_list(buf_client_names)
      msg = table.concat(unique_client_names, ", ")
      return msg
    end,
    icon = icons.ui.Gear .. "",
    padding = 1,
    cond = hide_in_width,
  },

  -- diagnostics info
  diagnostics = {
    "diagnostics",
    sources = { "nvim_diagnostic" },
    sections = { "error", "warn" },
    symbols = {
      error = icons.diagnostics.BoldError .. " ",
      warn = icons.diagnostics.BoldWarning .. " ",
    },
    colored = true,
    update_in_insert = false,
    always_visible = false,
  },

  -- git info
  diff = {
    "diff",
    colored = true,
    symbols = {
      added = icons.git.LineAdded .. " ",
      modified = icons.git.LineModified .. " ",
      removed = icons.git.LineRemoved .. " ",
    },
    cond = hide_in_width,
  },

  -- tab info
  spaces = {
    function()
      -- local shiftwidth = vim.api.nvim_buf_get_option(0, "shiftwidth")
      -- local shiftwidth = vim.api.nvim_get_option_value("shiftwidth", { scope = "buf", bufnr = 0 })
      local shiftwidth = vim.fn.shiftwidth()
      return icons.ui.Tab .. " " .. shiftwidth
    end,
    padding = 1,
  },

  -- nvim mode info
  mode_rounded = {
    "mode",
    padding = 1,
    separator = { left = " " },
    fmt = function(str)
      return icons.ui.Neovim .. " " .. str
    end,
  },
  mode_roundedall = {
    "mode",
    padding = 1,
    separator = { left = " ", right = "" },
    fmt = function(str)
      return icons.ui.Neovim .. " " .. str
    end,
  },
  mode_triangle = {
    "mode",
    padding = 1,
    separator = { left = " ", right = "" },
    fmt = function(str)
      return icons.ui.Neovim .. " " .. str
    end,
  },
  mode_parallelogram = {
    "mode",
    padding = 1,
    separator = { left = " ", right = "" },
    fmt = function(str)
      return icons.ui.Neovim .. " " .. str
    end,
  },

  mode_square = {
    "mode",
    padding = 1,
    separator = { left = " " },
    fmt = function(str)
      return icons.ui.Neovim .. " " .. str
    end,
  },

  path = {
    "filename",
    file_status = true,
    path = 1,
    fmt = function(str)
      return "[" .. str .. "]"
    end,
    cond = hide_in_width,
  },

  -- git branch info
  get_branch = function()
    if vim.b.gitsigns_head ~= nil then
      return icons.git.Branch2 .. " " .. getLeftSubstring(vim.b.gitsigns_head, 6)
    else
      return icons.git.Branch2 .. vim.fn.fnamemodify("", ":t")
    end
  end,

  -- default colorscheme
  colors = {
    blue = "#50fa7b",
    cyan = "#f1fa8c",
    black = "#1a1b26",
    black_transparant = "none",
    white = "#c6c6c6",
    red = "#ff757f",
    skyblue_1 = "#bd93f9",
    grey = "#5f6a8e",
    yellow = "#ffb86c",
    fg_gutter = "#3b4261",
    green1 = "#bd93f9",
  },

  -- default lualine theme
  bubbles_theme = function(colors)
    return {
      normal = {
        a = { fg = colors.black, bg = colors.skyblue_1 },
        b = { fg = colors.white, bg = colors.grey },
        c = { fg = colors.white, bg = colors.black_transparant },
      },

      insert = {
        a = { fg = colors.black, bg = colors.blue },
        b = { fg = colors.blue, bg = colors.grey },
      },
      visual = {
        a = { fg = colors.black, bg = colors.cyan },
        b = { fg = colors.cyan, bg = colors.grey },
      },
      replace = {
        a = { bg = colors.red, fg = colors.black },
        b = { bg = colors.fg_gutter, fg = colors.red },
      },
      command = {
        a = { bg = colors.yellow, fg = colors.black },
        b = { bg = colors.fg_gutter, fg = colors.yellow },
      },
      terminal = {
        a = { bg = colors.green1, fg = colors.black },
        b = { bg = colors.fg_gutter, fg = colors.green1 },
      },
      inactive = {
        a = { fg = colors.white, bg = colors.black_transparant },
        b = { fg = colors.white, bg = colors.black_transparant },
        c = { fg = colors.black, bg = colors.black_transparant },
      },
    }
  end,
  transparent = function(colors)
    return {
      normal = {
        a = { fg = colors.skyblue_1, bg = colors.black_transparant },
        b = { fg = colors.white, bg = colors.black_transparant },
        c = { fg = colors.white, bg = colors.black_transparant },
      },

      insert = {
        a = { fg = colors.blue, bg = colors.black_transparant },
        b = { fg = colors.white, bg = colors.black_transparant },
      },
      visual = {
        a = { fg = colors.cyan, bg = colors.black_transparant },
        b = { fg = colors.white, bg = colors.black_transparant },
      },
      replace = {
        a = { bg = colors.black_transparant, fg = colors.red },
        b = { bg = colors.black_transparant, fg = colors.white },
      },
      command = {
        a = { bg = colors.black_transparant, fg = colors.yellow },
        b = { bg = colors.black_transparant, fg = colors.white },
      },
      terminal = {
        a = { bg = colors.black_transparant, fg = colors.green1 },
        b = { bg = colors.black_transparant, fg = colors.white },
      },
      inactive = {
        a = { fg = colors.white, bg = colors.black_transparant },
        b = { fg = colors.white, bg = colors.black_transparant },
        c = { fg = colors.black, bg = colors.black_transparant },
      },
    }
  end,
}
