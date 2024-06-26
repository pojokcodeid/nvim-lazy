return {
  "stevearc/conform.nvim",
  enabled = pcode.disable_null_ls or false,
  event = { "BufReadPre", "BufNewFile" },
  opts = function()
    local mason_reg = require("mason-registry")

    local formatters = {}
    local formatters_by_ft = {}

    -- add diff langue vs filetype
    local keymap = {
      ["c++"] = "cpp",
      ["c#"] = "cs",
    }

    -- add dif conform vs mason
    local name_map = {
      ["cmakelang"] = "cmake_format",
      ["deno"] = "deno_fmt",
      ["elm-format"] = "elm_format",
      ["gdtoolkit"] = "gdformat",
      ["nixpkgs-fmt"] = "nixpkgs_fmt",
      ["opa"] = "opa_fmt",
      ["php-cs-fixer"] = "php_cs_fixer",
      ["ruff"] = "ruff_format",
      ["sql-formatter"] = "sql_formatter",
      ["xmlformatter"] = "xmlformat",
    }

    local ignore = {
      ["php"] = "tlint",
    }

    for _, pkg in pairs(mason_reg.get_installed_packages()) do
      for _, type in pairs(pkg.spec.categories) do
        -- only act upon a formatter
        if type == "Formatter" then
          -- if formatter doesn't have a builtin config, create our own from a generic template
          if not require("conform").get_formatter_config(pkg.spec.name) then
            -- the key of the entry to this table
            -- is the name of the bare executable
            -- the actual value may not be the absolute path
            -- in some cases
            local bin = next(pkg.spec.bin)
            -- this should be replaced by a function
            -- that quieries the configured mason install path
            local prefix = vim.fn.stdpath("data") .. "/mason/bin/"

            formatters[pkg.spec.name] = {
              command = prefix .. bin,
              args = { "$FILENAME" },
              stdin = true,
              require_cwd = false,
            }
          end

          -- finally add the formatter to it's compatible filetype(s)
          for _, ft in pairs(pkg.spec.languages) do
            local ftl = string.lower(ft)
            local ready = mason_reg.get_package(pkg.spec.name):is_installed()
            if ready then
              if keymap[ftl] ~= nil then
                ftl = keymap[ftl]
              end
              if name_map[pkg.spec.name] ~= nil then
                pkg.spec.name = name_map[pkg.spec.name]
              end
              if ignore[ftl] ~= pkg.spec.name then
                formatters_by_ft[ftl] = formatters_by_ft[ftl] or {}
                table.insert(formatters_by_ft[ftl], pkg.spec.name)
              end
            end
          end
        end
      end
    end

    return {
      format_on_save = {
        lsp_fallback = true,
        timeout_ms = pcode.format_timeout_ms or 5000,
      },
      formatters = formatters,
      formatters_by_ft = formatters_by_ft,
    }
  end,
  config = function(_, opts)
    local conform = require("conform")
    conform.setup(opts)
    vim.keymap.set({ "n", "v" }, "<leader>lF", function()
      conform.format({
        lsp_fallback = true,
        async = false,
        timeout_ms = pcode.format_timeout_ms or 5000,
      })
    end, { desc = "Format file or range (in visual mode)" })
  end,
}
