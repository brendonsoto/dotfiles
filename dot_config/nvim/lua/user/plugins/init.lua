local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({
    'git', 'clone', '--depth', '1',
    'https://github.com/wbthomason/packer.nvim', install_path
  })
end

-- Packer and any colorscheme related packages at top
-- On how this is organized:
-- Plugins that are related by feature (e.g. plugins about writing) are grouped
-- I tried grouping plugins by those which requires other plugins
-- For plugins that need a certain plugin or is used in multiple configs (e.g
-- which-key), that plugin is at the top of the group
return require('packer').startup({
  function()
    -- Packer itself
    use 'wbthomason/packer.nvim'

    use {
      'numToStr/Comment.nvim',
      config = function() require('Comment').setup() end
    }

    -- Show something fun on empty screens
    use {
      'glepnir/dashboard-nvim',
      config = function() require('user.plugins.dashboard') end
    }

    use 'gpanders/editorconfig.nvim'

    -- Like Surround.vim
    use 'machakann/vim-sandwich'

    -- For naming tabs!
    use 'gcmt/taboo.vim'

    -- Key Maps!
    -- I use this in the configs of a bunch of other plugins so it's here near
    -- the top to indicate plugins after it may use this
    use {
      'folke/which-key.nvim',
      config = function() require('user.plugins.which-key') end
    }
    use {
      -- fm = file manager
      'is0n/fm-nvim',
      after = 'which-key.nvim',
      config = function() require('user.plugins.fm') end
    }
    use {
      -- Git goodies
      'lewis6991/gitsigns.nvim',
      after = 'which-key.nvim',
      config = function() require('user.plugins.gitsigns') end
    }
    use {
      'nvim-telescope/telescope.nvim',
      requires = 'nvim-lua/plenary.nvim',
      after = 'which-key.nvim',
      config = function() require('user.plugins.telescope') end
    }
    -- LSP stuff
    use {
      'j-hui/fidget.nvim',
      config = function() require('fidget').setup({}) end
    }
    use 'williamboman/mason.nvim'
    use 'williamboman/mason-lspconfig.nvim'
    use 'jose-elias-alvarez/null-ls.nvim'
    use 'RRethy/vim-illuminate'
    use {
      'neovim/nvim-lspconfig',
      after = {
        'mason.nvim',
        'mason-lspconfig.nvim',
        'null-ls.nvim',
        'vim-illuminate',
        'nvim-cmp',
        'which-key.nvim',
      },
      config = function()
        require('user.plugins.lsp')
      end
    }
    -- Writing and Organization related
    use {
      'preservim/vim-markdown',
      ft = 'markdown',
      requires = 'godlygeek/tabular',
      after = { 'which-key.nvim', 'telescope.nvim' },
      config = function() require('user.plugins.vim-markdown') end
    }
    use {
      'vhyrro/neorg',
      ft = 'norg',
      run = ':Neorg sync-parsers',
      requires = { 'nvim-lua/plenary.nvim', 'nvim-neorg/neorg-telescope' },
      after = { 'neorg-telescope', 'nvim-treesitter' },
      config = function() require('user.plugins.neorg') end
    }
    use {
      -- This is mostly for writing for centering the writing area
      'junegunn/goyo.vim',
      ft = { 'markdown', 'norg' },
    }

    -- NOTE: this should be before nvim-cmp
    use {
      'windwp/nvim-autopairs',
      config = function() require('user.plugins.autopairs') end
    }

    -- TODO: Add autopairs as a requirement and update cmp config
    use {
      'hrsh7th/nvim-cmp',
      requires = {
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-cmdline',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-path',
        'saadparwaiz1/cmp_luasnip',
        'L3MON4D3/LuaSnip',
        'neovim/nvim-lspconfig',
        'hrsh7th/cmp-omni'
      },
      config = function() require('user.plugins.cmp') end
    }

    use {
      'nvim-treesitter/nvim-treesitter',
      -- treesitter doesn't need these but they're used in the config, hence requires
      requires = {
        'JoosepAlviste/nvim-ts-context-commentstring',
        'windwp/nvim-ts-autotag'
      },
      run = ':TSUpdate',
      config = function() require('user.plugins.treesitter') end
    }
    use {
        -- Renders the markers to indicate indentation depths
        'lukas-reineke/indent-blankline.nvim',
        after = 'nvim-treesitter',
        config = function() require('user.plugins.indent-blankline') end
    }
    use {
      'folke/tokyonight.nvim',
      after = 'indent-blankline.nvim',
      config = function() vim.cmd([[colorscheme tokyonight]]) end
    }

    -- Automatically set up configuration after cloning packer.nvim
    if packer_bootstrap then require('packer').sync() end
  end,
})
