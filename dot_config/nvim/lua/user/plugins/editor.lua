-- Editor here is for plugins that provide more of an IDE-like experience
-- Got the naming from LazyVim
return {
  -- Editorconfig integration
  { 'gpanders/editorconfig.nvim' },

  -- Git
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",         -- required
      "nvim-telescope/telescope.nvim", -- optional
    },
    config = true
  },
  {
    "f-person/git-blame.nvim",
    event = "VeryLazy",
    opts = {
      enabled = false,
    },
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
