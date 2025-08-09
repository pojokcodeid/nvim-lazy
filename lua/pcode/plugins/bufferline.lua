return {
  "willothy/nvim-cokeline",
  event = { "BufRead", "BufNewFile" },
  opts = function()
    local truncate_text = function(text, max_length)
      if #text > max_length then
        return text:sub(1, max_length) .. "..."
      else
        return text
      end
    end

    local yellow = vim.g.terminal_color_3
    local hlgroups = require("cokeline.hlgroups")
    local hl_attr = hlgroups.get_hl_attr
    return {
      sidebar = {
        filetype = { "NvimTree", "neo-tree" },
        components = {
          {
            text = " ",
            fg = hl_attr("CursorLine", "bg"),
            bg = hl_attr("Normal", "bg"),
          },

          {
            text = " Explorer                  ",
            fg = yellow,
            bg = function()
              return hl_attr("CursorLine", "bg")
            end,
            bold = true,
          },
          {
            text = "",
            fg = hl_attr("CursorLine", "bg"),
            bg = hl_attr("Normal", "bg"),
          },
        },
      },
      default_hl = {
        fg = function(buffer)
          return buffer.is_focused and hl_attr("Normal", "fg") or hl_attr("Comment", "fg")
        end,
        bg = function(buffer)
          return buffer.is_focused and hl_attr("CursorLine", "bg") or hl_attr("Normal", "bg")
        end,
      },
      components = {
        {
          text = "｜",
          fg = hl_attr("Comment", "fg"),
          bg = hl_attr("Normal", "bg"),
        },
        {
          text = "",
          fg = function(buffer)
            return buffer.is_focused and hl_attr("CursorLine", "bg") or hl_attr("Normal", "bg")
          end,
          bg = hl_attr("Normal", "bg"),
        },
        {
          text = function(buffer)
            return buffer.devicon.icon
          end,
          fg = function(buffer)
            return buffer.devicon.color
          end,
        },
        {
          text = " ",
        },
        {
          text = function(buffer)
            return truncate_text(buffer.filename, 12) .. " "
          end,
          style = function(buffer)
            return buffer.is_focused and "bold" or nil
          end,
          italic = function(buffer)
            return buffer.is_focused and true or nil
          end,
        },
        {
          text = "󰅖",
          delete_buffer_on_left_click = true,
        },
        {
          text = "",
          fg = function(buffer)
            return buffer.is_focused and hl_attr("CursorLine", "bg") or hl_attr("Normal", "bg")
          end,
          bg = hl_attr("Normal", "bg"),
        },
      },
    }
  end,
  keys = {
    { "<leader>b", "", desc = "  Buffers", mode = "n" },
    {
      "<Leader>bp",
      "<Plug>(cokeline-switch-prev)",
      desc = "Focus Previous buffer",
      mode = "n",
    },
    {
      "<Leader>bn",
      "<Plug>(cokeline-switch-next)",
      desc = "Focus next buffer",
      mode = "n",
    },
    {
      "<leader>bb",
      function()
        require("telescope.builtin").buffers(require("telescope.themes").get_dropdown({ previewer = false }))
      end,
      desc = "All Buffer",
      mode = "n",
    },
    {
      "<leader>bc",
      function()
        require("pcode.user.buffer").bufremove()
      end,
      desc = "Close current buffer",
      mode = "n",
    },
    {
      "<S-Tab>",
      "<Plug>(cokeline-focus-prev)",
      desc = "Focus previous buffer",
      mode = "n",
    },
    {
      "<Tab>",
      "<Plug>(cokeline-focus-next)",
      desc = "Focus buffer Next",
      mode = "n",
    },
    {
      "<S-PageUp>",
      "<Plug>(cokeline-switch-prev)",
      desc = "Switch to previous buffer",
      mode = "n",
    },
    {
      "<S-PageDown>",
      "<Plug>(cokeline-switch-next)",
      desc = "Switch to next buffer",
      mode = "n",
    },
    {
      "<S-t>",
      function()
        require("pcode.user.buffer").bufremove()
      end,
      desc = "Close Current Buffer",
      mode = "n",
    },
  },
}
