return {
  "monkoose/neocodeium",
  event = "VeryLazy",
  config = function()
    local uv = vim.uv
    local fn = vim.fn
    local pummenu_timer = assert(uv.new_timer())
    local cmp = require("cmp")
    local neocodeium = require("neocodeium")
    local renderer = require("neocodeium.renderer")
    local completer = require("neocodeium.completer")
    local function is_noselect()
      local completeopt = vim.o.completeopt
      return completeopt:find("noselect") and -1 or 0
    end

    local default_selected_compl = is_noselect()
    local selected_compl = default_selected_compl

    -- if cmp menu_opened then neocodeium clear
    cmp.event:on("menu_opened", function()
      neocodeium.clear()
    end)
    neocodeium.setup({
      filter = function()
        return not cmp.visible()
      end,
    })

    -- if cmp menu_is_closed then neocodeium activate
    cmp.event:on("menu_closed", function()
      local cur_selected = fn.complete_info({ "selected" }).selected
      if selected_compl == cur_selected then
        completer:initiate()
      else
        selected_compl = cur_selected
        completer:clear(true)
        renderer:display_label()
        pummenu_timer:stop()
        pummenu_timer:start(
          400,
          0,
          vim.schedule_wrap(function()
            if fn.pumvisible() == 1 then
              completer:initiate()
            end
          end)
        )
      end
    end)
    vim.keymap.set("i", "<C-g>", function()
      neocodeium.accept()
    end)
    vim.keymap.set("i", "<c-Down>", function()
      neocodeium.cycle()
    end)
    vim.keymap.set("i", "<c-Up>", function()
      require("neocodeium").cycle(-1)
    end)
    vim.keymap.set("i", "<c-x>", function()
      require("neocodeium").clear()
    end)
    -- create user command CodeiumDiasable
    vim.api.nvim_create_user_command("CodeiumDisable", function()
      require("neocodeium.commands").disable(true)
    end, {})
    -- create user command CodeiumEnable
    vim.api.nvim_create_user_command("CodeiumEnable", function()
      require("neocodeium.commands").enable()
    end, {})
  end,
}
