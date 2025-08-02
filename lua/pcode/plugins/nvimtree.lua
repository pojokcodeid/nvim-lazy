local M = {}
if pcode.use_nvimtree then
  -- for fix error last close buffer
  vim.api.nvim_create_autocmd({ "QuitPre" }, {
    callback = function()
      vim.cmd("NvimTreeClose")
    end,
  })

  M = {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeFindFileToggle", "NvimTree", "NvimTreeOpen", "NvimTreeToggle", "NvimTreeFocus", "NvimTreeClose" },
    keys = {
      { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "󰙅 Explorer" },
    },
    opts = function(_, opts)
      local icons = require("pcode.user.icons")
      opts.auto_reload_on_write = false
      opts.disable_netrw = false
      opts.hijack_cursor = false
      opts.hijack_netrw = true
      opts.hijack_unnamed_buffer_when_opening = false
      opts.sync_root_with_cwd = true
      opts.sort = {
        sorter = "name",
        folders_first = true,
        files_first = false,
      }
      opts.root_dirs = {}
      opts.prefer_startup_root = false
      opts.sync_root_with_cwd = true
      opts.reload_on_bufenter = false
      opts.respect_buf_cwd = false
      opts.on_attach = "default"
      opts.select_prompts = false
      opts.update_focused_file = {
        enable = true,
        update_root = false,
      }
      opts.view = {
        adaptive_size = false,
        centralize_selection = true,
        width = 30,
        side = "left",
        preserve_window_proportions = false,
        number = false,
        relativenumber = false,
        signcolumn = "yes",
        float = {
          enable = false,
          quit_on_focus_loss = true,
          open_win_config = {
            relative = "editor",
            border = "rounded",
            width = 30,
            height = 30,
            row = 1,
            col = 1,
          },
        },
      }
      opts.renderer = {
        root_folder_label = false,
        highlight_git = true,
        indent_markers = { enable = true },
        -- indent_markers = {
        --		enable = true,
        --		inline_arrows = true,
        --		icons = {
        --			corner = "└",
        --			edge = "│",
        --			item = "│",
        --			none = " ",
        --		},
        --	},
        icons = {
          webdev_colors = true,
          git_placement = "before",
          padding = " ",
          symlink_arrow = " ➛ ",
          show = {
            file = true,
            folder = true,
            folder_arrow = true,
            git = true,
          },
          glyphs = {
            default = icons.ui.Text,
            symlink = icons.ui.FileSymlink,
            bookmark = icons.ui.BookMark,
            folder = {
              arrow_closed = icons.ui.ChevronShortRight,
              arrow_open = icons.ui.ChevronShortDown,
              default = icons.ui.Folder,
              open = icons.ui.FolderOpen,
              empty = icons.ui.EmptyFolder,
              empty_open = icons.ui.EmptyFolderOpen,
              symlink = icons.ui.FolderSymlink,
              symlink_open = icons.ui.FolderOpen,
            },
            git = {
              unstaged = icons.git.FileUnstaged,
              staged = icons.git.FileStaged,
              unmerged = icons.git.FileUnmerged,
              renamed = icons.git.FileRenamed,
              untracked = icons.git.FileUntracked,
              deleted = icons.git.FileDeleted,
              ignored = icons.git.FileIgnored,
            },
          },
        },
        special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
        symlink_destination = true,
      }
      opts.filters = {
        dotfiles = false,
        git_clean = false,
        no_buffer = false,
        custom = { "node_modules", "\\.cache", "\\.git" },
        exclude = {
          ".gitignore",
          ".prettierignore",
        },
      }
      opts.notify = {
        threshold = vim.log.levels.INFO,
      }
      opts.git = {
        enable = true,
        ignore = false,
        show_on_dirs = true,
        show_on_open_dirs = true,
        disable_for_dirs = {},
        timeout = 400,
      }
      return opts
    end,
    config = function(_, opts)
      if pcode.nvimtree_float then
        -- set nvimtree float view (default left side)
        opts.view = {
          adaptive_size = false,
          centralize_selection = true,
          side = "left",
          preserve_window_proportions = false,
          number = false,
          relativenumber = false,
          signcolumn = "yes",
          float = {
            enable = true,
            open_win_config = function()
              local screen_w = vim.opt.columns:get()
              ---@diagnostic disable-next-line: undefined-field
              local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
              local window_w = screen_w * 0.5
              local window_h = screen_h * 0.9
              local window_w_int = math.floor(window_w)
              local window_h_int = math.floor(window_h)
              local center_x = (screen_w - window_w) / 2
              ---@diagnostic disable-next-line: undefined-field
              local center_y = ((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get()
              return {
                border = "rounded",
                relative = "editor",
                row = center_y,
                col = center_x,
                width = window_w_int,
                height = window_h_int,
              }
            end,
          },
          width = function()
            return math.floor(vim.opt.columns:get() * 0.5)
          end,
        }
      end
      require("nvim-tree").setup(opts)
      local api = require("nvim-tree.api")
      api.events.subscribe(api.events.Event.FileCreated, function(file)
        vim.cmd("edit " .. file.fname)
      end)
    end,
  }
else
  local git_available = vim.fn.executable("git") == 1

  M = {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    event = { "BufRead", "BufNewFile" },
    cmd = "Neotree",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },

    deactivate = function()
      vim.cmd([[Neotree close]])
    end,

    keys = {
      {
        "<leader>e",
        "<CMD>Neotree toggle<CR>",
        desc = "Explorer",
      },
    },

    init = function()
      vim.api.nvim_create_autocmd("BufEnter", {
        group = vim.api.nvim_create_augroup("Neotree_start_directory", { clear = true }),
        desc = "Start Neo-tree with directory",
        once = true,
        callback = function()
          if not package.loaded["neo-tree"] then
            local stats = vim.uv.fs_stat(vim.fn.argv(0))
            if stats and stats.type == "directory" then
              require("neo-tree")
            end
          end
        end,
      })
    end,

    opts = {
      popup_border_style = "rounded",
      enable_git_status = git_available,
      auto_clean_after_session_restore = true,
      close_if_last_window = true,

      sources = vim.tbl_filter(function(src)
        return src ~= nil
      end, {
        "filesystem",
        "buffers",
        git_available and "git_status" or nil,
      }),

      source_selector = {
        winbar = true,
        content_layout = "center",
        sources = {
          { source = "filesystem", display_name = " 󰉓 Files " },
          { source = "buffers", display_name = "  Buffers " },
          { source = "git_status", display_name = "  Git " },
        },
      },

      window = {
        position = "left",
        width = 35,
      },

      default_component_configs = {
        icon = {
          folder_closed = "󰉋",
          folder_open = "󰝰",
          folder_empty = "󰉖",
        },
        git_status = {
          symbols = {
            unstaged = "󰄱",
            staged = "󰱒",
            added = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
            modified = "", -- or "", but this is redundant info if you use git_status_colors on the name
            deleted = "", -- this can only be used in the git_status source
            renamed = "󰁕", -- this can only be used in the git_status source
            -- Status type
            untracked = "",
            ignored = "",
            conflict = "",
          },
        },
      },

      filesystem = {
        filtered_items = {
          visible = false,
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_hidden = true,
          hide_by_name = {
            ".git",
            "node_modules",
          },
        },
      },

      buffers = {
        follow_current_file = {
          enabled = true,
          leave_dirs_open = false,
        },
        group_empty_dirs = true,
        show_unloaded = true,
      },
    },

    config = function(_, opts)
      require("neo-tree").setup(opts)

      vim.api.nvim_create_autocmd("TermClose", {
        pattern = "*lazygit*",
        callback = function()
          if package.loaded["neo-tree.sources.git_status"] then
            require("neo-tree.sources.git_status").refresh()
          end
        end,
      })

      -- vim.cmd [[
      --   highlight NeoTreeTabActive   guifg=#ffffff guibg=#5f87af
      --   highlight NeoTreeTabInactive guifg=#aaaaaa guibg=NONE
      --   highlight NeoTreeTabSeparatorActive guifg=#5f87af guibg=NONE
      --   highlight NeoTreeTabSeparatorInactive guifg=#3a3a3a guibg=NONE
      -- ]]
    end,
  }
end

return M
