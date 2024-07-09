local M = {}

-- local Log = require "pcode.core.log"
local icons = vim.g.pcode_icons.kind

M.config = function()
  pcode.builtin.breadcrumbs = {
    active = true,
    on_config_done = nil,
    winbar_filetype_exclude = {
      "help",
      "startify",
      "dashboard",
      "lazy",
      "neo-tree",
      "neogitstatus",
      "NvimTree",
      "Trouble",
      "alpha",
      "lir",
      "Outline",
      "spectre_panel",
      "toggleterm",
      "DressingSelect",
      "Jaq",
      "harpoon",
      "dap-repl",
      "dap-terminal",
      "dapui_console",
      "dapui_hover",
      "lab",
      "notify",
      "noice",
      "neotest-summary",
      "",
    },
    options = {
      icons = {
        Array = icons.Array .. " ",
        Boolean = icons.Boolean .. " ",
        Class = icons.Class .. " ",
        Color = icons.Color .. " ",
        Constant = icons.Constant .. " ",
        Constructor = icons.Constructor .. " ",
        Enum = icons.Enum .. " ",
        EnumMember = icons.EnumMember .. " ",
        Event = icons.Event .. " ",
        Field = icons.Field .. " ",
        File = icons.File .. " ",
        Folder = icons.Folder .. " ",
        Function = icons.Function .. " ",
        Interface = icons.Interface .. " ",
        Key = icons.Key .. " ",
        Keyword = icons.Keyword .. " ",
        Method = icons.Method .. " ",
        Module = icons.Module .. " ",
        Namespace = icons.Namespace .. " ",
        Null = icons.Null .. " ",
        Number = icons.Number .. " ",
        Object = icons.Object .. " ",
        Operator = icons.Operator .. " ",
        Package = icons.Package .. " ",
        Property = icons.Property .. " ",
        Reference = icons.Reference .. " ",
        Snippet = icons.Snippet .. " ",
        String = icons.String .. " ",
        Struct = icons.Struct .. " ",
        Text = icons.Text .. " ",
        TypeParameter = icons.TypeParameter .. " ",
        Unit = icons.Unit .. " ",
        Value = icons.Value .. " ",
        Variable = icons.Variable .. " ",
      },
      highlight = true,
      separator = " " .. pcode.icons.ui.ChevronRight .. " ",
      depth_limit = 0,
      depth_limit_indicator = "..",
    },
  }
end

M.setup = function()
  local status_ok, navic = pcall(require, "nvim-navic")
  if not status_ok then
    return
  end

  M.create_winbar()
  navic.setup(pcode.builtin.breadcrumbs.options)

  if pcode.builtin.breadcrumbs.on_config_done then
    pcode.builtin.breadcrumbs.on_config_done()
  end
end

local function isempty(s)
  return s == nil or s == ""
end

M.get_filename = function()
  local filename = vim.fn.expand("%:t")
  local extension = vim.fn.expand("%:e")

  if not isempty(filename) then
    local file_icon, hl_group
    local devicons_ok, devicons = pcall(require, "nvim-web-devicons")
    if pcode.use_icons and devicons_ok then
      file_icon, hl_group = devicons.get_icon(filename, extension, { default = true })

      if isempty(file_icon) then
        file_icon = pcode.icons.kind.File
      end
    else
      file_icon = ""
      hl_group = "Normal"
    end

    local buf_ft = vim.bo.filetype

    if buf_ft == "dapui_breakpoints" then
      file_icon = pcode.icons.ui.Bug
    end

    if buf_ft == "dapui_stacks" then
      file_icon = pcode.icons.ui.Stacks
    end

    if buf_ft == "dapui_scopes" then
      file_icon = pcode.icons.ui.Scopes
    end

    if buf_ft == "dapui_watches" then
      file_icon = pcode.icons.ui.Watches
    end

    -- if buf_ft == "dapui_console" then
    --   file_icon = pcode.icons.ui.DebugConsole
    -- end

    local navic_text_hl = vim.api.nvim_get_hl(0, { name = "Normal" })
    vim.api.nvim_set_hl(0, "Winbar", { fg = navic_text_hl.fg })

    return " " .. "%#" .. hl_group .. "#" .. file_icon .. "%*" .. " " .. "%#Winbar#" .. filename .. "%*"
  end
end

local get_gps = function()
  local status_gps_ok, gps = pcall(require, "nvim-navic")
  if not status_gps_ok then
    return ""
  end

  local status_ok, gps_location = pcall(gps.get_location, {})
  if not status_ok then
    return ""
  end

  if not gps.is_available() or gps_location == "error" then
    return ""
  end

  if not isempty(gps_location) then
    return "%#NavicSeparator#" .. pcode.icons.ui.ChevronRight .. "%* " .. gps_location
  else
    return ""
  end
end

local excludes = function()
  return vim.tbl_contains(pcode.builtin.breadcrumbs.winbar_filetype_exclude or {}, vim.bo.filetype)
end

M.get_winbar = function()
  if excludes() then
    return
  end
  local value = M.get_filename()

  local gps_added = false
  if not isempty(value) then
    local gps_value = get_gps()
    value = value .. " " .. gps_value
    if not isempty(gps_value) then
      gps_added = true
    end
  end

  if not isempty(value) and vim.api.nvim_get_option_value("mod", { buf = 0 }) then
    -- TODO: replace with circle
    local mod = "%#LspCodeLens#" .. pcode.icons.ui.Circle .. "%*"
    if gps_added then
      value = value .. " " .. mod
    else
      value = value .. mod
    end
  end

  local num_tabs = #vim.api.nvim_list_tabpages()

  if num_tabs > 1 and not isempty(value) then
    local tabpage_number = tostring(vim.api.nvim_tabpage_get_number(0))
    value = value .. "%=" .. tabpage_number .. "/" .. tostring(num_tabs)
  end

  local status_ok, _ = pcall(vim.api.nvim_set_option_value, "winbar", value, { scope = "local" })
  if not status_ok then
    return
  end
end

M.create_winbar = function()
  vim.api.nvim_create_augroup("_winbar", {})
  vim.api.nvim_create_autocmd({
    "CursorHoldI",
    "CursorHold",
    "BufWinEnter",
    "BufFilePost",
    "InsertEnter",
    "BufWritePost",
    "TabClosed",
    "TabEnter",
  }, {
    group = "_winbar",
    callback = function()
      if pcode.builtin.breadcrumbs.active then
        local status_ok, _ = pcall(vim.api.nvim_buf_get_var, 0, "lsp_floating_window")
        if not status_ok then
          -- TODO:
          require("pcode.core.breadcrumbs").get_winbar()
        end
      end
    end,
  })
end

return M
