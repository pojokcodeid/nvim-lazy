local status_ok, code_runner = pcall(require, "code_runner")
if not status_ok then
  return
end
code_runner.setup({
  -- put here the commands by filetype
  filetype = {
    java = "cd $dir && javac $fileName && java $fileNameWithoutExt",
    python = "python3 -u",
    typescript = "deno run",
    javascript = "node $dir/$fileName",
    rust = "cd $dir && rustc $fileName && $dir/$fileNameWithoutExt",
    -- cpp="gcc $fileName -lstdc++ -o $fileNameWithoutExt && $fileNameWithoutExt"
    cpp = "g++ $fileName -o $fileNameWithoutExt && $dir/$fileNameWithoutExt",
    scss = "sass $dir/$fileName $dir/$fileNameWithoutExt.css",
  },
  mode = "term",
  focus = true,
  startinsert = true,
  term = {
    position = "vert",
    size = 50,
  },
})
