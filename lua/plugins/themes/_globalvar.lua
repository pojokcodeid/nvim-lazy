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

if pcode.acive_rust_config then
  table.insert(pcode.mason_ensure_installed, "rust_analyzer")
  table.insert(pcode.unregister_lsp, "rust_analyzer")
end
return {}
