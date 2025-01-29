return {
  {
    'JoosepAlviste/nvim-ts-context-commentstring',
    opts = {
      enable_autocmd = false,
    },
  },
  -- Commenting out until it's on the next version
  -- {
  --   'windwp/nvim-ts-autotag',
  --   opts = {
  --     enable_close = true,
  --     enable_rename = true,
  --     enable_close_on_slash = false,
  --   },
  -- },
  {
    'nvim-treesitter/nvim-treesitter',
    version = false,
    build = ':TSUpdate',
  },
}
