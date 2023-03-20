return {
  -- indent guides for Neovim
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPost",
    opts = {
      -- char = "▏",
      char = "│",
      filetype_exclude = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy" },
      show_trailing_blankline_indent = false,
      show_current_context = false,
    },
    config = function(_, opts)
      -- Using the example from the README to have rainbow lines and treesitter suport
      vim.opt.list = true
      vim.opt.listchars:append("space:⋅")

      require("indent_blankline").setup(opts)
    end,
  },
}
