return {
  -- codeium cmp source
  {
    "nvim-cmp",
    event = "BufReadPre",
    dependencies = {
      -- codeium
      {
        "Exafunction/windsurf.nvim",
        cmd = "Codeium",
        enabled = true,
        opts = {
          enable_chat = true,
          enable_cmp_source = true,
          virtual_text = {
            enabled = true,
            key_bindings = {
              accept = "<c-g>",
              next = "<c-Down>",
              prev = "<c-Up>",
            },
          },
        },
        config = function(_, opts)
          require("codeium").setup(opts)
        end,
      },
    },
    --@param opts cmp.ConfigSchema
    opts = function(_, opts)
      table.insert(opts.sources, 1, {
        name = "codeium",
        group_index = 1,
        priority = 100,
      })
    end,
  },
}
