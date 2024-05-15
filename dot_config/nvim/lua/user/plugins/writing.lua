return {
  -- Goyo -- focus-ish zone
  {
    -- This is mostly for writing for centering the writing area
    'junegunn/goyo.vim',
  },
  {
    'lukas-reineke/headlines.nvim',
    dependencies = 'nvim-treesitter/nvim-treesitter',
    config = true,
  },
  {
    'jakewvincent/mkdnflow.nvim',
  }
}
