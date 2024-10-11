local hide_in_width = function()
  return vim.fn.winwidth(0) > 75
end
local icons = require("user.icons")
local formatter = require("user.utils.formatter")
local linter = require("user.utils.linter")

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

local mode_map = {
  ["NORMAL"] = "N",
  ["INSERT"] = "I",
  ["VISUAL"] = "V",
  ["REPLACE"] = "R",
  ["COMMAND"] = "C",
  ["O-PENDING"] = "O",
}

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
      return { fg = ts and not vim.tbl_isempty(ts) and "#98C379" or "#E06C75" }
    end,
    cond = hide_in_width,
  },

  codeium = {
    function()
      if pcode.codeium then
        local codeium = all_trim(vim.api.nvim_call_function("codeium#GetStatusString", {}))
        if codeium then
          if codeium == "OFF" then
            return icons.kind.CopilotOff
          else
            return icons.kind.Copilot
          end
        else
          return ""
        end
      else
        return ""
      end
    end,
    color = function()
      if pcode.codeium then
        local codeium = all_trim(vim.api.nvim_call_function("codeium#GetStatusString", {}))
        return { fg = codeium == "OFF" and "#3E4452" or "#98C379" }
      else
        return {}
      end
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
      buf_clients = vim.lsp.get_clients({ bufnr = 0 })
      local buf_client_names = {}
      if next(buf_clients) == nil then
        -- TODO: clean up this if statement
        if type(msg) == "boolean" or #msg == 0 then
          return "LSP Inactive"
        end
        -- return msg
        table.insert(buf_client_names, msg)
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

      -- add conform.nvim
      local status, conform = pcall(require, "conform")
      if status and supported_formatters and #supported_formatters == 0 then
        local formatters = conform.list_formatters_for_buffer()
        if formatters and #formatters > 0 then
          vim.list_extend(buf_client_names, formatters)
        elseif supported_formatters and #supported_formatters == 0 then
          -- check if lspformat
          local lsp_format = require("conform.lsp_format")
          local bufnr = vim.api.nvim_get_current_buf()
          local lsp_clients = lsp_format.get_format_clients({ bufnr = bufnr })

          if not vim.tbl_isempty(lsp_clients) then
            table.insert(buf_client_names, "lsp_fmt")
          end
        end
      elseif not status and supported_formatters and #supported_formatters == 0 then
        table.insert(buf_client_names, "lsp_fmt")
      end

      -- add linter
      local supported_linters = linter.linter_list_registered(buf_ft)
      vim.list_extend(buf_client_names, supported_linters)

      -- cek nvimlint
      local lint_s, lint = pcall(require, "lint")
      if lint_s then
        for ft_k, ft_v in pairs(lint.linters_by_ft) do
          if type(ft_v) == "table" then
            for _, ltr in ipairs(ft_v) do
              if buf_ft == ft_k then
                table.insert(buf_client_names, ltr)
              end
            end
          elseif type(ft_v) == "string" then
            if buf_ft == ft_k then
              table.insert(buf_client_names, ft_v)
            end
          end
        end
      end

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
      if pcode.show_mode == 1 then
        return icons.ui.Neovim .. " " .. (mode_map[str] or str)
      elseif pcode.show_mode == 2 then
        return icons.ui.Neovim
      elseif pcode.show_mode == 3 then
        return (mode_map[str] or str)
      elseif pcode.show_mode == 4 then
        return nil
      else
        return icons.ui.Neovim .. " " .. str
      end
    end,
  },
  mode_roundedall = {
    "mode",
    padding = 1,
    separator = { left = " ", right = "" },
    fmt = function(str)
      if pcode.show_mode == 1 then
        return icons.ui.Neovim .. " " .. str:sub(1, 1)
      elseif pcode.show_mode == 2 then
        return icons.ui.Neovim
      elseif pcode.show_mode == 3 then
        return str:sub(1, 1)
      elseif pcode.show_mode == 4 then
        return nil
      else
        return icons.ui.Neovim .. " " .. str
      end
    end,
  },
  mode_triangle = {
    "mode",
    padding = 1,
    separator = { left = " ", right = "" },
    fmt = function(str)
      if pcode.show_mode == 1 then
        return icons.ui.Neovim .. " " .. (mode_map[str] or str)
      elseif pcode.show_mode == 2 then
        return icons.ui.Neovim
      elseif pcode.show_mode == 3 then
        return (mode_map[str] or str)
      elseif pcode.show_mode == 4 then
        return nil
      else
        return icons.ui.Neovim .. " " .. str
      end
    end,
  },
  mode_parallelogram = {
    "mode",
    padding = 1,
    separator = { left = " ", right = "" },
    fmt = function(str)
      if pcode.show_mode == 1 then
        return icons.ui.Neovim .. " " .. (mode_map[str] or str)
      elseif pcode.show_mode == 2 then
        return icons.ui.Neovim
      elseif pcode.show_mode == 3 then
        return (mode_map[str] or str)
      elseif pcode.show_mode == 4 then
        return nil
      else
        return icons.ui.Neovim .. " " .. str
      end
    end,
  },

  mode_square = {
    "mode",
    padding = 1,
    separator = { left = " " },
    fmt = function(str)
      if pcode.show_mode == 1 then
        return icons.ui.Neovim .. " " .. (mode_map[str] or str)
      elseif pcode.show_mode == 2 then
        return icons.ui.Neovim
      elseif pcode.show_mode == 3 then
        return (mode_map[str] or str)
      elseif pcode.show_mode == 4 then
        return nil
      else
        return icons.ui.Neovim .. " " .. str
      end
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
      return icons.git.Branch3 .. " " .. getLeftSubstring(vim.b.gitsigns_head, 6)
    else
      return icons.git.NoBranch .. vim.fn.fnamemodify("", ":t")
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
        b = { fg = colors.skyblue_1, bg = colors.grey },
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
