local M = {}
-- local disable = pcode.disable_null_ls or false
-- if require("user.utils.cfgstatus").cheack() then
--   disable = true
-- end
-- if disable then
-- M = {
--   "mfussenegger/nvim-lint",
--   event = { "BufReadPre", "BufNewFile" },
--   opts = function(_, opts)
--     local mason_reg = require("mason-registry")
--
--     opts.linters_by_ft = opts.linters_by_ft or {}
--
--     -- add diff langue vs filetype
--     local keymap = {
--       ["c++"] = "cpp",
--       ["c#"] = "cs",
--     }
--
--     -- add dif nvim-lint vs mason
--     local name_map = {
--       ["actionlint"] = "actionlint",
--       ["ansible_lint"] = "ansible_lint",
--       ["buf"] = "buf_lint",
--       ["buildifier"] = "buildifier",
--       ["cfn-lint"] = "cfn_lint",
--       ["checkstyle"] = "checkstyle",
--       ["clj-kondo"] = "clj_kondo",
--       ["cmakelint"] = "cmakelint",
--       ["codespell"] = "codespell",
--       ["cpplint"] = "cpplint",
--       ["cspell"] = "cspell",
--       ["curlylint"] = "curlylint",
--       ["djlint"] = "djlint",
--       ["erb-lint"] = "erb_lint",
--       ["eslint_d"] = "eslint_d",
--       ["flake8"] = "flake8",
--       ["gdtoolkit"] = "gdlint",
--       ["golangci-lint"] = "golangcilint",
--       ["hadolint"] = "hadolint",
--       ["jsonlint"] = "jsonlint",
--       ["ktlint"] = "ktlint",
--       ["luacheck"] = "luacheck",
--       ["markdownlint"] = "markdownlint",
--       ["mypy"] = "mypy",
--       ["phpcs"] = "phpcs",
--       ["phpmd"] = "phpmd",
--       ["phpstan"] = "phpstan",
--       ["proselint"] = "proselint",
--       ["pydocstyle"] = "pydocstyle",
--       ["pylint"] = "pylint",
--       ["revive"] = "revive",
--       ["rstcheck"] = "rstcheck",
--       ["rubocop"] = "rubocop",
--       ["ruff"] = "ruff",
--       ["selene"] = "selene",
--       ["shellcheck"] = "shellcheck",
--       ["sqlfluff"] = "sqlfluff",
--       ["standardrb"] = "standardrb",
--       ["stylelint"] = "stylelint",
--       ["solhint"] = "solhint",
--       ["tflint"] = "tflint",
--       ["tfsec"] = "tfsec",
--       ["trivy"] = "trivy",
--       ["vale"] = "vale",
--       ["vint"] = "vint",
--       ["vulture"] = "vulture",
--       ["yamllint"] = "yamllint",
--     }
--
--     -- add new mapping filetype
--     local addnew = {
--       ["typescriptreact"] = "eslint_d",
--       ["javascriptreact"] = "eslint_d",
--       ["javascript.jsx"] = "eslint_d",
--       ["typescript.tsx"] = "eslint_d",
--       ["vue"] = "eslint_d",
--       ["sevelte"] = "eslint_d",
--       ["astro"] = "eslint_d",
--     }
--
--     local ignore = {
--       ["php"] = "tlint",
--     }
--
--     -- local listtest = {}
--     for _, pkg in pairs(mason_reg.get_installed_packages()) do
--       for _, type in pairs(pkg.spec.categories) do
--         -- only act upon a Linter
--         if type == "Linter" then
--           -- finally add the linter to it's compatible filetype(s)
--           for _, ft in pairs(pkg.spec.languages) do
--             local ftl = string.lower(ft)
--             local ready = mason_reg.get_package(pkg.spec.name):is_installed()
--             if ready then
--               if keymap[ftl] ~= nil then
--                 ftl = keymap[ftl]
--               end
--
--               -- if substring(pkg.spec.name, "eslint") then
--               --   table.insert(listtest, ftl)
--               -- end
--
--               if name_map[pkg.spec.name] ~= nil then
--                 pkg.spec.name = name_map[pkg.spec.name]
--               end
--
--               -- add new mapping language
--               for key, value in pairs(addnew) do
--                 if value == pkg.spec.name then
--                   opts.linters_by_ft[key] = opts.linters_by_ft[key] or {}
--                   table.insert(opts.linters_by_ft[key], pkg.spec.name)
--                 end
--               end
--
--               if ignore[ftl] ~= pkg.spec.name then
--                 opts.linters_by_ft[ftl] = opts.linters_by_ft[ftl] or {}
--                 table.insert(opts.linters_by_ft[ftl], pkg.spec.name)
--               end
--             end
--           end
--         end
--       end
--     end
--     -- print(table.concat(listtest, ","))
--   end,
--   config = function(_, opts)
--     require("lint").linters_by_ft = opts.linters_by_ft
--   end,
-- }
-- end
return M
