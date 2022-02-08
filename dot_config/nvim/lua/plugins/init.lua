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
            config = function() require('plugins.dashboard') end
        }

        use {
            'windwp/nvim-autopairs',
            after = 'nvim-cmp',
            config = function() require('plugins.autopairs') end
        }

        use {
            'numToStr/Comment.nvim',
            config = function() require('Comment').setup() end
        }

        use {
            'hrsh7th/nvim-cmp',
            requires = {
                'hrsh7th/cmp-buffer', 'hrsh7th/cmp-cmdline',
                'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-path',
                'saadparwaiz1/cmp_luasnip', 'L3MON4D3/LuaSnip'
            },
            config = function() require('plugins.cmp') end
        }

        use {'is0n/fm-nvim', config = function() require('plugins.lf') end}

        use {
            'lewis6991/gitsigns.nvim',
            requires = {'nvim-lua/plenary.nvim'},
            config = function() require('plugins.gitsigns') end
        }

        use {
            'phaazon/hop.nvim',
            branch = 'v1',
            requires = {'folke/which-key.nvim'},
            config = function() require('plugins.hop') end
        }

        use { 'https://github.com/kdheepak/lazygit.nvim' }

        use {
            'neovim/nvim-lspconfig',
            requires = {'folke/which-key.nvim', 'hrsh7th/nvim-cmp'},
            config = function() require('plugins.lsp') end
        }

        use {'williamboman/nvim-lsp-installer'}

        use {
            'sbdchd/neoformat',
            config = function() require('plugins.neoformat') end
        }

        use {
            'vhyrro/neorg',
            requires = {'nvim-lua/plenary.nvim', 'nvim-neorg/neorg-telescope'},
            config = function() require('plugins.neorg') end
        }

        use {
            'blackCauldron7/surround.nvim',
            config = function()
                require('surround').setup {mappings_style = "surround"}
            end
        }

        use {'gcmt/taboo.vim'}

        use {'godlygeek/tabular'}

        use {
            'nvim-telescope/telescope.nvim',
            requires = {'nvim-lua/plenary.nvim', 'cljoly/telescope-repo.nvim'},
            config = function() require('plugins.telescope') end
        }

        use {
            'nvim-treesitter/nvim-treesitter',
            run = ':TSUpdate',
            config = function() require('plugins.treesitter') end
        }

        use {
            "folke/trouble.nvim",
            requires = "kyazdani42/nvim-web-devicons",
            config = function() require("trouble").setup {} end
        }

        -- Key Maps!
        use {
            'folke/which-key.nvim',
            config = function() require('plugins.which-key') end
        }

        use {
            'folke/zen-mode.nvim',
            config = function() require('plugins.zen-mode') end
        }

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
