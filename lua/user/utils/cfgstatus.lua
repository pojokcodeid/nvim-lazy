local M = {}

M.cheack = function()
  local sts = false
  if pcode.active_javascript_config.active or false then
    sts = true
  elseif pcode.active_rust_config or false then
    sts = true
  elseif pcode.active_php_config or false then
    sts = true
  elseif pcode.active_golang_config or false then
    sts = true
  elseif pcode.active_python_config or false then
    sts = true
  elseif pcode.active_cpp_config or false then
    sts = true
  elseif pcode.active_java_config.active or false then
    sts = true
  elseif pcode.active_deno_config or false then
    sts = true
  elseif pcode.active_kotlin_config or false then
    sts = true
  elseif pcode.active_prisma_config or false then
    sts = true
  end
  return sts
end

return M
