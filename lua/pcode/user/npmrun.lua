local function open_new_buffer(name)
  local buf = vim.api.nvim_create_buf(true, false)
  vim.api.nvim_set_current_buf(buf)
  vim.api.nvim_buf_set_option(buf, "modifiable", true)
  if name then
    vim.api.nvim_buf_set_name(buf, name)
  end
  return buf
end

local M = {}

local main_cmd = "npm run dev" -- default

local function log(message, level)
  vim.notify(string.format("npm-dev-runner: %s", message), vim.log.levels[level])
end

-- Cache: dir -> { job_id=..., buf=... }
local job_cache = {}

local function find_cached_dir(dir)
  if not dir then
    vim.notify("npm-dev-runner: No directory provided to find_cached_dir()", vim.log.levels.ERROR)
    return
  end

  local cur = dir
  while not job_cache[cur] do
    if cur == "/" or string.match(cur, "^[A-Z]:\\$") then
      return
    end
    cur = vim.fn.fnamemodify(cur, ":h")
  end
  return cur
end

local function is_running(dir)
  local cached_dir = find_cached_dir(dir)
  return cached_dir and job_cache[cached_dir]
end

local function is_windows()
  return vim.loop.os_uname().version:match("Windows")
end

M.toggle = function(dir)
  local running = is_running(dir)
  if not running then
    M.start(dir)
    return
  end
  M.stop(dir)
end

--- Fungsi setup menerima argumen command utama, contoh: require("npmrun").setup("pnpm dev")
M.setup = function(cmd)
  main_cmd = cmd or "npm run dev"
  if not vim.fn.executable(main_cmd:match("%S+")) then
    log(main_cmd .. " is not executable. Make sure it is installed and in PATH.", "ERROR")
    return
  end

  local function find_dir(args)
    local dir = args ~= "" and args or "%:p:h"
    return vim.fn.expand(vim.fn.fnamemodify(vim.fn.expand(dir), ":p"))
  end

  vim.api.nvim_create_user_command("DevStart", function(opts)
    M.start(find_dir(opts.args))
  end, { nargs = "?" })

  vim.api.nvim_create_user_command("DevStop", function(opts)
    M.stop(find_dir(opts.args))
  end, { nargs = "?" })

  vim.api.nvim_create_user_command("DevToggle", function(opts)
    M.toggle(find_dir(opts.args))
  end, { nargs = "?" })
end

M.start = function(dir)
  if is_running(dir) then
    log(main_cmd .. " already running", "INFO")
    return
  end

  local cmd
  if is_windows() then
    cmd = { "cmd.exe", "/C" }
    for word in main_cmd:gmatch("%S+") do
      table.insert(cmd, word)
    end
  else
    cmd = {}
    for word in main_cmd:gmatch("%S+") do
      table.insert(cmd, word)
    end
  end

  local buffer_name = "npmrun.txt"
  local output_buf = open_new_buffer(buffer_name)
  vim.api.nvim_buf_set_lines(output_buf, 0, -1, false, {})

  local function append_to_buffer(lines)
    if not lines then
      return
    end
    if not vim.api.nvim_buf_is_valid(output_buf) then
      return
    end
    local filtered = {}
    for _, l in ipairs(lines) do
      if l ~= "" then
        table.insert(filtered, l)
      end
    end
    if #filtered > 0 then
      local line_count = vim.api.nvim_buf_line_count(output_buf)
      vim.api.nvim_buf_set_lines(output_buf, line_count, line_count, false, filtered)
    end
  end

  local function close_output_buffer()
    if output_buf and vim.api.nvim_buf_is_valid(output_buf) then
      vim.api.nvim_buf_delete(output_buf, { force = true })
    end
  end

  local job_id = vim.fn.jobstart(cmd, {
    cwd = dir,
    stdout_buffered = false, -- streaming mode
    stderr_buffered = false,
    on_stdout = function(_, data)
      append_to_buffer(data)
    end,
    on_stderr = function(_, data)
      append_to_buffer(vim.tbl_map(function(l)
        return "[ERR] " .. l
      end, data))
    end,
    on_exit = function(_, code)
      append_to_buffer({ string.format(main_cmd .. " exited with code %d", code) })
      close_output_buffer()
      job_cache[dir] = nil
    end,
  })

  job_cache[dir] = { job_id = job_id, buf = output_buf }
  log(main_cmd .. " started", "INFO")
end

M.stop = function(dir)
  local running = is_running(dir)
  if running then
    local cached_dir = find_cached_dir(dir)
    if cached_dir then
      local job_entry = job_cache[cached_dir]
      if job_entry then
        vim.fn.jobstop(job_entry.job_id)
        if job_entry.buf and vim.api.nvim_buf_is_valid(job_entry.buf) then
          vim.api.nvim_buf_delete(job_entry.buf, { force = true })
        end
      end
      job_cache[cached_dir] = nil
      log(main_cmd .. " stopped", "INFO")
    end
  end
end

return M
