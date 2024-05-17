-- Coding plugins here mean plugins for manipulating the text of the buffer
return {
  {
    'L3MON4D3/LuaSnip',
    -- follow latest release (2.3.0 as of 2024/05/14)
    version = 'v2.*',
    -- install jsregexp for lsp-snippet-transformations
    build = 'make install_jsregexp'
  },
  -- Completion
  {
    'hrsh7th/nvim-cmp',
    version = false,
    -- https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings
    event = { 'InsertEnter', 'CmdLineEnter' },
    dependencies = {
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lua', -- for autocompleting vim API
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
    },
  },
  -- Mini with a bunch of goodies
  {
    'echasnovski/mini.nvim',
    version = false,
  },
}
