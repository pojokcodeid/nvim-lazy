local M = {}

M.run = function()
  local Popup = require("nui.popup")
  local event = require("nui.utils.autocmd").event

  -- Buat popup untuk menampilkan keymapping
  local popup = Popup({
    enter = true,
    focusable = true,
    border = {
      style = "rounded",
      text = {
        top = " Key Mappings ",
      },
    },
    position = "50%",
    size = {
      width = "80%",
      height = "80%",
    },
  })

  -- Daftar keymapping yang akan ditampilkan dalam dua kolom dengan section header
  -- stylua: ignore
  local key_mappings = {
    { "<leader>a  ", "Toggle Dashboard  ", "<leader>e ", "Toggle Explorer                     "},
    { "<leader>c  ", "Chat AI           ", "<leader>bb", ":Telescope buffers<CR>              "},
    { "           ", "                  ", "<leader>bd", ":bdelete<CR>                        "},
    { "           ", "                  ", "          ", "                                    "},
    { "Terminal   ", "                  ", "          ", "                                    "},
    { "<leader>tt ", ":ToggleTerm<CR>   ", "<leader>tn", ":ToggleTerm direction=horizontal<CR>"},
  }

  -- Fungsi untuk mengubah daftar keymapping menjadi format string
  local function format_key_mappings(mappings)
    local formatted = {}
    for _, mapping in ipairs(mappings) do
      table.insert(formatted, string.format("%-20s %-20s %-20s %s", mapping[1], mapping[2], mapping[3], mapping[4]))
    end
    return formatted
  end

  -- Set konten popup dengan daftar keymapping yang diformat
  vim.api.nvim_buf_set_lines(popup.bufnr, 0, -1, false, format_key_mappings(key_mappings))

  -- Mount popup
  popup:mount()

  -- Unmount popup ketika cursor meninggalkan buffer
  popup:on(event.BufLeave, function()
    popup:unmount()
  end)
end

return M
