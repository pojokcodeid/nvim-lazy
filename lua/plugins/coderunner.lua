--typescript = "deno run",
-- cpp="gcc $fileName -lstdc++ -o $fileNameWithoutExt && $fileNameWithoutExt"
local pyrun = "python -u"
if vim.fn.has("win32") == 0 then
  pyrun = "python3 -u"
end
local rfile = {
  java = "cd $dir && javac $fileName && java $fileNameWithoutExt",
  python = pyrun,
  typescript = "ts-node $dir/$fileName",
  rust = "cd $dir && rustc $fileName && $dir/$fileNameWithoutExt",
  cpp = "cd $dir && g++ $fileName -o $fileNameWithoutExt && $dir/$fileNameWithoutExt",
  scss = "sass $dir/$fileName $dir/$fileNameWithoutExt.css",
  javascript = 'node "$dir/$fileName"',
}

local runscript = pcode.coderunner or {}
rfile = vim.tbl_deep_extend("force", runscript, rfile)
return {
  "CRAG666/code_runner.nvim",
  lazy = true,
  cmd = { "RunCode", "RunFile", "RunProject", "RunClose" },
  opts = {
    -- put here the commands by filetype
    filetype = rfile,
    -- mode = "term",
    mode = "float",
    focus = true,
    startinsert = true,
    term = {
      --position = "vert",
      position = "bot",
      size = 50,
    },
    float = {
      -- Key that close the code_runner floating window
      close_key = "<ESC>",
      -- Window border (see ':h nvim_open_win')
      border = "rounded",

      -- Num from `0 - 1` for measurements
      height = 0.8,
      width = 0.8,
      x = 0.5,
      y = 0.5,

      -- Highlight group for floating window/border (see ':h winhl')
      border_hl = "FloatBorder",
      float_hl = "Normal",

      -- Transparency (see ':h winblend')
      blend = 0,
    },
  },
  config = function(_, opts)
    require("code_runner").setup(opts)
  end,
}
