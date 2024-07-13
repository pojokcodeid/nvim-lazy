return {
  "numToStr/Comment.nvim",
  lazy = true,
  opts = function()
    return {
      pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
    }
  end,
  keys = {
    {
      "<leader>/",
      function()
        require("Comment.api").toggle.linewise.current()
      end,
      desc = "󰆈 Coment line",
      mode = "n",
    },
    {
      "<leader>/",
      "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>",
      desc = "󰆈 Coment line",
      mode = "v",
    },
  },
  config = function(_, opts)
    require("Comment").setup(opts)
  end,
}
