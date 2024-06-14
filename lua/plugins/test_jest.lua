local M = {}
local config_file = pcode.jest_config or "jest.config.ts"
if pcode.jest then
  M = {
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
            jestCommand = pcode.jest_command or "npm test -- ",
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
  }
end

return M
