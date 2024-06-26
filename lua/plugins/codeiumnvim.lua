if pcode.codeium_nvim then
  return {
    -- codeium cmp source
    {
      "nvim-cmp",
      dependencies = {
        -- codeium
        {
          "Exafunction/codeium.nvim",
          cmd = "Codeium",
          build = ":Codeium Auth",
          opts = {
            enable_chat = true,
          },
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
else
  return {}
end
