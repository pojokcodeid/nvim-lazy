local config_file = "jest.config.ts"
local M = {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "html", "javascript", "typescript", "tsx", "css", "json", "jsonc" })
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "html", "eslint", "cssls", "emmet_ls", "jsonls", "ts_ls" })
    end,
  },
  {
    "pojokcodeid/auto-conform.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      local package = "prettier"
      vim.list_extend(opts.ensure_installed, { package })
      opts.formatters_by_ft.javascript = { package }
    end,
  },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "antoinemadec/FixCursorHold.nvim",
      "nvim-neotest/neotest-jest",
      "nvim-neotest/nvim-nio",
    },
    opts = {
      adapters = {
        ["neotest-jest"] = {
          jestCommand = "npm test -- ",
          jestConfigFile = function()
            local file = vim.fn.expand("%:p")
            if string.find(file, "/packages/") then
              return string.match(file, "(.-/[^/]+/)src") .. config_file
            end
            return vim.fn.getcwd() .. "/" .. config_file
          end,
          cwd = function()
            local file = vim.fn.expand("%:p")
            if string.find(file, "/packages/") then
              return string.match(file, "(.-/[^/]+/)src")
            end
            return vim.fn.getcwd()
          end,
        },
      },
      status = { virtual_text = true },
      output = { open_on_run = true },
    },
    config = function(_, opts)
      local neotest_ns = vim.api.nvim_create_namespace("neotest")
      vim.diagnostic.config({
        virtual_text = {
          format = function(diagnostic)
            -- Replace newline and tab characters with space for more compact diagnostics
            local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
            return message
          end,
        },
      }, neotest_ns)

      opts.consumers = opts.consumers or {}
      if opts.adapters then
        local adapters = {}
        for name, config in pairs(opts.adapters or {}) do
          if type(name) == "number" then
            if type(config) == "string" then
              config = require(config)
            end
            adapters[#adapters + 1] = config
          elseif config ~= false then
            local adapter = require(name)
            if type(config) == "table" and not vim.tbl_isempty(config) then
              local meta = getmetatable(adapter)
              if adapter.setup then
                adapter.setup(config)
              elseif meta and meta.__call then
                adapter(config)
              else
                error("Adapter " .. name .. " does not support setup")
              end
            end
            adapters[#adapters + 1] = adapter
          end
        end
        opts.adapters = adapters
      end

      require("neotest").setup(opts)
      -- local command = pcode.npm_commad
      --   or {
      --     dev = {
      --       start = "NpmRunDev",
      --       stop = "NpmStopDev",
      --       cmd = "npm run dev",
      --     },
      --     prod = {
      --       start = "NpmStart",
      --       stop = "NpmStop",
      --       cmd = "npm start",
      --     },
      --   }
      -- require("pcode.user.npmrun").setup(command, {
      --   show_mapping = "<leader>nm",
      --   hide_mapping = "<leader>nh",
      --   width = 70,
      --   height = 20,
      -- })
    end,
    -- stylua: ignore
    keys = {
      { "<leader>T","",desc="  Test"},
      { "<leader>Tt", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run File" },
      { "<leader>Tr", function() require("neotest").run.run() end, desc = "Run Nearest" },
      { "<leader>TT", function() require("neotest").run.run(vim.loop.cwd()) end, desc = "Run All Test Files" },
      { "<leader>Tl", function() require("neotest").run.run_last() end, desc = "Run Last" },
      { "<Leader>Ts", function() require("neotest").summary.toggle() end, desc = "Toggle Summary" },
      { "<leader>To", function() require("neotest").output.open({ enter = true, auto_close = true }) end, desc = "Show Output" },
      { "<Leader>TO", function() require("neotest").output_panel.toggle() end, desc = "Toggle Output Panel" },
      { "<Leader>TS", function() require("neotest").run.stop() end, desc = "Stop" },
    },
  },
  {
    "pojokcodeid/npm-runner.nvim",
    event = "VeryLazy",
    dependencies = {
      "rcarriga/nvim-notify",
    },
    -- your opts go here
    opts = {
      command = {
        dev = {
          start = "NpmRunDev",
          stop = "NpmStopDev",
          cmd = "npm run dev",
        },
        prod = {
          start = "NpmStart",
          stop = "NpmStop",
          cmd = "npm start",
        },
      },
      opt = {
        show_mapping = "<leader>nm",
        hide_mapping = "<leader>nh",
        width = 70,
        height = 20,
      },
    },
    keys = {
      { "<leader>n", "", desc = "  Npm" },
    },
    config = function(_, opts)
      require("npm-runner").setup(opts.command, opts.opt)
      -- js new project
      local function js_new_project()
        local function create_notif(message, level)
          local notif_ok, notify = pcall(require, "notify")
          if notif_ok then
            notify(message, level)
          else
            print(message)
          end
        end

        local function get_user_input(prompt, default_value)
          vim.fn.inputsave()
          local result = vim.fn.input(prompt, default_value)
          vim.fn.inputrestore()
          if result == "" then
            create_notif("Input canceled.", "info")
            return nil, true
          end
          return result, false
        end

        -- Input nama project
        local project_name, canceled = get_user_input("Enter project name: ", "my-js-app")
        if canceled then
          return
        end

        -- Input file entry point (bisa src/index.js, index.js, src/main/index.js, dsb)
        local file_path_input, canceled = get_user_input(
          "Enter entry file name \n(\nindex.js, \nsrc/index.js, \nsrc/main/index.js\n): ",
          "src/index.js"
        )
        if canceled then
          return
        end

        -- Input nama function utama
        local function_name, canceled = get_user_input("Enter main function name: ", "main")
        if canceled then
          return
        end

        local cwd = vim.fn.getcwd()
        local project_path = cwd .. "/" .. project_name

        if vim.fn.isdirectory(project_path) == 1 then
          create_notif("Project directory already exists: " .. project_path, "error")
          return
        end

        -- Dapatkan folder dan filename dari file_path_input
        local folder_part = file_path_input:match("(.+)/[^/]+%.js$") or "" -- e.g. "src/main" or ""
        local file_name_part = file_path_input:match("([^/]+)%.js$") -- e.g. "index"

        -- Buat project folder dan subfolder jika ada
        local full_folder_path = (folder_part ~= "") and (project_path .. "/" .. folder_part) or project_path
        vim.fn.system(string.format("mkdir -p '%s'", full_folder_path))

        -- path file entry point absolut
        local entry_file = string.format("%s/%s.js", full_folder_path, file_name_part)

        -- Buat package.json dengan "main" dan scripts dinamis
        local package_json = string.format(
          [[
{
  "name": "%s",
  "version": "1.0.0",
  "main": "%s",
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1",
    "start": "node %s",
    "dev": "nodemon %s"
  },
  "author": "",
  "license": "ISC",
  "devDependencies": {
    "nodemon": "^3.1.0"
  }
}
]],
          project_name,
          file_path_input,
          file_path_input,
          file_path_input
        )
        local package_json_path = project_path .. "/package.json"
        local pkg_file = io.open(package_json_path, "w")
        if pkg_file then
          pkg_file:write(package_json)
          pkg_file:close()
        end

        -- Tambahkan generate jsconfig.json
        local jsconfig = [[
{
  "compilerOptions": {
    "module": "commonjs",
    "target": "es6",
    "allowSyntheticDefaultImports": true
  },
  "exclude": ["node_modules"],
  "include": ["**/*.js"]
}
]]
        local jsconfig_path = project_path .. "/jsconfig.json"
        local jsconfig_file = io.open(jsconfig_path, "w")
        if jsconfig_file then
          jsconfig_file:write(jsconfig)
          jsconfig_file:close()
        end

        -- Template kode JS
        local js_code = string.format(
          [[
function %s() {

}

%s();
]],
          function_name,
          function_name
        )

        local file = io.open(entry_file, "w")
        if file then
          file:write(js_code)
          file:close()
          create_notif("JavaScript project created at " .. project_path, "info")
          vim.cmd("cd " .. project_path)

          -- Jalankan npm install (async, biar tidak blok nvim)
          vim.fn.jobstart("npm install", {
            cwd = project_path,
            detach = false,
            on_stdout = function(_, data)
              if data and type(data) == "table" then
                local msg = table.concat(
                  vim.tbl_filter(function(line)
                    return line and line ~= ""
                  end, data),
                  "\n"
                )
                if msg ~= "" then
                  create_notif("npm install: " .. msg, "info")
                end
              end
            end,
            on_stderr = function(_, data)
              if data and type(data) == "table" then
                local msg = table.concat(
                  vim.tbl_filter(function(line)
                    return line and line ~= ""
                  end, data),
                  "\n"
                )
                if msg ~= "" then
                  create_notif("npm install error: " .. msg, "error")
                end
              end
            end,
            on_exit = function(_, code)
              if code == 0 then
                create_notif("npm install finished", "info")
              else
                create_notif("npm install failed", "error")
              end
            end,
          })

          -- Jika ada NvimTreeOpen, jalankan lalu fokus ke file JS
          if vim.fn.exists(":NvimTreeOpen") == 2 then
            vim.cmd("NvimTreeOpen")
            vim.schedule(function()
              vim.cmd("edit " .. entry_file)
              local lines = {}
              for line in js_code:gmatch("([^\n]*)\n?") do
                table.insert(lines, line)
              end
              local func_line = 1
              for i, line in ipairs(lines) do
                if line:find("function%s+" .. function_name .. "%s*%(") then
                  func_line = i
                  break
                end
              end
              local target_line = func_line + 1
              vim.api.nvim_win_set_cursor(0, { target_line, 2 })
              vim.cmd("startinsert")
            end)
          else
            vim.cmd("edit " .. entry_file)
            local lines = {}
            for line in js_code:gmatch("([^\n]*)\n?") do
              table.insert(lines, line)
            end
            local func_line = 1
            for i, line in ipairs(lines) do
              if line:find("function%s+" .. function_name .. "%s*%(") then
                func_line = i
                break
              end
            end
            local target_line = func_line + 1
            vim.api.nvim_win_set_cursor(0, { target_line, 2 })
            vim.cmd("startinsert")
          end
        else
          create_notif("Failed to create file: " .. entry_file, "error")
        end
      end

      vim.api.nvim_create_user_command("JsNewProject", js_new_project, {})
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    lazy = true,
    event = "BufRead",
    dependencies = {
      { "mfussenegger/nvim-dap", lazy = true },
      { "nvim-neotest/nvim-nio", lazy = true },
      {
        "mxsdev/nvim-dap-vscode-js",
        dependencies = {
          "microsoft/vscode-js-debug",
          version = "1.x",
          build = "npm i && npm run compile vsDebugServerBundle && mv dist out",
        },
        config = function()
          require("dap-vscode-js").setup({
            -- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
            debugger_path = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug",
            -- debugger_cmd = { "extension" }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
            adapters = {
              "chrome",
              "pwa-node",
              "pwa-chrome",
              "pwa-msedge",
              "node-terminal",
              "pwa-extensionHost",
              "node",
              "chrome",
            }, -- which adapters to register in nvim-dap
            -- log_file_path = "(stdpath cache)/dap_vscode_js.log" -- Path for file logging
            -- log_file_level = false -- Logging level for output to file. Set to false to disable file logging.
            -- log_console_level = vim.log.levels.ERROR -- Logging level for output to console. Set to false to disable console output.
          })
        end,
      },
    },
    config = function()
      require("pcode.user.dapui")
      local js_based_languages = { "typescript", "javascript", "typescriptreact" }

      for _, language in ipairs(js_based_languages) do
        require("dap").configurations[language] = {
          {
            type = "pwa-node",
            request = "launch",
            name = "Launch file",
            program = "${file}",
            cwd = "${workspaceFolder}",
          },
          {
            type = "pwa-node",
            request = "attach",
            name = "Attach",
            processId = require("dap.utils").pick_process,
            cwd = "${workspaceFolder}",
          },
          {
            type = "pwa-chrome",
            request = "launch",
            name = 'Start Chrome with "localhost"',
            url = "http://localhost:3000",
            webRoot = "${workspaceFolder}",
            userDataDir = "${workspaceFolder}/.vscode/vscode-chrome-debug-userdatadir",
          },
        }
      end
    end,
    keys = {
      { "<leader>d", "", desc = "  Debug" },
      { "<leader>dt", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", desc = "Toggle Breakpoint" },
      { "<leader>db", "<cmd>lua require'dap'.step_back()<cr>", desc = "Step Back" },
      { "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", desc = "Continue" },
      { "<leader>dC", "<cmd>lua require'dap'.run_to_cursor()<cr>", desc = "Run To Cursor" },
      { "<leader>dd", "<cmd>lua require'dap'.disconnect()<cr>", desc = "Disconnect" },
      { "<leader>dg", "<cmd>lua require'dap'.session()<cr>", desc = "Get Session" },
      { "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", desc = "Step Into" },
      { "<leader>do", "<cmd>lua require'dap'.step_over()<cr>", desc = "Step Over" },
      { "<leader>du", "<cmd>lua require'dap'.step_out()<cr>", desc = "Step Out" },
      { "<leader>dp", "<cmd>lua require'dap'.pause()<cr>", desc = "Pause" },
      { "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", desc = "Toggle Repl" },
      { "<leader>ds", "<cmd>lua require'dap'.continue()<cr>", desc = "Start" },
      { "<leader>dq", "<cmd>lua require'dap'.close()<cr>", desc = "Quit" },
      { "<leader>dU", "<cmd>lua require'dapui'.toggle({reset = true})<cr>", desc = "Toggle UI" },
    },
  },
}

return M
