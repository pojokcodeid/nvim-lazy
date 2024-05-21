if vim.g.neovide then
  local opts = { noremap = true, silent = true }
  vim.g.neovide_input_use_logo = 1 -- enable use of the logo (cmd) key
  vim.keymap.set("n", "<c-s>", ":w<CR>", opts) -- Save
  vim.keymap.set("v", "<c-c>", '"+y', opts) -- Copy
  vim.keymap.set("n", "<c-v>", '"+P', opts) -- Paste normal mode
  vim.keymap.set("v", "<c-v>", '"+P', opts) -- Paste visual mode
  vim.keymap.set("x", "<c-v>", '"+P', opts) -- Paste visual mode
  vim.keymap.set("c", "<sc-v>", "<C-R>+", { noremap = true }) -- Paste command mode
  vim.keymap.set("i", "<c-v>", '<ESC>l"+Pli', opts) -- Paste insert mode
  vim.keymap.set(
    "n",
    "<c-/>",
    "<esc><cmd>lua require('Comment.api').toggle.linewise.current()<cr>$i<Right><leader>",
    opts
  )
  vim.keymap.set(
    "i",
    "<c-/>",
    "<esc><cmd>lua require('Comment.api').toggle.linewise.current()<cr>$i<Right><leader>",
    opts
  )
  vim.keymap.set("v", "<c-/>", "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>", opts)

  vim.o.guifont = "Hasklug_Nerd_Font:h15"
  vim.g.neovide_padding_top = 0
  vim.g.neovide_padding_bottom = 1
  vim.g.neovide_padding_right = 1
  vim.g.neovide_padding_left = 1

  -- config for transparent
  vim.g.neovide_transparency = 1
  vim.g.neovide_hide_mouse_when_typing = false
  vim.g.neovide_underline_automatic_scaling = false
  vim.g.neovide_refresh_rate_idle = 5
  vim.g.neovide_no_idle = true
  vim.g.neovide_remember_window_size = true
  vim.g.neovide_touch_drag_timeout = 0.17
  vim.g.neovide_show_border = false
  vim.g.neovide_theme = "auto"
  vim.g.neovide_confirm_quit = true
  vim.g.neovide_remember_window_size = true
  vim.g.neovide_cursor_smooth_blink = true
  -- animation config
  --vim.g.neovide_scroll_animation_length = 0.3
  --vim.g.neovide_cursor_animation_length = 0.13
  vim.g.neovide_cursor_trail_size = 0.8
  vim.g.neovide_cursor_antialiasing = true
  vim.g.neovide_cursor_animate_in_insert_mode = true
  vim.g.neovide_cursor_vfx_mode = "torpedo"

  vim.opt.linespace = 0
  vim.g.neovide_scale_factor = 1
  vim.opt.cmdheight = 0
  vim.opt.spell = false

  vim.g.neovide_window_blurred = true
  vim.g.neovide_floating_blur_amount_x = 2.0
  vim.g.neovide_floating_blur_amount_y = 2.0
  vim.g.neovide_floating_shadow = false
  vim.g.neovide_floating_z_height = 10
  vim.g.neovide_light_angle_degrees = 45
  vim.g.neovide_light_radius = 5
end

-- -- Allow clipboard copy paste in neovim
-- vim.g.neovide_input_use_logo = 1
-- vim.api.nvim_set_keymap("", "<c-v>", "+p<CR>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("!", "<c-v>", "<C-R>+", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("t", "<c-v>", "<C-R>+", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("v", "<c-v>", "<C-R>+", { noremap = true, silent = true })
