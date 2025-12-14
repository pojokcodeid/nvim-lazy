local IN_WINDOWS = vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1
return {
  {
    "L3MON4D3/LuaSnip",
    event = "InsertEnter",
    version = "v2.*",
    dependencies = IN_WINDOWS and {
      "kmarius/jsregexp",
    } or {},
    build = IN_WINDOWS and "" or "make install_jsregexp",
    -- build = "make install_jsregexp",
    opts = {
      history = true,
      delete_check_events = "TextChanged",
    },
    -- stylua: ignore
    keys = {
      { "<tab>",   function() require("luasnip").jump(1) end,  mode = "s" },
      { "<s-tab>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
    },
  },
  {
    "hrsh7th/nvim-cmp",
    version = false, -- last release is way too old
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lua",
      "xzbdmw/colorful-menu.nvim",
      "lukas-reineke/cmp-rg",
    },
    opts = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      local check_backspace = function()
        local col = vim.fn.col(".") - 1
        return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
      end

      return {
        completion = {
          completeopt = "menu,menuone,noinsert",
        },
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expandable() then
              luasnip.expand()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif check_backspace() then
              fallback()
            else
              fallback()
            end
          end, {
            "i",
            "s",
          }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, {
            "i",
            "s",
          }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
          { name = "nvim_lua" },
          { name = "rg" },
        }),
        formatting = {
          fields = { "kind", "abbr", "menu" },
          format = function(entry, vim_item)
            vim_item.menu = vim.api.nvim_get_mode().mode == "c" and "" or all_trim(vim_item.kind)
            vim_item.kind = string.format("%s", all_trim(require("pcode.user.icons")["kind2"][vim_item.kind]))

            local original_notify = vim.notify
            vim.notify = function(msg, level, opts)
              if type(msg) == "string" and msg:match("has new line character, please open an issue") then
                return
              end
              original_notify(msg, level, opts)
            end

            local ok, highlights_info = pcall(require("colorful-menu").cmp_highlights, entry)
            if ok and highlights_info ~= nil then
              vim_item.abbr_hl_group = highlights_info.highlights

              -- ambil nama group hilightnya saja
              -- eg. "@parameter"
              local var_hilight = highlights_info.highlights[1][1]
              local id = vim.fn.hlID(var_hilight)

              local var_out = "@tag"
              -- cek apakah hilight terdefinisi
              if id ~= 0 then
                var_out = var_hilight
              else
                var_out = var_hilight:match("([^%.]+)")
              end

              vim_item.menu_hl_group = var_out
              -- vim.notify(var_out)
            else
              vim_item.abbr_hl_group = "CmpItemAbbr"
              vim_item.menu_hl_group = "CmpItemAbbr"
            end
            return vim_item
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        experimental = {
          ghost_text = false,
          native_menu = false,
        },
      }
    end,
  },
  {
    "rafamadriz/friendly-snippets",
    event = "InsertEnter",
    lazy = true,
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
      require("pcode.user.snippets")
    end,
  },
}
