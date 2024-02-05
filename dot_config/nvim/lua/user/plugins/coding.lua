-- Coding plugins here mean plugins for manipulating the text of the buffer
return {
  -- Completion
  {
    'hrsh7th/nvim-cmp',
    version = false,
    event = 'InsertEnter',
    dependencies = {
      'dcampos/nvim-snippy',
      'dcampos/cmp-snippy',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
    },
    config = function()
      local cmp = require('cmp')
      -- local compare = require('cmp.config.compare')

      -- For use in `cmp.setup.formatting.format` for contexts where formatting does
      -- not make sense (e.g. search, commandline)
      local function remove_formatting(entry, vim_item)
        vim_item.kind = ''
        return vim_item
      end

      cmp.setup({
        snippet = {
          expand = function(args)
            require('snippy').expand_snippet(args.body)
          end
        },
        mapping = cmp.mapping.preset.insert({
          -- 'docs' here refers to docs in the completion menu
          ['<c-b>'] = cmp.mapping.scroll_docs(-4),
          ['<c-f>'] = cmp.mapping.scroll_docs(4),
          -- 'complete' as in "show the completion menu"
          ['<c-space>'] = cmp.mapping.complete({
            config = {
              sources = {
                { name = 'nvim_lsp' },
              }, {
                { name = 'buffer' },
              }
            }
          }),
          ['<c-e>'] = cmp.mapping.abort(),
          ['<c-CR>'] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = 'buffer' },
          { name = 'nvim_lsp' },
          { name = 'snippy' },
        }, {
          { name = 'path' },
        }),
        formatting = {
          -- adds text to say where the entry is coming from
          format = function(entry, vim_item)
            vim_item.menu = ({
              buffer = '[Buffer]',
              snippy = '[Snippy]',
              nvim_lsp = '[LSP]',
              path = '[Path]',
            })[entry.source.name]
            return vim_item
          end
        },
        -- enabled = function()
        --   -- disable completion in comments
        --   local context = require 'cmp.config.context'
        --   -- keep command mode completion enabled when cursor is in a comment
        --   if vim.api.nvim_get_mode().mode == 'c' then
        --     return true
        --   else
        --     return not context.in_treesitter_capture("comment")
        --   end
        -- end,

        -- Took from CMP's default config and rearranged
        -- sorting = {
        --   -- priority_weight = 2,
        --   comparators = {
        --     compare.scopes,
        --     compare.offset,
        --     compare.recently_used,
        --     -- compare.exact,
        --     -- compare.score,
        --     -- compare.locality,
        --     -- compare.kind,
        --     -- compare.sort_text,
        --     -- compare.length,
        --     -- compare.order,
        --   },
        -- },
      })

      -- Use buffer source for `/`.
      cmp.setup.cmdline('/', {
        formatting = {
          format = remove_formatting
        },
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
      })

      -- Use cmdline & path source for ':'.
      cmp.setup.cmdline(':', {
        formatting = {
          format = remove_formatting
        },
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
          { name = 'cmdline' }
        })
      })

      -- Markdown setup
      cmp.setup.filetype('markdown', {
        sources = cmp.config.sources({
          { name = 'buffer' }
        }, {
          { name = 'path' }
        })
      })
    end,
  },


  -- Mini with a bunch of goodies
  {
    'echasnovski/mini.nvim',
    version = false,
    config = function()
      require('mini.bracketed').setup({
        treesitter = { suffix = 'a', options = {} },
        indent = { suffix = '' },
      })
      local vks = vim.keymap.set
      vks('n', '[i', '<Cmd>lua MiniBracketed.indent("backward", { change_type = "less" })<CR>',
        { desc = 'Go to the previous indent level' })
      vks('n', '[I', '<Cmd>lua MiniBracketed.indent("backward", { change_type = "more" })<CR>',
        { desc = 'Go to the previous indent level' })
      vks('n', ']i', '<Cmd>lua MiniBracketed.indent("forward", { change_type = "less" })<CR>',
        { desc = 'Go to the previous indent level' })
      vks('n', ']I', '<Cmd>lua MiniBracketed.indent("forward", { change_type = "more" })<CR>',
        { desc = 'Go to the previous indent level' })

      require('mini.comment').setup({
        options = {
          custom_commentstring = function()
            return require('ts_context_commentstring').calculate_commentstring() or vim.bo.commentstring
          end,
        },
      })
      require('mini.indentscope').setup({
        draw = {
          delay = 50,
          animation = require('mini.indentscope').gen_animation.quadratic({
            easing = 'in',
            duration = 10,
            unit = 'step',
          })
        },
      })
      require('mini.pairs').setup()
      local starter = require('mini.starter')
      starter.setup({
        header = function ()
          return require('user.dashboard-art').get_art()
        end,
        items = {
          starter.sections.telescope(),
        }
      })
      require('mini.surround').setup({
        mappings = {
          add = 'sa',
          delete = 'sd',
          find = 'sf',
          find_left = 'sF',
          highlight = '', -- was interfering w/ split horiz + i don't use
          replace = 'sr',
          update_n_lines = '', -- i'm fine w/ default search range of 20 lines

          suffix_last = 'l', -- Suffix to search with "prev" method
          suffix_next = 'n', -- Suffix to search with "next" method
        }
      })
    end,
  },

  -- Tabular - I rarely use this
  -- { 'godlygeek/tabular' },
}
