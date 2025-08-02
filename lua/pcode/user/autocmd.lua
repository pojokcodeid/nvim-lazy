local api = vim.api

-- General Settings
api.nvim_create_augroup("_general_settings", { clear = true })

api.nvim_create_autocmd("FileType", {
  group = "_general_settings",
  pattern = "qf",
  command = "set nobuflisted",
})

-- Git Settings
api.nvim_create_augroup("_git", { clear = true })
api.nvim_create_autocmd("FileType", {
  group = "_git",
  pattern = "gitcommit",
  command = "setlocal wrap spell",
})

-- Markdown Settings
api.nvim_create_augroup("_markdown", { clear = true })
api.nvim_create_autocmd("FileType", {
  group = "_markdown",
  pattern = "markdown",
  command = "setlocal wrap spell",
})

-- Auto Resize
api.nvim_create_augroup("_auto_resize", { clear = true })
api.nvim_create_autocmd("VimResized", {
  group = "_auto_resize",
  command = "tabdo wincmd =",
})

-- Alpha Settings
api.nvim_create_augroup("_alpha", { clear = true })
api.nvim_create_autocmd("User", {
  group = "_alpha",
  pattern = "AlphaReady",
  command = "set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2",
})

-- Terminal Settings
api.nvim_create_augroup("neovim_terminal", { clear = true })
api.nvim_create_autocmd("TermOpen", {
  group = "neovim_terminal",
  command = "startinsert | set nonumber norelativenumber | nnoremap <buffer> <C-c> i<C-c>",
})

-- Function to Create Non-Existent Directory on BufWrite
local function MkNonExDir(file, buf)
  if vim.fn.empty(vim.fn.getbufvar(buf, "&buftype")) == 1 and not string.match(file, "^%w+://") then
    local dir = vim.fn.fnamemodify(file, ":h")
    if vim.fn.isdirectory(dir) == 0 then
      vim.fn.mkdir(dir, "p")
    end
  end
end

api.nvim_create_augroup("BWCCreateDir", { clear = true })
api.nvim_create_autocmd("BufWritePre", {
  group = "BWCCreateDir",
  callback = function(_)
    MkNonExDir(vim.fn.expand("<afile>"), vim.fn.expand("<abuf>"))
  end,
})

local autocmd = vim.api.nvim_create_autocmd
autocmd("VimEnter", {
  pattern = "*",
  callback = function()
    vim.opt.statusline = "%#normal# "
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "help", "alpha", "dashboard", "NvimTree", "Trouble", "lazy", "mason", "neotest-summary" },
  callback = function()
    vim.b.miniindentscope_disable = true
  end,
})

vim.filetype.add({
  pattern = {
    [".*%.blade%.php"] = "blade",
  },
})

-- config cursor
vim.opt.guicursor = {
  "n-v:block", -- Normal, Visual, Command mode: block cursor
  "i-ci-ve-c:ver25", -- Insert, Command-line Insert, Visual mode: vertical bar cursor
  "r-cr:hor20", -- Replace, Command-line Replace mode: horizontal bar cursor
  "o:hor50", -- Operator-pending mode: horizontal bar cursor
  "a:blinkwait700-blinkoff400-blinkon250", -- Blinking settings
  "sm:block-blinkwait175-blinkoff150-blinkon175", -- Select mode: block cursor with blinking
}

vim.api.nvim_create_autocmd("ExitPre", {
  group = vim.api.nvim_create_augroup("Exit", { clear = true }),
  command = "set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175,a:ver90",
  desc = "Set cursor back to beam when leaving Neovim.",
})

-- Extras
local function lsp_status()
  local bufnr = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients and vim.lsp.get_clients({ bufnr = bufnr })
    or vim.lsp.get_active_clients({ bufnr = bufnr })

  if #clients == 0 then
    print("󰅚 No LSP clients attached")
    return
  end

  print("󰒋 LSP Status for buffer " .. bufnr .. ":")
  print("─────────────────────────────────")

  for i, client in ipairs(clients) do
    print(string.format("󰌘 Client %d: %s (ID: %d)", i, client.name, client.id))
    print("  Root: " .. (client.config.root_dir or "N/A"))
    print("  Filetypes: " .. table.concat(client.config.filetypes or {}, ", "))

    -- Check capabilities
    local caps = client.server_capabilities
    local features = {}
    if caps.completionProvider then
      table.insert(features, "completion")
    end
    if caps.hoverProvider then
      table.insert(features, "hover")
    end
    if caps.definitionProvider then
      table.insert(features, "definition")
    end
    if caps.referencesProvider then
      table.insert(features, "references")
    end
    if caps.renameProvider then
      table.insert(features, "rename")
    end
    if caps.codeActionProvider then
      table.insert(features, "code_action")
    end
    if caps.documentFormattingProvider then
      table.insert(features, "formatting")
    end

    print("  Features: " .. table.concat(features, ", "))
    print("")
  end
end

vim.api.nvim_create_user_command("LspStatus", lsp_status, { desc = "Show detailed LSP status" })

local function check_lsp_capabilities()
  local bufnr = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients and vim.lsp.get_clients({ bufnr = bufnr })
    or vim.lsp.get_active_clients({ bufnr = bufnr })

  if #clients == 0 then
    print("No LSP clients attached")
    return
  end

  for _, client in ipairs(clients) do
    print("Capabilities for " .. client.name .. ":")
    local caps = client.server_capabilities

    local capability_list = {
      { "Completion", caps.completionProvider },
      { "Hover", caps.hoverProvider },
      { "Signature Help", caps.signatureHelpProvider },
      { "Go to Definition", caps.definitionProvider },
      { "Go to Declaration", caps.declarationProvider },
      { "Go to Implementation", caps.implementationProvider },
      { "Go to Type Definition", caps.typeDefinitionProvider },
      { "Find References", caps.referencesProvider },
      { "Document Highlight", caps.documentHighlightProvider },
      { "Document Symbol", caps.documentSymbolProvider },
      { "Workspace Symbol", caps.workspaceSymbolProvider },
      { "Code Action", caps.codeActionProvider },
      { "Code Lens", caps.codeLensProvider },
      { "Document Formatting", caps.documentFormattingProvider },
      { "Document Range Formatting", caps.documentRangeFormattingProvider },
      { "Rename", caps.renameProvider },
      { "Folding Range", caps.foldingRangeProvider },
      { "Selection Range", caps.selectionRangeProvider },
    }

    for _, cap in ipairs(capability_list) do
      local status = cap[2] and "✓" or "✗"
      print(string.format("  %s %s", status, cap[1]))
    end
    print("")
  end
end

vim.api.nvim_create_user_command("LspCapabilities", check_lsp_capabilities, { desc = "Show LSP capabilities" })

local function lsp_diagnostics_info()
  local bufnr = vim.api.nvim_get_current_buf()
  local diagnostics = vim.diagnostic.get(bufnr)

  local counts = { ERROR = 0, WARN = 0, INFO = 0, HINT = 0 }

  for _, diagnostic in ipairs(diagnostics) do
    local severity = vim.diagnostic.severity[diagnostic.severity]
    counts[severity] = counts[severity] + 1
  end

  print("󰒡 Diagnostics for current buffer:")
  print("  Errors: " .. counts.ERROR)
  print("  Warnings: " .. counts.WARN)
  print("  Info: " .. counts.INFO)
  print("  Hints: " .. counts.HINT)
  print("  Total: " .. #diagnostics)
end

vim.api.nvim_create_user_command("LspDiagnostics", lsp_diagnostics_info, { desc = "Show LSP diagnostics count" })

local function lsp_info()
  local bufnr = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients and vim.lsp.get_clients({ bufnr = bufnr })
    or vim.lsp.get_active_clients({ bufnr = bufnr })

  print("═══════════════════════════════════")
  print("           LSP INFORMATION          ")
  print("═══════════════════════════════════")
  print("")

  -- Basic info
  print("󰈙 Language client log: " .. vim.lsp.get_log_path())
  print("󰈔 Detected filetype: " .. vim.bo.filetype)
  print("󰈮 Buffer: " .. bufnr)
  print("󰈔 Root directory: " .. (vim.fn.getcwd() or "N/A"))
  print("")

  if #clients == 0 then
    print("󰅚 No LSP clients attached to buffer " .. bufnr)
    print("")
    print("Possible reasons:")
    print("  • No language server installed for " .. vim.bo.filetype)
    print("  • Language server not configured")
    print("  • Not in a project root directory")
    print("  • File type not recognized")
    return
  end

  print("󰒋 LSP clients attached to buffer " .. bufnr .. ":")
  print("─────────────────────────────────")

  for i, client in ipairs(clients) do
    print(string.format("󰌘 Client %d: %s", i, client.name))
    print("  ID: " .. client.id)
    print("  Root dir: " .. (client.config.root_dir or "Not set"))
    print("  Command: " .. table.concat(client.config.cmd or {}, " "))
    print("  Filetypes: " .. table.concat(client.config.filetypes or {}, ", "))

    -- Server status
    if client.is_stopped() then
      print("  Status: 󰅚 Stopped")
    else
      print("  Status: 󰄬 Running")
    end

    -- Workspace folders
    if client.workspace_folders and #client.workspace_folders > 0 then
      print("  Workspace folders:")
      for _, folder in ipairs(client.workspace_folders) do
        print("    • " .. folder.name)
      end
    end

    -- Attached buffers count
    local attached_buffers = {}
    for buf, _ in pairs(client.attached_buffers or {}) do
      table.insert(attached_buffers, buf)
    end
    print("  Attached buffers: " .. #attached_buffers)

    -- Key capabilities
    local caps = client.server_capabilities
    local key_features = {}
    if caps.completionProvider then
      table.insert(key_features, "completion")
    end
    if caps.hoverProvider then
      table.insert(key_features, "hover")
    end
    if caps.definitionProvider then
      table.insert(key_features, "definition")
    end
    if caps.documentFormattingProvider then
      table.insert(key_features, "formatting")
    end
    if caps.codeActionProvider then
      table.insert(key_features, "code_action")
    end

    if #key_features > 0 then
      print("  Key features: " .. table.concat(key_features, ", "))
    end

    print("")
  end

  -- Diagnostics summary
  local diagnostics = vim.diagnostic.get(bufnr)
  if #diagnostics > 0 then
    print("󰒡 Diagnostics Summary:")
    local counts = { ERROR = 0, WARN = 0, INFO = 0, HINT = 0 }

    for _, diagnostic in ipairs(diagnostics) do
      local severity = vim.diagnostic.severity[diagnostic.severity]
      counts[severity] = counts[severity] + 1
    end

    print("  󰅚 Errors: " .. counts.ERROR)
    print("  󰀪 Warnings: " .. counts.WARN)
    print("  󰋽 Info: " .. counts.INFO)
    print("  󰌶 Hints: " .. counts.HINT)
    print("  Total: " .. #diagnostics)
  else
    print("󰄬 No diagnostics")
  end

  print("")
  print("Use :LspLog to view detailed logs")
  print("Use :LspCapabilities for full capability list")
end

-- Create command
vim.api.nvim_create_user_command("LspInfo2", lsp_info, { desc = "Show comprehensive LSP information" })

vim.api.nvim_create_user_command("OpenBrowser", function(opts)
  local url = opts.args
  -- Jika tidak ada URL, pakai about:blank sebagai default
  if url == "" then
    url = "http://google.com"
  end

  -- Deteksi jika dijalankan di WSL
  local is_wsl = vim.fn.system("uname -r"):find("WSL")
  if is_wsl then
    vim.fn.jobstart({ "/mnt/c/Windows/System32/cmd.exe", "/c", "start", url }, { detach = true })
    return
  end

  -- Jika bukan WSL, gunakan cara biasa
  local open_cmd
  if vim.fn.has("mac") == 1 then
    open_cmd = "open"
  elseif vim.fn.has("unix") == 1 then
    open_cmd = "xdg-open"
  elseif vim.fn.has("win32") == 1 then
    open_cmd = "start"
  else
    print("OS tidak didukung.")
    return
  end

  vim.fn.jobstart({ open_cmd, url }, { detach = true })
end, { nargs = "?", complete = "file" })
