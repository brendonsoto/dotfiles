return {
  -- LSP stuff
  -- {
  --   'j-hui/fidget.nvim',
  --   config = function() require('fidget').setup({}) end
  -- },
  {
    'williamboman/mason.nvim',
    opts = {
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗"
        }
      }
    },
  },
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = {
      'williamboman/mason.nvim',
      'neovim/nvim-lspconfig',
    },
  },
  {
    'neovim/nvim-lspconfig',
  },
  { 'jose-elias-alvarez/null-ls.nvim' },
  -- lspsaga makes my experience slow ;_;
  -- {
  --   'nvimdev/lspsaga.nvim',
  --   -- event = 'BufRead',
  --   dependencies = {
  --     'nvim-tree/nvim-web-devicons',
  --     'nvim-treesitter/nvim-treesitter',
  --   },
  -- },
  {
    'simrat39/rust-tools.nvim',
  },
}
