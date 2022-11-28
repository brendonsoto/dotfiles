local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({
    'git', 'clone', '--depth', '1',
    'https://github.com/wbthomason/packer.nvim', install_path
  })
end

-- Packer and any colorscheme related packages at top
-- NOTE: Tried sequencing using `after` and `requires` to an extent.
-- Was confusing. Maybe don't do that again?
return require('packer').startup({
  function()
    -- Packer itself
    use 'wbthomason/packer.nvim'

    -- So much relies on plenary so putting it near top
    use 'nvim-lua/plenary.nvim'

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

    -- Treesitting
    use 'JoosepAlviste/nvim-ts-context-commentstring'
    use 'windwp/nvim-ts-autotag'
    use {
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate',
      config = function() require('user.plugins.treesitter') end
    }
    use {
        -- Renders the markers to indicate indentation depths
        'lukas-reineke/indent-blankline.nvim',
        config = function() require('user.plugins.indent-blankline') end
    }
    use {
      -- COLORS!!! After indent-blankline so those are colored too
      'folke/tokyonight.nvim',
      config = function() vim.cmd([[colorscheme tokyonight]]) end
    }

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
      config = function() require('user.plugins.fm') end
    }
    use {
      -- Git goodies
      'lewis6991/gitsigns.nvim',
      config = function() require('user.plugins.gitsigns') end
    }
    use {
      'nvim-telescope/telescope.nvim',
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
      config = function()
        require('user.plugins.lsp')
      end
    }

    -- COMPLETIONNNN
    -- NOTE: this should be before nvim-cmp
    use {
      'windwp/nvim-autopairs',
      config = function() require('user.plugins.autopairs') end
    }
    use 'L3MON4D3/LuaSnip'
    use 'saadparwaiz1/cmp_luasnip'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-omni'
    use 'hrsh7th/cmp-path'
    use {
      'hrsh7th/nvim-cmp',
      config = function() require('user.plugins.cmp') end
    }

    -- Writing and Organization related
    use 'godlygeek/tabular'
    use {
      'preservim/vim-markdown',
      ft = 'markdown',
      config = function() require('user.plugins.vim-markdown') end
    }
    use 'nvim-neorg/neorg-telescope'
    use {
      'vhyrro/neorg',
      ft = 'norg',
      config = function() require('user.plugins.neorg') end
    }
    use {
      -- This is mostly for writing for centering the writing area
      'junegunn/goyo.vim',
      ft = { 'markdown', 'norg' },
    }

    -- Automatically set up configuration after cloning packer.nvim
    if packer_bootstrap then require('packer').sync() end
  end,
})
