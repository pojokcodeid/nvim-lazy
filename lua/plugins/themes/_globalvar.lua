_G.switch = function(param, case_table)
  local case = case_table[param]
  if case then
    return case()
  end
  local def = case_table["default"]
  return def and def() or nil
end

_G.substring = function(text, key)
  local index, _ = string.find(text, key)
  if index then
    return true
  else
    return false
  end
end

_G.extract = function(text)
  local result = {}
  for substring in string.gmatch(text, "[^_]+") do
    table.insert(result, substring)
  end
  return result
end

_G.all_trim = function(s)
  return s:match("^%s*(.-)%s*$")
end

-- run if rust config true
if pcode.active_rust_config then
  table.insert(pcode.mason_ensure_installed, "rust_analyzer")
  table.insert(pcode.unregister_lsp, "rust_analyzer")
  table.insert(pcode.treesitter_ensure_installed, "rust")
end
-- run if javascript config true
if pcode.active_javascript_config.status then
  local lst_ts = { "html", "javascript", "typescript", "tsx", "css", "json", "jsonc" }
  for _, ts in pairs(lst_ts) do
    table.insert(pcode.treesitter_ensure_installed, ts)
  end
  for _, lsp in pairs({ "html", "cssls", "emmet_ls", "eslint", "jsonls", "tsserver" }) do
    table.insert(pcode.mason_ensure_installed, lsp)
  end
end
-- run if php config true
if pcode.active_php_config then
  local lst_ts = { "php", "phpdoc" }
  for _, ts in pairs(lst_ts) do
    table.insert(pcode.treesitter_ensure_installed, ts)
  end
  table.insert(pcode.mason_ensure_installed, "intelephense")
  table.insert(pcode.null_ls_ensure_installed, "phpcbf")
  table.insert(pcode.null_ls_ensure_installed, "phpcs")
end
-- run if golang config true
if pcode.active_golang_config then
  local lst_ts = { "go", "gomod", "gosum", "gotmpl", "gowork" }
  for _, ts in pairs(lst_ts) do
    table.insert(pcode.treesitter_ensure_installed, ts)
  end
  table.insert(pcode.mason_ensure_installed, "gopls")
  table.insert(pcode.null_ls_ensure_installed, "ast_grep")
  table.insert(pcode.null_ls_ensure_installed, "gofumpt")
end
-- run if python config true
if pcode.active_python_config then
  table.insert(pcode.treesitter_ensure_installed, "python")
  table.insert(pcode.mason_ensure_installed, "pyright")
  table.insert(pcode.null_ls_ensure_installed, "flake8")
  table.insert(pcode.null_ls_ensure_installed, "black")
  if vim.fn.has("win32") ~= 1 then
    pcode.nvim_dap = true
  end
end
-- run if cpp config true
if pcode.active_cpp_config then
  table.insert(pcode.treesitter_ensure_installed, "cpp")
  table.insert(pcode.treesitter_ensure_installed, "c")
  table.insert(pcode.mason_ensure_installed, "clangd")
  table.insert(pcode.null_ls_ensure_installed, "clang_format")
  table.insert(pcode.dap_ensure_installed, "codelldb")
  pcode.nvim_dap = true
end
-- run if java config true
if pcode.active_java_config then
  table.insert(pcode.treesitter_ensure_installed, "java")
  table.insert(pcode.mason_ensure_installed, "jdtls")
  table.insert(pcode.dap_ensure_installed, "javadbg")
  table.insert(pcode.unregister_lsp, "jdtls")
end
return {}
