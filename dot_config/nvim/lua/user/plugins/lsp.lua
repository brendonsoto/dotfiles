return {
  -- LSP stuff
  {
    'j-hui/fidget.nvim',
    config = function() require('fidget').setup({}) end
  },
  { 'williamboman/mason.nvim' },
  { 'williamboman/mason-lspconfig.nvim' },
  { 'jose-elias-alvarez/null-ls.nvim' },
  { 'RRethy/vim-illuminate' },
  {
    'neovim/nvim-lspconfig',
    -- config = function()
    --   require('user.plugins.lsp')
    -- end
  },

  {
    'glepnir/lspsaga.nvim',
    branch = 'main',
    opts = function()
      return {
        show_outline = {
          auto_enter = false,
          jump_key = '<CR>',
        },
      }
    end,
    config = function()
      local vks = require('user.utils').vks
      -- Lsp finder find the symbol definition implement reference
      -- if there is no implement it will hide
      -- when you use action in finder like open vsplit then you can
      -- use <C-t> to jump back
      vks('n', 'gh', '<cmd>Lspsaga lsp_finder<CR>', { desc = 'LSP finder', silent = true })

      -- Code action
      vks({ 'n', 'v' }, '<leader>ca', '<cmd>Lspsaga code_action<CR>', { desc = 'Code action', silent = true })

      -- Rename
      vks('n', 'gr', '<cmd>Lspsaga rename<CR>', { desc = 'LSP rename', silent = true })

      -- Peek Definition
      -- you can edit the definition file in this flaotwindow
      -- also support open/vsplit/etc operation check definition_action_keys
      -- support tagstack C-t jump back
      vks('n', 'gp', '<cmd>Lspsaga peek_definition<CR>', { desc = 'Peek definition', silent = true })

      -- Show line diagnostics
      vks('n', '<leader>cd', '<cmd>Lspsaga show_line_diagnostics<CR>', { silent = true })

      -- Show cursor diagnostic
      vks('n', '<leader>cd', '<cmd>Lspsaga show_cursor_diagnostics<CR>', { silent = true })

      -- Diagnsotic jump can use `<c-o>` to jump back
      vks('n', '[e', '<cmd>Lspsaga diagnostic_jump_prev<CR>', { silent = true })
      vks('n', ']e', '<cmd>Lspsaga diagnostic_jump_next<CR>', { silent = true })

      -- Only jump to error
      vks('n', '[E', function()
        require('lspsaga.diagnostic').goto_prev({ severity = vim.diagnostic.severity.ERROR })
      end, { silent = true })
      vks('n', ']E', function()
        require('lspsaga.diagnostic').goto_next({ severity = vim.diagnostic.severity.ERROR })
      end, { silent = true })

      -- Outline
      vks('n', '<leader>o', '<cmd>Lspsaga outline<CR>', { desc = 'LSP Outline', silent = true })

      -- Hover Doc
      vks('n', 'K', '<cmd>Lspsaga hover_doc<CR>', { silent = true })
    end,
  },

  {
    'simrat39/rust-tools.nvim',
    opts = function()
      local rt = require('rust-tools')
      return {
        server = {
          on_attach = function(_, bufnr)
            -- Hover actions
            vim.keymap.set('n', '<c-space>', rt.hover_actions.hover_actions,
              { buffer = bufnr, desc = '[Rust Tools] Hover actions' })
            -- Code action groups
            vim.keymap.set('n', '<leader>a', rt.code_action_group.code_action_group,
              { buffer = bufnr, desc = '[Rust Tools] Action groups' })
          end,

          settings = {
            ['rust-analyzer'] = {
              inlayHints = { locationLinks = false },
            },
          },
        },
      }
    end,
  },
}
