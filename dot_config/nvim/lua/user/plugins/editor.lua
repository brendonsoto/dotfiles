-- Editor here is for plugins that provide more of an IDE-like experience
-- Got the naming from LazyVim
return {
  -- Editorconfig integration
  { 'gpanders/editorconfig.nvim' },

  -- File Explorer
  {
    'is0n/fm-nvim',
    opts = {
      ui = {
        -- Border around floating window
        border = "double", -- opts: 'rounded'; 'double'; 'single'; 'solid'; 'shawdow'

        -- Percentage (0.8 = 80%)
        height = 1,
        width = 1,
      }
    },
    keys = {
      {
        '<leader>fm',
        function()
          -- This is to cover if a path has spaces in it
          local path = vim.fn.printf(
            '"%s"',
            vim.fn.fnameescape(vim.fn.expand('%:p:h'))
          )
          vim.cmd({ cmd = 'Xplr', args = { path } })
        end,
        'n',
        desc = 'File Manager',
      },
    },
  },

  -- Git
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",         -- required
      "nvim-telescope/telescope.nvim", -- optional
    },
    config = true
  },

  -- Highlighting other uses of the word under cursor
  { 'RRethy/vim-illuminate' },

  -- Named tabs!!
  { 'gcmt/taboo.vim' },

  -- Telescope!!
  {
    'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    version = false, -- telescope did only one release, so use HEAD for now
  },
  {
    'crispgm/telescope-heading.nvim',
  },
}
