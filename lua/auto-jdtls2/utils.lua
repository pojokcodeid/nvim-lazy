local M = {}
M.java_filetypes = { "java" }
M.root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }

-- Utility function to extend or override a config table, similar to the way
-- that Plugin.opts works.
---@param config table
---@param custom function | table | nil
M.extend_or_override = function(config, custom, ...)
  if type(custom) == "function" then
    config = custom(config, ...) or config
  elseif custom then
    config = vim.tbl_deep_extend("force", config, custom) --[[@as table]]
  end
  return config
end

function M.capabilities()
  local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
  if status_ok then
    return cmp_nvim_lsp.default_capabilities()
  end

  local CAPABILITIES = vim.lsp.protocol.make_client_capabilities()
  CAPABILITIES.textDocument.completion.completionItem.snippetSupport = true
  CAPABILITIES.textDocument.completion.completionItem.resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  }

  return CAPABILITIES
end
-- stylua: ignore
M.lsp_keymaps=function ()
  vim.keymap.set({ "n", "v" }, "<leader>l", "", { desc = "LSP" })
  -- Set vim motion for <Space> + l + h to show code documentation about the code the cursor is currently over if available
  vim.keymap.set("n", "<leader>lh", vim.lsp.buf.hover, { desc = "Code Hover Documentation" })
  -- Set vim motion for <Space> + l + d to go where the code/variable under the cursor was defined
  vim.keymap.set("n", "<leader>ld", vim.lsp.buf.definition, { desc = "Code Goto Definition" })
  -- Set vim motion for <Space> + l + a for display code action suggestions for code diagnostics in both normal and visual mode
  vim.keymap.set({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, { desc = "Code Actions" })
  -- Set vim motion for <Space> + l + r to display references to the code under the cursor
  vim.keymap.set("n", "<leader>lr", require("telescope.builtin").lsp_references, { desc = "Code Goto References" })
  -- Set vim motion for <Space> + l + i to display implementations to the code under the cursor
  vim.keymap.set("n", "<leader>li", require("telescope.builtin").lsp_implementations, { desc = "Code Goto Implementations" })
  -- Set a vim motion for <Space> + l + <Shift>R to smartly rename the code under the cursor
  vim.keymap.set("n", "<leader>lR", vim.lsp.buf.rename, { desc = "Code Rename" })
  -- Set a vim motion for <Space> + l + <Shift>D to go to where the code/object was declared in the project (class file)
  vim.keymap.set("n", "<leader>lD", vim.lsp.buf.declaration, { desc = "Code Goto Declaration" })
end

M.is_maven_project = function()
  if vim.fn.findfile("pom.xml", vim.fn.getcwd()) == "pom.xml" then
    return true
  else
    return false
  end
end

M.is_gradle_project = function()
  if
    vim.fn.findfile("build.gradle", vim.fn.getcwd()) == "build.gradle"
    or vim.fn.findfile("settings.gradle", vim.fn.getcwd()) == "settings.gradle"
    or vim.fn.findfile("gradlew", vim.fn.getcwd()) == "gradlew"
  then
    return true
  else
    return false
  end
end

M.is_main_class = function()
  local bufnr = vim.api.nvim_get_current_buf()
  local content = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  for i, line in ipairs(content) do
    if line:match("public static void main%s*%(") then
      return true
    end
  end

  return false
end

M.run_aven_pring_boot = function()
  if M.is_maven_project() then
    vim.cmd("terminal mvn spring-boot:run")
  else
    local notif_ok, notify = pcall(require, "notify")
    if notif_ok then
      notify("Project pom.xml not found !", "info")
    else
      print("Project pom.xml not found !")
    end
  end
end

M.cmd_maven_spring_boot = function()
  vim.api.nvim_create_user_command("RunMvnSpringBoot", function()
    M.run_aven_pring_boot()
  end, { nargs = 0 })
end

M.run_gradle_spring_boot = function()
  if M.is_gradle_project() then
    local uname = vim.loop.os_uname().sysname
    if uname == "Windows_NT" then
      vim.cmd("terminal .\\gradlew build --continuous")
      vim.cmd("terminal .\\gradlew bootRun")
    else
      vim.cmd("terminal ./gradlew build --continuous")
      vim.cmd("terminal ./gradlew bootRun")
    end
  else
    local notif_ok, notify = pcall(require, "notify")
    if notif_ok then
      notify("Project build.gradle not found !", "info")
    else
      print("Project build.gradle not found !")
    end
  end
end

M.cmd_gradle_spring_boot = function()
  vim.api.nvim_create_user_command("RunGradleSpringBoot", function()
    M.run_gradle_spring_boot()
  end, { nargs = 0 })
end

M.run_mvn_and_java = function()
  if M.is_maven_project() then
    local result = M.is_main_class()
    if not result then
      local notif_ok, notify = pcall(require, "notify")
      if notif_ok then
        notify("Please open java main class !", "info")
      else
        print("Please open java main class !")
      end
      return
    else
      -- Fungsi untuk mencari file .jar dalam folder target
      local function find_jar_file()
        local target_dir = "target"
        local jar_file = nil

        local handle = vim.loop.fs_scandir(target_dir)
        if handle then
          while true do
            local name, t = vim.loop.fs_scandir_next(handle)
            if not name then
              break
            end
            if t == "file" and name:match("%.jar$") then
              jar_file = name
              break
            end
          end
        end
        return jar_file
      end
      local jar_file = find_jar_file()
      -- Buat fungsi untuk menjalankan perintah secara berurutan dalam mode diam
      function RunMvnAndJava()
        -- daptkan path
        local root = vim.uv.cwd()
        local fname = vim.api.nvim_buf_get_name(0)
        fname = fname:gsub(root, "")
        fname = fname:gsub("/src/main/java/", "")
        fname = fname:gsub("\\src\\main\\java\\", "")
        fname = fname:gsub(".java", ""):gsub("/", ".")
        fname = fname:gsub("\\", ".")
        -- Jalankan perintah mvn package secara diam-diam
        local notif_ok, notify = pcall(require, "notify")
        if notif_ok then
          notify("Compile Start !", "info")
        end
        vim.fn.jobstart("mvn package", {
          on_exit = function()
            vim.cmd("terminal java -cp target/" .. jar_file .. " " .. fname)
          end,
        })
      end
      RunMvnAndJava()
    end
  else
    local notif_ok, notify = pcall(require, "notify")
    if notif_ok then
      notify("Project pom.xml not found !", "info")
    else
      print("Project pom.xml not found !")
    end
  end
end

M.cmd_mvn_and_java = function()
  vim.api.nvim_create_user_command("RunMaven", function()
    M.run_mvn_and_java()
  end, { nargs = 0 })
end

M.cmd_gradle = function()
  vim.api.nvim_create_user_command("RunGradle", function()
    vim.cmd("terminal gradle run")
  end, { nargs = 0 })
end

-- stylua: ignore 
M.jdtls_keymaps=function ()
  -- add keymaps
  vim.keymap.set('n', '<leader>J', "", { desc = "Java" })
  -- Set a Vim motion to <Space> + <Shift>J + o to organize imports in normal mode
  vim.keymap.set('n', '<leader>Jo', "<Cmd> lua require('jdtls').organize_imports()<CR>", { desc = "Java Organize Imports" })
  -- Set a Vim motion to <Space> + <Shift>J + v to extract the code under the cursor to a variable
  vim.keymap.set('n', '<leader>Jv', "<Cmd> lua require('jdtls').extract_variable()<CR>", { desc = "Java Extract Variable" })
  -- Set a Vim motion to <Space> + <Shift>J + v to extract the code selected in visual mode to a variable
  vim.keymap.set('v', '<leader>Jv', "<Esc><Cmd> lua require('jdtls').extract_variable(true)<CR>", { desc = "Java Extract Variable" })
  -- Set a Vim motion to <Space> + <Shift>J + <Shift>C to extract the code under the cursor to a static variable
  vim.keymap.set('n', '<leader>JC', "<Cmd> lua require('jdtls').extract_constant()<CR>", { desc = "Java Extract Constant" })
  -- Set a Vim motion to <Space> + <Shift>J + <Shift>C to extract the code selected in visual mode to a static variable
  vim.keymap.set('v', '<leader>JC', "<Esc><Cmd> lua require('jdtls').extract_constant(true)<CR>", { desc = "Java Extract Constant" })
  -- Set a Vim motion to <Space> + <Shift>J + t to run the test method currently under the cursor
  vim.keymap.set('n', '<leader>Jt', "<Cmd> lua require('jdtls').test_nearest_method()<CR>", { desc = "Java Test Method" })
  -- Set a Vim motion to <Space> + <Shift>J + t to run the test method that is currently selected in visual mode
  vim.keymap.set('v', '<leader>Jt', "<Esc><Cmd> lua require('jdtls').test_nearest_method(true)<CR>", { desc = "Java Test Method" })
  -- Set a Vim motion to <Space> + <Shift>J + <Shift>T to run an entire test suite (class)
  vim.keymap.set('n', '<leader>JT', "<Cmd> lua require('jdtls').test_class()<CR>", { desc = "Java Test Class" })
  -- Set a Vim motion to <Space> + <Shift>J + u to update the project configuration
  vim.keymap.set('n', '<leader>Ju', "<Cmd> JdtUpdateConfig<CR>", { desc = "Java Update Config" })
end

M.opts = {
  root_dir = require("jdtls.setup").find_root(M.root_markers),
  project_name = function()
    return vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
  end,

  get_jdtls = function()
    local function check_os()
      local uname = vim.loop.os_uname().sysname
      if uname == "Darwin" then
        return "mac"
      elseif uname == "Windows_NT" then
        return "win"
      elseif uname == "Linux" then
        return "linux"
      else
        return "unknown"
      end
    end
    local mason_registry = require("mason-registry")
    local jdtls = mason_registry.get_package("jdtls")
    local jdtls_path = jdtls:get_install_path()
    local launcher = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")
    local SYSTEM = check_os()
    local config = jdtls_path .. "/config_" .. SYSTEM
    local lombok = jdtls_path .. "/lombok.jar"
    return launcher, config, lombok
  end,

  jdtls_workspace_dir = function(project_name)
    local function get_workspace()
      local home = os.getenv("HOME")
      local workspace_path = home .. "/code/workspace/"
      local workspace_dir = workspace_path .. project_name
      return workspace_dir
    end
    return get_workspace()
  end,
  full_cmd = function(opts)
    local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
    local launcher, os_config, lombok = opts.get_jdtls()
    local cmd = {
      "java",
      "-Declipse.application=org.eclipse.jdt.ls.core.id1",
      "-Dosgi.bundles.defaultStartLevel=4",
      "-Declipse.product=org.eclipse.jdt.ls.core.product",
      "-Dlog.protocol=true",
      "-Dlog.level=ALL",
      "-Xmx1g",
      "--add-modules=ALL-SYSTEM",
      "--add-opens",
      "java.base/java.util=ALL-UNNAMED",
      "--add-opens",
      "java.base/java.lang=ALL-UNNAMED",
      "-javaagent:" .. lombok,
      "-jar",
      launcher,
      "-configuration",
      os_config,
      "-data",
      opts.jdtls_workspace_dir(project_name),
    }
    return cmd
  end,

  -- These depend on nvim-dap, but can additionally be disabled by setting false here.
  dap = { hotcodereplace = "auto", config_overrides = {} },
  dap_main = {},
  test = true,
  settings = {
    java = {
      inlayHints = {
        parameterNames = {
          enabled = "all",
        },
      },
    },
  },
}

M.attach_jdtls = function(op)
  M.opts = M.extend_or_override(M.opts, op or {})
  local opt = vim.opt
  opt.shiftwidth = 4
  opt.tabstop = 4
  opt.softtabstop = 4
  opt.ts = 4
  opt.expandtab = true

  --  Check Ttriisittrer

  local function ensure_ts_install(lang)
    local parsers = require("nvim-treesitter.parsers")
    local installed = parsers.has_parser(lang)

    if not installed then
      vim.cmd("TSInstall " .. lang)
      require("notify")("Treesitter parser for " .. lang .. " installed successfully.")
    end
  end

  -- Memeriksa dan menginstal atau mengonfirmasi Treesitter untuk Java
  ensure_ts_install("java")

  local mason_registry = require("mason-registry")
  if
    not mason_registry.is_installed("jdtls")
    or not mason_registry.is_installed("java-debug-adapter")
    or not mason_registry.is_installed("java-test")
  then
    vim.cmd("Mason")
    require("notify")("Mason Installed Dependency, please restart nvim after installation is completed")
    return
  end
  local bundles = {} ---@type string[]
  if M.opts.dap and mason_registry.is_installed("java-debug-adapter") then
    local java_dbg_pkg = mason_registry.get_package("java-debug-adapter")
    local java_dbg_path = java_dbg_pkg:get_install_path()
    local jar_patterns = {
      java_dbg_path .. "/extension/server/com.microsoft.java.debug.plugin-*.jar",
    }
    -- java-test also depends on java-debug-adapter.
    if M.opts.test and mason_registry.is_installed("java-test") then
      local java_test_pkg = mason_registry.get_package("java-test")
      local java_test_path = java_test_pkg:get_install_path()
      vim.list_extend(jar_patterns, {
        java_test_path .. "/extension/server/*.jar",
      })
    end
    for _, jar_pattern in ipairs(jar_patterns) do
      for _, bundle in ipairs(vim.split(vim.fn.glob(jar_pattern), "\n")) do
        table.insert(bundles, bundle)
      end
    end
  end
  -- initialisasi config
  local function attach_jdtls()
    -- load user cmd
    M.cmd_maven_spring_boot()
    M.cmd_gradle_spring_boot()
    M.cmd_mvn_and_java()
    M.cmd_gradle()
    -- Configuration can be augmented and overridden by opts.jdtls
    local config = M.extend_or_override({
      cmd = M.opts.full_cmd(M.opts),
      root_dir = require("jdtls.setup").find_root(M.root_markers),
      init_options = {
        bundles = bundles,
      },
      settings = M.opts.settings,
      -- enable CMP capabilities
      -- capabilities = require("user.lsp.handlers").capabilities or nil,
      -- capabilities = require("auto-lsp.lsp.handlers").capabilities or nil,
      capabilities = M.capabilities() or nil,
    }, M.opts.jdtls)

    -- Existing server will be reused if the root_dir matches.
    require("jdtls").start_or_attach(config)
  end

  vim.api.nvim_create_autocmd("FileType", {
    pattern = M.java_filetypes,
    callback = attach_jdtls,
  })

  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
        -- stylua: ignore
        if client and client.name == "jdtls" then
          -- M.jdtls_keymaps()
          -- M.lsp_keymaps()
          if M.opts.dap and mason_registry.is_installed("java-debug-adapter") then
            -- custom init for Java debugger
            require("jdtls").setup_dap(M.opts.dap)
            require("jdtls.dap").setup_dap_main_class_configs(M.opts.dap_main)
          end

          -- User can set additional keymaps in opts.on_attach
          if M.opts.on_attach then
            M.opts.on_attach(args)
          end
        end
    end,
  })

  attach_jdtls()
end

M.install = function()
  local ensure_installed = {
    "java-debug-adapter",
    "java-test",
    "jdtls",
  }
  local mr = require("mason-registry")
  mr:on("package:install:success", function()
    vim.defer_fn(function()
      -- trigger FileType event to possibly load this newly installed LSP server
      require("lazy.core.handler.event").trigger({
        event = "FileType",
        buf = vim.api.nvim_get_current_buf(),
      })
    end, 100)
  end)

  mr.refresh(function()
    for _, tool in ipairs(ensure_installed) do
      local p = mr.get_package(tool)
      if not p:is_installed() then
        p:install()
      end
    end
  end)
end
return M
