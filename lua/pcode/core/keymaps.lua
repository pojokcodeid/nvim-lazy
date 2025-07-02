local keymaps = {
  ["LSP"] = {
    { "LSP Code Action", "<leader>la" },
    { "LSP Code Format", "<leader>lf" },
    { "LSP Information", "<leader>li" },
    { "Mason Information", "<leader>lI" },
    { "LSP Next Diagnostic", "<leader>lj" },
    { "LSP Previous Diagnostic", "<leader>lk" },
    { "LSP Quickfix", "<leader<lq" },
    { "LSP Rename", "<leader>lr" },
    { "LSP Signature Help", "<leader>ls" },
    { "LSP Format On Range", "<leader>lF" },
  },
  ["Cmp"] = {
    { "Scroll Next Documentation", "CTRL + f" },
    { "Scroll Previous Documentation", "CTRL + b" },
    { "Mapping Complete", "CTRL + space" },
    { "Abort Completion", "CTRL + e" },
    { "Accept Completion", "↵" },
    { "Next Autocompletion", "TAB" },
    { "Previous Autocompletion", "SHIFT + TAB" },
  },
  ["Terminal"] = {
    { "Terminal Float", "<leader>tf" },
    { "Terminal Horizontal", "<leader>th" },
    { "Terminal new tab", "<leader>ts" },
    { "Terminal Vertical", "<leader>tv" },
    { "Terminal Close", "<leader>tx" },
  },
  ["Comment"] = {
    { "Comment line toggle", "gcc or CTRL + /" },
    { "Comment block toggle", "gbc or CTRL + /" },
    { "Comment visual selection", "gc" },
    { "Comment visual selection using block delimiters", "gb" },
    { "Comment out text object line wise", "gc<motion>" },
    { "Comment out text object block wise", "gb<motion>" },
    { "Add comment on the line above", "gcO" },
    { "Add comment on the line below", "gco" },
    { "Add comment at the end of line", "gcA" },
  },
  ["Bufferline"] = {
    { "Move Active Buffer Left", "SHIFT + h OR SHIFT + ArrowLeft" },
    { "Move Active Buffer Right", "SHIFT + l OR SHIFT + ArrowRight" },
    { "Reorder Bufferline", "SHIFT + PageUp/PageDown" },
    { "Close Current Buffer", "SHIFT + t" },
  },
  ["Window"] = {
    { "Resize Window", "CTRL + ArrowLeft/ArrowRight/ArrowUp/ArrowDown" },
    { "Navigate Window", "CTRL + h/l" },
  },
}

-- Section title highlight setup
vim.api.nvim_set_hl(0, "KeymapsSectionOil", { bg = "#8fbcbb", fg = "#1e1e1e", bold = true })
vim.api.nvim_set_hl(0, "KeymapsSectionCmp", { bg = "#b48ead", fg = "#1e1e1e", bold = true })
vim.api.nvim_set_hl(0, "KeymapsSectionComment", { bg = "#bf616a", fg = "#1e1e1e", bold = true })
vim.api.nvim_set_hl(0, "Normal2", { bg = "#56B7C3", fg = "#1e1e1e", bold = true })
vim.api.nvim_set_hl(0, "Color1", { bg = "#D6ACFF", fg = "#1e1e1e", bold = true })
vim.api.nvim_set_hl(0, "Color2", { bg = "#F1FA8C", fg = "#1e1e1e", bold = true })
vim.api.nvim_set_hl(0, "Color3", { bg = "#FF79C6", fg = "#1e1e1e", bold = true })
vim.api.nvim_set_hl(0, "Color4", { bg = "#FF92DF", fg = "#1e1e1e", bold = true })
vim.api.nvim_set_hl(0, "Color5", { bg = "#69ff94", fg = "#1e1e1e", bold = true })
vim.api.nvim_set_hl(0, "Color6", { bg = "#FF6E6E", fg = "#1e1e1e", bold = true })
vim.api.nvim_set_hl(0, "Color7", { bg = "#D6ACFF", fg = "#1e1e1e", bold = true })

local section_hl = {
  "KeymapsSectionOil",
  "KeymapsSectionCmp",
  "KeymapsSectionComment",
  "Normal2",
  "Color1",
  "Color2",
  "Color3",
  "Color4",
  "Color5",
  "Color6",
  "Color7",
}

local function pad(str, width)
  local n = vim.fn.strdisplaywidth(str)
  return str .. string.rep(" ", width - n)
end

local function calc_widths(tbl)
  local col1, col2 = 0, 0
  for _, group in pairs(tbl) do
    for _, row in ipairs(group) do
      col1 = math.max(col1, vim.fn.strdisplaywidth(row[1]))
      col2 = math.max(col2, vim.fn.strdisplaywidth(row[2]))
    end
  end
  return col1, col2
end

local function make_lines(tbl, max_width)
  local col1, col2 = calc_widths(tbl)
  if max_width then
    local padding = max_width - (col1 + col2 + 3)
    if padding > 0 then
      col1 = col1 + math.floor(padding * 0.7)
      col2 = col2 + padding - math.floor(padding * 0.7)
    end
  end
  local lines = {}
  local hls = {}
  Random_index = 1

  for section, rows in pairs(tbl) do
    local section_title = ("  %s  "):format(section)
    table.insert(lines, section_title)
    table.insert(hls, { { 0, #section_title, section_hl[Random_index] or "Normal2" } })
    Random_index = Random_index + 1
    if Random_index > #section_hl then
      Random_index = 1
    end
    -- Hapus baris Description, hanya tampilkan garis bawah dan data
    table.insert(lines, string.rep("─", col1) .. "─┬─" .. string.rep("─", col2))
    table.insert(hls, {})
    for _, row in ipairs(rows) do
      table.insert(lines, pad(row[1], col1) .. " │ " .. pad(row[2], col2))
      table.insert(hls, {})
    end
    table.insert(lines, "")
    table.insert(hls, {})
  end
  return lines, col1 + col2 + 3, hls
end

local function show_keymaps_popup()
  local ui = vim.api.nvim_list_uis()[1]
  local win_width = math.floor(ui.width * 0.7)
  local lines, width, hls = make_lines(keymaps, win_width)
  width = win_width
  local height = #lines

  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.api.nvim_buf_set_option(buf, "modifiable", false)
  vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")

  -- highlight section titles
  for i, l in ipairs(hls) do
    for _, v in ipairs(l) do
      vim.api.nvim_buf_add_highlight(buf, -1, v[3], i - 1, v[1], v[2])
    end
  end

  local row = math.floor((ui.height - height) / 2)
  local col = math.floor((ui.width - width) / 2)

  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    row = row,
    col = col,
    width = width,
    height = height,
    style = "minimal",
    border = "single",
    title = "Keymaps",
    title_pos = "center",
  })

  vim.keymap.set("n", "q", function()
    vim.api.nvim_win_close(win, true)
  end, { buffer = buf, nowait = true })
  vim.keymap.set("n", "<Esc>", function()
    vim.api.nvim_win_close(win, true)
  end, { buffer = buf, nowait = true })
end

vim.api.nvim_create_user_command("KeymapsPopup", function()
  show_keymaps_popup()
end, {})

vim.keymap.set("n", "<F1>", ":KeymapsPopup<CR>", { noremap = true, silent = true })

return {
  show = show_keymaps_popup,
}
