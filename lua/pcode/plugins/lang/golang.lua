return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "go", "gomod", "gosum", "gotmpl", "gowork" })
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "gopls" })
      vim.api.nvim_create_user_command("GoRun", function()
        local filename = vim.fn.expand("%:p") -- path lengkap file aktif
        if not filename:match("%.go$") then
          vim.notify("current file is not a go file.", vim.log.levels.WARN, { title = "GoRun" })
          return
        end

        local Terminal = require("toggleterm.terminal").Terminal
        local go_runner = Terminal:new({
          cmd = "go run " .. filename,
          direction = "float",
          close_on_exit = false,
          hidden = true,
        })

        go_runner:toggle()
      end, {})
      vim.api.nvim_create_user_command("GoBuild", function()
        local cwd = vim.fn.getcwd()
        local go_mod_path = cwd .. "/go.mod"
        if vim.fn.filereadable(go_mod_path) == 0 then
          vim.notify("current project is not a go project.", vim.log.levels.WARN, { title = "GoBuild" })
          return
        end

        local Terminal = require("toggleterm.terminal").Terminal
        -- create file exe jika os adalah windows
        local filename = "output"
        if vim.fn.has("win32") == 1 then
          filename = "output.exe"
        end
        local go_runner = Terminal:new({
          cmd = "go build -o " .. filename .. " && ./" .. filename,
          direction = "float",
          close_on_exit = false,
          hidden = true,
        })

        go_runner:toggle()
      end, {})

      -- Fungsi untuk membuat proyek Go
      local function go_new_project()
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

        local project_name, canceled = get_user_input("Enter project name: ", "myapp")
        if canceled then
          return
        end

        local file_name, canceled = get_user_input("Enter file name (without .go): ", "main")
        if canceled then
          return
        end

        local function_name, canceled = get_user_input("Enter function name: ", "main")
        if canceled then
          return
        end

        local cwd = vim.fn.getcwd()
        local project_path = cwd .. "/" .. project_name
        if vim.fn.isdirectory(project_path) == 1 then
          create_notif("Project directory already exists: " .. project_path, "error")
          return
        end

        local mkdir_cmd = string.format("mkdir -p '%s'", project_path)
        local gomod_cmd = string.format("cd '%s' && go mod init %s", project_path, project_name)
        local entry_file = string.format("%s/%s.go", project_path, file_name)
        local main_code = string.format(
          [[
package main

import "fmt"

func %s() {
  fmt.Println("Hello, world!")
}
]],
          function_name
        )

        vim.fn.system(mkdir_cmd)
        vim.fn.system(gomod_cmd)

        local file = io.open(entry_file, "w")
        if file then
          file:write(main_code)
          file:close()
          create_notif("Go project created at " .. project_path, "info")
          vim.cmd("cd " .. project_path)

          -- Jika ada NvimTreeOpen, jalankan lalu kembalikan fokus ke file
          if vim.fn.exists(":NvimTreeOpen") == 2 then
            vim.cmd("NvimTreeOpen")
            -- Penjadwalan agar kembali ke buffer file Go setelah NvimTree terbuka
            vim.schedule(function()
              vim.cmd("edit " .. entry_file)
              -- Cari baris function
              local lines = {}
              for line in main_code:gmatch("([^\n]*)\n?") do
                table.insert(lines, line)
              end
              local func_line = 1
              for i, line in ipairs(lines) do
                if line:find("func%s+" .. function_name .. "%s*%(") then
                  func_line = i
                  break
                end
              end
              local target_line = func_line + 1
              vim.api.nvim_win_set_cursor(0, { target_line, 4 })
              vim.cmd("startinsert")
            end)
          else
            vim.cmd("edit " .. entry_file)
            local lines = {}
            for line in main_code:gmatch("([^\n]*)\n?") do
              table.insert(lines, line)
            end
            local func_line = 1
            for i, line in ipairs(lines) do
              if line:find("func%s+" .. function_name .. "%s*%(") then
                func_line = i
                break
              end
            end
            local target_line = func_line + 1
            vim.api.nvim_win_set_cursor(0, { target_line, 4 })
            vim.cmd("startinsert")
          end
        else
          create_notif("Failed to create file: " .. entry_file, "error")
        end
      end

      vim.api.nvim_create_user_command("GoNewProject", go_new_project, {})

      -- Fungsi untuk membuat file Go
      local function go_new_file()
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

        -- Ambil nama folder
        local folder_name, canceled = get_user_input("Enter folder name (dot for current folder): ", ".")
        if canceled then
          return
        end

        -- Ambil nama file (tanpa .go)
        local file_name, canceled = get_user_input("Enter file name (without .go): ", "newfile")
        if canceled then
          return
        end

        -- Ambil nama package
        local package_name, canceled = get_user_input("Enter package name: ", "main")
        if canceled then
          return
        end

        -- Ambil nama function
        local function_name, canceled = get_user_input("Enter function name: ", "main")
        if canceled then
          return
        end

        local cwd = vim.fn.getcwd()
        local folder_path = (folder_name == "." or folder_name == "") and cwd or cwd .. "/" .. folder_name

        -- Cek dan buat folder jika perlu
        if vim.fn.isdirectory(folder_path) == 0 then
          local mkdir_cmd = string.format("mkdir -p '%s'", folder_path)
          vim.fn.system(mkdir_cmd)
        end

        local file_path = string.format("%s/%s.go", folder_path, file_name)

        if vim.fn.filereadable(file_path) == 1 then
          create_notif("File already exists: " .. file_path, "error")
          return
        end

        local code = string.format(
          [[
package %s

func %s() {

}
]],
          package_name,
          function_name
        )

        -- Buat file dan isi konten
        local file = io.open(file_path, "w")
        if file then
          file:write(code)
          file:close()
          create_notif("Go file created: " .. file_path, "info")

          -- Buka file dan tempatkan kursor di bawah function, mode insert
          vim.cmd("edit " .. file_path)
          local lines = {}
          for line in code:gmatch("([^\n]*)\n?") do
            table.insert(lines, line)
          end
          local func_line = 1
          for i, line in ipairs(lines) do
            if line:find("func%s+" .. function_name .. "%s*%(") then
              func_line = i
              break
            end
          end
          local target_line = func_line + 1
          vim.api.nvim_win_set_cursor(0, { target_line, 4 })
          vim.cmd("startinsert")
        else
          create_notif("Failed to create file: " .. file_path, "error")
        end
      end

      vim.api.nvim_create_user_command("GoNewFile", go_new_file, {})
    end,
  },
  {
    "pojokcodeid/auto-conform.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      local package = "gofumpt"
      vim.list_extend(opts.ensure_installed, { package })
      opts.formatters_by_ft.gofumpt = { package }
    end,
  },
  {
    "pojokcodeid/auto-lint.nvim",
    opts = function(_, opts)
      opts.linters_by_ft = opts.linters_by_ft or {}
      vim.list_extend(opts.ensure_installed, { "golangci-lint" })
      opts.linters_by_ft.php = { "golangci-lint" }
    end,
  },
  {
    "nvim-neotest/neotest",
    event = "VeryLazy",
    ft = "go",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",

      "nvim-neotest/neotest-plenary",
      "nvim-neotest/neotest-vim-test",

      "nvim-neotest/nvim-nio",

      {
        "fredrikaverpil/neotest-golang",
        dependencies = {
          {
            "leoluz/nvim-dap-go",
            opts = {},
          },
        },
        branch = "main",
      },
    },
    opts = function(_, opts)
      opts.adapters = opts.adapters or {}
      opts.adapters["neotest-golang"] = {
        go_test_args = {
          "-v",
          "-race",
          "-count=1",
          "-timeout=60s",
          "-coverprofile=" .. vim.fn.getcwd() .. "/coverage.out",
        },
        dap_go_enabled = true,
      }
    end,
    config = function(_, opts)
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
    end,
      -- stylua: ignore
      keys = {
        { "<leader>T","",desc="  Test"},
        { "<leader>Ta", function() require("neotest").run.attach() end, desc = "[t]est [a]ttach" },
        { "<leader>Tf", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "[t]est run [f]ile" },
        { "<leader>TA", function() require("neotest").run.run(vim.uv.cwd()) end, desc = "[t]est [A]ll files" },
        { "<leader>TS", function() require("neotest").run.run({ suite = true }) end, desc = "[t]est [S]uite" },
        { "<leader>Tn", function() require("neotest").run.run() end, desc = "[t]est [n]earest" },
        { "<leader>Tl", function() require("neotest").run.run_last() end, desc = "[t]est [l]ast" },
        { "<leader>Ts", function() require("neotest").summary.toggle() end, desc = "[t]est [s]ummary" },
        { "<leader>To", function() require("neotest").output.open({ enter = true, auto_close = true }) end, desc = "[t]est [o]utput" },
        { "<leader>TO", function() require("neotest").output_panel.toggle() end, desc = "[t]est [O]utput panel" },
        { "<leader>Tt", function() require("neotest").run.stop() end, desc = "[t]est [t]erminate" },
        { "<leader>Td", function() require("neotest").run.run({ suite = false, strategy = "dap" }) end, desc = "Debug nearest test" },
      },
  },
  {
    "rcarriga/nvim-dap-ui",
    lazy = true,
    event = "BufRead",
    dependencies = {
      { "mfussenegger/nvim-dap", lazy = true },
      { "nvim-neotest/nvim-nio", lazy = true },
      {
        "theHamsta/nvim-dap-virtual-text",
        opts = {
          virt_text_win_col = 80,
        },
      },
    },
    config = function()
      require("pcode.user.dapui")
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
  {
    "jay-babu/mason-nvim-dap.nvim",
    lazy = true,
    event = "BufRead",
    dependencies = { "williamboman/mason.nvim", "mfussenegger/nvim-dap" },
    config = function()
      require("mason-nvim-dap").setup({
        automatic_installation = true,
        automatic_setup = true,
        handlers = {},
        ensure_installed = { "delve" },
      })
    end,
  },
}
