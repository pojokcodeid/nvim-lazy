-- return {
--   "nvim-neotest/neotest",
--   dependencies = {
--     "mfussenegger/nvim-dap-python",
--     "antoinemadec/FixCursorHold.nvim",
--     "nvim-neotest/nvim-nio",
--     "nvim-neotest/neotest-go",
--   },
--   config = function()
--     local neotest_ns = vim.api.nvim_create_namespace("neotest")
--     vim.diagnostic.config({
--       virtual_text = {
--         format = function(diagnostic)
--           local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
--           return message
--         end,
--       },
--     }, neotest_ns)
--     require("neotest").setup({
--       -- your neotest config here
--       adapters = {
--         require("neotest-go"),
--       },
--     })
--   end,
--   -- stylua: ignore
--   -- test single test check
--   -- https://freshman.tech/snippets/go/run-specific-test/
--   keys = {
--     { "<leader>T","",desc="  Test"},
--     { "<leader>Tt", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run File" },
--     { "<leader>TT", function() require("neotest").run.run(vim.loop.cwd()) end, desc = "Run All Test Files" },
--     { "<leader>Tl", function() require("neotest").run.run_last() end, desc = "Run Last" },
--     { "<Leader>Ts", function() require("neotest").summary.toggle() end, desc = "Toggle Summary" },
--     { "<leader>To", function() require("neotest").output.open({ enter = true, auto_close = true }) end, desc = "Show Output" },
--     { "<Leader>TO", function() require("neotest").output_panel.toggle() end, desc = "Toggle Output Panel" },
--     { "<Leader>TS", function() require("neotest").run.stop() end, desc = "Stop" },
--   },
-- }

-- rujukan
-- https://github.com/fredrikaverpil/neotest-golang
local M = {}
if pcode.gotest then
  M = {
    "nvim-neotest/neotest",
    event = "VeryLazy",
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
  }
end

return M
