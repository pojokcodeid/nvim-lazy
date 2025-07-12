local function show_modal(text)
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, { text, "", "Press q to close" })

  local width = 50
  local height = 5
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    style = "minimal",
    border = "rounded",
  })

  vim.api.nvim_buf_set_keymap(buf, "n", "q", "", {
    noremap = true,
    silent = true,
    callback = function()
      vim.api.nvim_win_close(win, true)
    end,
  })
end

local M = {}

local function log(message, level)
  vim.notify(string.format("npm-dev-runner: %s", message), vim.log.levels[level])
end

-- Fungsi untuk mencari cache dir (supaya stop/start tetap per dir/project)
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

-- Fungsi cek proses running
local function is_running(dir, cache)
  local cached_dir = find_cached_dir(dir, cache)
  return cached_dir and cache[cached_dir]
end

local function is_windows()
  return vim.loop.os_uname().version:match("Windows")
end

M.setup = function(command_table)
  command_table = command_table or {}
  for key, conf in pairs(command_table) do
    local start_cmd = conf.start or ("NpmRun" .. key)
    local stop_cmd = conf.stop or ("NpmStop" .. key)
    local cmd_str = conf.cmd or "npm run dev"

    -- cache khusus untuk mode ini
    local cache = {}

    -- Fungsi Start
    local function do_start(dir)
      if is_running(dir, cache) then
        log(cmd_str .. " already running", "INFO")
        return
      end

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
        for _, line in ipairs(lines) do
          if line ~= "" then
            local str = tostring(line):gsub("^%s*(.-)%s*$", "%1")
            if string.find(str, "http") then
              show_modal(str)
            end
          end
        end
      end

      local job_id = vim.fn.jobstart(cmd, {
        cwd = dir,
        stdout_buffered = false,
        stderr_buffered = false,
        on_stdout = function(_, data)
          process_lines(data)
        end,
        on_stderr = function(_, data)
          process_lines(vim.tbl_map(function(l)
            return "[ERR] " .. l
          end, data))
        end,
        on_exit = function(_, _)
          cache[dir] = nil
        end,
      })

      cache[dir] = { job_id = job_id }
      log(cmd_str .. " started", "INFO")
    end

    -- Fungsi Stop
    local function do_stop(dir)
      local running = is_running(dir, cache)
      if running then
        local cached_dir = find_cached_dir(dir, cache)
        if cached_dir then
          local job_entry = cache[cached_dir]
          if job_entry then
            vim.fn.jobstop(job_entry.job_id)
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

    -- Register Perintah
    vim.api.nvim_create_user_command(start_cmd, function(opts)
      do_start(find_dir(opts.args))
    end, { nargs = "?" })

    vim.api.nvim_create_user_command(stop_cmd, function(opts)
      do_stop(find_dir(opts.args))
    end, { nargs = "?" })
  end
end

return M
