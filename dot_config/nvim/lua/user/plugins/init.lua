local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({
    'git', 'clone', '--depth', '1',
    'https://github.com/wbthomason/packer.nvim', install_path
  })
end

-- Packer and any colorscheme related packages at top
-- Rest are alphabetical (past the /)
return require('packer').startup({
  function()
    use 'wbthomason/packer.nvim'

    use {
      'folke/tokyonight.nvim',
      config = function() vim.cmd([[colorscheme tokyonight]]) end
    }

    use {
      'glepnir/dashboard-nvim',
      config = function() require('user.plugins.dashboard') end
    }

    use { 'gpanders/editorconfig.nvim' }

    use {
      'windwp/nvim-autopairs',
      after = { 'nvim-cmp' },
      config = function() require('user.plugins.autopairs') end
    }

    use {
      'numToStr/Comment.nvim',
      config = function() require('Comment').setup() end
    }

    use {
      'hrsh7th/nvim-cmp',
      requires = {
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-cmdline',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-path',
        'saadparwaiz1/cmp_luasnip',
        'L3MON4D3/LuaSnip',
        'nvim-lspconfig',
        'hrsh7th/cmp-omni'
      },
      config = function() require('user.plugins.cmp') end
    }

    use {
      'is0n/fm-nvim',
      requires = { 'folke/which-key.nvim' },
      config = function() require('user.plugins.lf') end
    }

    use { 'tpope/vim-fugitive' }

    use {
      'lewis6991/gitsigns.nvim',
      requires = { 'nvim-lua/plenary.nvim', 'folke/which-key.nvim' },
      config = function() require('user.plugins.gitsigns') end
    }

    use {
      'phaazon/hop.nvim',
      branch = 'v1',
      requires = { 'folke/which-key.nvim' },
      config = function() require('user.plugins.hop') end
    }

    use {
        'lukas-reineke/indent-blankline.nvim',
        config = function() require('user.plugins.indent-blankline') end
    }

    use {
      'j-hui/fidget.nvim',
      config = function()
        require('fidget').setup({})
      end
    }

    use {
      'neovim/nvim-lspconfig',
      requires = {
        'nvim-lua/plenary.nvim',
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'jose-elias-alvarez/null-ls.nvim',
        'RRethy/vim-illuminate',
        'hrsh7th/nvim-cmp',
        'folke/which-key.nvim',
        'nvim-neorg/neorg-telescope',
      },
      config = function()
        require('user.plugins.lsp')
      end
    }

    use {
      'preservim/vim-markdown',
      requires = { 'godlygeek/tabular', 'folke/which-key.nvim' },
      config = function() require('user.plugins.vim-markdown') end
    }

    use {
      'vhyrro/neorg',
      -- THIS IS ONLY UNTIL either neovim 0.8 is out or an alternative to 0.0.13 breaking on neovim 0.7 is known
      tag = '0.0.12',
      requires = { 'nvim-lua/plenary.nvim', 'nvim-neorg/neorg-telescope' },
      config = function() require('user.plugins.neorg') end
    }

    use { 'machakann/vim-sandwich' }

    use { 'gcmt/taboo.vim' }

    use {
      'nvim-telescope/telescope.nvim',
      requires = {
        'nvim-lua/plenary.nvim',
        'cljoly/telescope-repo.nvim',
        'folke/which-key.nvim'
      },
      config = function() require('user.plugins.telescope') end
    }

    use {
      'nvim-treesitter/nvim-treesitter',
      requires = {
        'JoosepAlviste/nvim-ts-context-commentstring',
        'windwp/nvim-ts-autotag'
      },
      run = ':TSUpdate',
      config = function() require('user.plugins.treesitter') end
    }

    -- Key Maps!
    use {
      'folke/which-key.nvim',
      config = function() require('user.plugins.which-key') end
    }

    use { 'ziglang/zig.vim' }

    -- Automatically set up configuration after cloning packer.nvim
    if packer_bootstrap then require('packer').sync() end
  end,
  config = {
    display = {
      open_fn = function()
        return require('packer.util').float({border = 'rounded'})
      end
    }
  }
})
