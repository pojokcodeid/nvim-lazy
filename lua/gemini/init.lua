local M = {}
M.last_popup_win = nil
M.last_popup_buf = nil

function M.ask_gemini()
  -- Ambil path file buffer aktif
  --[[  local buf_path = vim.api.nvim_buf_get_name(0)
  if buf_path ~= "" then
    local dir = vim.fn.fnamemodify(buf_path, ":h")
    vim.api.nvim_set_current_dir(dir)
  end ]]

  vim.ui.input({ prompt = "Prompt ke Gemini: " }, function(prompt)
    if not prompt or prompt == "" then
      vim.notify("Prompt kosong", vim.log.levels.WARN)
      return
    end

    M.show_popup("Loading...")

    vim.schedule(function()
      local output = vim.fn.system('gemini --prompt "' .. prompt .. '"')
      M.show_popup(output)
    end)
  end)
end

function M.show_popup(output)
  if M.last_popup_win and vim.api.nvim_win_is_valid(M.last_popup_win) then
    vim.api.nvim_win_close(M.last_popup_win, true)
  end
  if M.last_popup_buf and vim.api.nvim_buf_is_valid(M.last_popup_buf) then
    vim.api.nvim_buf_delete(M.last_popup_buf, { force = true })
  end

  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(output or "", "\n"))
  local width = math.floor(vim.o.columns * 0.6)
  local height = math.floor(vim.o.lines * 0.8)
  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    row = math.floor((vim.o.lines - height) / 2),
    col = math.floor((vim.o.columns - width) / 2),
    style = "minimal",
    border = "rounded",
  })
  M.last_popup_win = win
  M.last_popup_buf = buf
end

return M
