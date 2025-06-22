local last_modal = nil -- global modal manager instance

local function modal_manager(opts)
  opts = opts or {}
  local win_id = nil
  local buf_id = nil
  local last_content = ""
  local is_shown = false
  local ever_shown = false

  local function close()
    if win_id and vim.api.nvim_win_is_valid(win_id) then
      vim.api.nvim_win_close(win_id, true)
      win_id = nil
    end
    is_shown = false
  end

  local function open(content)
    local lines = vim.split(content or "", "\n")
    local width = opts.width or 70
    local height = math.min(opts.height or 15, #lines + 6)
    local row = math.floor((vim.o.lines - height) / 2)
    local col = math.floor((vim.o.columns - width) / 2)
    if not buf_id or not vim.api.nvim_buf_is_valid(buf_id) then
      buf_id = vim.api.nvim_create_buf(false, true)
      vim.api.nvim_buf_set_keymap(buf_id, "n", "q", "", {
        noremap = true,
        silent = true,
        callback = function()
          close()
        end,
      })
    end
    pcall(vim.api.nvim_buf_set_option, buf_id, "modifiable", true)
    pcall(vim.api.nvim_buf_set_lines, buf_id, 0, -1, false, lines)
    pcall(vim.api.nvim_buf_set_option, buf_id, "modifiable", false)
    if not win_id or not vim.api.nvim_win_is_valid(win_id) then
      win_id = vim.api.nvim_open_win(buf_id, true, {
        relative = "editor",
        width = width,
        height = height,
        row = row,
        col = col,
        style = "minimal",
        border = "rounded",
      })
    end
    is_shown = true
    ever_shown = true
  end

  local function show()
    if is_shown then
      return
    end
    if last_content ~= "" then
      open(last_content)
    end
  end

  local function hide()
    close()
  end

  local function update(content)
    last_content = content
    if is_shown and buf_id and vim.api.nvim_buf_is_valid(buf_id) then
      local lines = vim.split(content or "", "\n")
      pcall(vim.api.nvim_buf_set_option, buf_id, "modifiable", true)
      pcall(vim.api.nvim_buf_set_lines, buf_id, 0, -1, false, lines)
      pcall(vim.api.nvim_buf_set_option, buf_id, "modifiable", false)
    end
  end

  -- Hanya auto open saat pertama kali, tidak auto open setelah pernah di-close/hide
  local function set_content(content)
    last_content = content
    if not ever_shown then
      open(content)
    elseif is_shown then
      update(content)
    end
    -- jika ever_shown dan !is_shown, cukup simpan output saja
  end

  return {
    show = show,
    hide = hide,
    update = update,
    close = close,
    set_content = set_content,
    is_shown = function()
      return is_shown
    end,
  }
end

local M = {}
M._last_modal = nil

local function log(message, level)
  vim.notify(string.format("npm-dev-runner: %s", message), vim.log.levels[level])
end

local function find_cached_dir(dir, cache)
  if not dir then
    vim.notify("npm-dev-runner: No directory provided to find_cached_dir()", vim.log.levels.ERROR)
    return
  end
  local cur = dir
  while not cache[cur] do
    if cur == "/" or string.match(cur, "^[A-Z]:\\$") then
      return
    end
    cur = vim.fn.fnamemodify(cur, ":h")
  end
  return cur
end

local function is_running(dir, cache)
  local cached_dir = find_cached_dir(dir, cache)
  return cached_dir and cache[cached_dir]
end

local function is_windows()
  return vim.loop.os_uname().version:match("Windows")
end

local default_opts = {
  show_mapping = "<leader>nm",
  hide_mapping = "<leader>nh",
}

M.setup = function(command_table, opts)
  opts = vim.tbl_deep_extend("force", {}, default_opts, opts or {})
  command_table = command_table or {}

  -- Keymap global, pakai modal terakhir yang aktif
  if opts.show_mapping then
    vim.keymap.set("n", opts.show_mapping, function()
      if last_modal then
        last_modal.show()
      end
    end, { desc = "Show last NPM modal output" })
  end
  if opts.hide_mapping then
    vim.keymap.set("n", opts.hide_mapping, function()
      if last_modal then
        last_modal.hide()
      end
    end, { desc = "Hide last NPM modal output" })
  end

  -- Tambah user command global untuk show/hide modal
  vim.api.nvim_create_user_command("NpmModalShow", function()
    if last_modal then
      last_modal.show()
    end
  end, { desc = "Show last NPM modal output" })

  vim.api.nvim_create_user_command("NpmModalHide", function()
    if last_modal then
      last_modal.hide()
    end
  end, { desc = "Hide last NPM modal output" })

  for key, conf in pairs(command_table) do
    local start_cmd = conf.start or ("NpmRun" .. key)
    local stop_cmd = conf.stop or ("NpmStop" .. key)
    local cmd_str = conf.cmd or "npm run dev"
    local cache = {}

    local function do_start(dir)
      if is_running(dir, cache) then
        log(cmd_str .. " already running", "INFO")
        return
      end

      local all_output = {}
      local modal = modal_manager(opts)
      last_modal = modal
      M._last_modal = modal

      local cmd
      if is_windows() then
        cmd = { "cmd.exe", "/C" }
        for word in cmd_str:gmatch("%S+") do
          table.insert(cmd, word)
        end
      else
        cmd = {}
        for word in cmd_str:gmatch("%S+") do
          table.insert(cmd, word)
        end
      end

      local function process_lines(lines)
        if not lines then
          return
        end
        for _, l in ipairs(lines) do
          table.insert(all_output, tostring(l))
        end
        modal.set_content(table.concat(all_output, "\n"))
      end

      local job_id = vim.fn.jobstart(cmd, {
        cwd = dir,
        stdout_buffered = false,
        stderr_buffered = false,
        on_stdout = function(_, data)
          process_lines(data)
        end,
        on_stderr = function(_, data)
          process_lines(data)
        end,
        on_exit = function(_, code)
          table.insert(all_output, ("Process exited with code: %d"):format(code))
          modal.set_content(table.concat(all_output, "\n"))
          cache[dir] = nil
        end,
      })

      cache[dir] = { job_id = job_id, modal = modal }
      log(cmd_str .. " started", "INFO")
    end

    local function do_stop(dir)
      local running = is_running(dir, cache)
      if running then
        local cached_dir = find_cached_dir(dir, cache)
        if cached_dir then
          local job_entry = cache[cached_dir]
          if job_entry then
            vim.fn.jobstop(job_entry.job_id)
            if job_entry.modal then
              job_entry.modal.close()
            end
          end
          cache[cached_dir] = nil
          log(cmd_str .. " stopped", "INFO")
        end
      end
    end

    local function find_dir(args)
      local dir = args ~= "" and args or "%:p:h"
      return vim.fn.expand(vim.fn.fnamemodify(vim.fn.expand(dir), ":p"))
    end

    vim.api.nvim_create_user_command(start_cmd, function(opts)
      do_start(find_dir(opts.args))
    end, { nargs = "?" })

    vim.api.nvim_create_user_command(stop_cmd, function(opts)
      do_stop(find_dir(opts.args))
    end, { nargs = "?" })
  end
end

return M
