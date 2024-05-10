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
    config = function()
      require('mkdnflow').setup({
        modules = {
          cmp = true,
          yaml = true,
        },
        links = {
          conceal = true,
        }
      })
    end
  }
}
