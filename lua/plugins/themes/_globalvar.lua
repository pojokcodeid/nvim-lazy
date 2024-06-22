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
  table.insert(pcode.mason_ensure_installed, "tsserver")
end
return {}
