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
            after = {'nvim-cmp'},
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

        use {
            'lukas-reineke/indent-blankline.nvim',
            config = function() require('plugins.indent-blankline') end
        }

        use {
            'https://github.com/kdheepak/lazygit.nvim',
            requires = {'nvim-cmp'},
            config = function()
                local is_wk_present, wk = pcall(require, "which-key")
                if (is_wk_present == false) then
                    print("which-key not found")
                    return
                end

                wk.register({g = {':Lazygit<cr>', 'Lazygit'}},
                            {prefix = '<leader>'})
            end
        }

        use {
            'williamboman/nvim-lsp-installer',
            'j-hui/fidget.nvim',
            'jose-elias-alvarez/nvim-lsp-ts-utils',
            'simrat39/rust-tools.nvim',
            {
                'neovim/nvim-lspconfig',
                requires = {'hrsh7th/nvim-cmp', 'folke/which-key.nvim'},
                config = function()
                    require('plugins.lsp')
                end
            }
        }

        use {
            'sbdchd/neoformat',
            config = function() require('plugins.neoformat') end
        }

        use {
            'vhyrro/neorg',
            requires = {'nvim-lua/plenary.nvim', 'nvim-neorg/neorg-telescope'},
            config = function() require('plugins.neorg') end
        }

        use {'machakann/vim-sandwich'}

        use {'gcmt/taboo.vim'}

        -- use {'godlygeek/tabular'}

        use {
            'nvim-telescope/telescope.nvim',
            requires = {'nvim-lua/plenary.nvim', 'cljoly/telescope-repo.nvim'},
            config = function() require('plugins.telescope') end
        }

        use {
            'nvim-treesitter/nvim-treesitter',
            requires = {
                'JoosepAlviste/nvim-ts-context-commentstring',
                'windwp/nvim-ts-autotag'
            },
            run = ':TSUpdate',
            config = function() require('plugins.treesitter') end
        }

        -- use {
        --     "folke/trouble.nvim",
        --     requires = {"kyazdani42/nvim-web-devicons"},
        --     config = function() require("trouble").setup {} end
        -- }

        -- Key Maps!
        use {
            'folke/which-key.nvim',
            config = function() require('plugins.which-key') end
        }

        use {
            'puremourning/vimspector',
            config = function() require('plugins.vimspector') end
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
