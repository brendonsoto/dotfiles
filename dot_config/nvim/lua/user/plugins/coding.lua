-- Coding plugins here mean plugins for manipulating the text of the buffer
return {
  -- Completion
  {
    'hrsh7th/nvim-cmp',
    version = false,
    event = 'InsertEnter',
    dependencies = {
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
    },
    opts = function()
      local cmp = require('cmp')
      local compare = require('cmp.config.compare')

      -- For use in `cmp.setup.formatting.format` for contexts where formatting does
      -- not make sense (e.g. search, commandline)
      local function remove_formatting(entry, vim_item)
        vim_item.kind = ''
        return vim_item
      end

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

      return {
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
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
          ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
        }, {
          { name = 'buffer' },
        }, {
          { name = 'path' },
        }),
        formatting = {
          -- adds text to say where the entry is coming from
          format = function(entry, vim_item)
            vim_item.menu = ({
              buffer = '[Buffer]',
              luasnip = '[LuaSnip]',
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
        sorting = {
          -- priority_weight = 2,
          comparators = {
            compare.scopes,
            compare.offset,
            compare.recently_used,
            -- compare.exact,
            -- compare.score,
            -- compare.locality,
            -- compare.kind,
            -- compare.sort_text,
            -- compare.length,
            -- compare.order,
          },
        },
      }
    end,
  },

  -- Markdown
  {
    'preservim/vim-markdown',
    ft = 'markdown',
    config = function()
      local vks = require('user/utils').vks
      local g = vim.g

      g.vim_markdown_folding_disabled = 1 -- no auto-folds plz
      g.vim_markdown_no_default_key_mappings = 1 -- figured to set myself
      g.vim_markdown_conceal = 2
      g.vim_markdown_follow_anchor = 1 -- go-to link
      g.vim_markdown_frontmatter = 1 -- YAML frontmatter
      g.vim_markdown_strikethrough = 1 -- ~~strikethrough~~
      g.vim_markdown_auto_insert_bullets = 0 -- no auto-insert bullet points
      g.vim_markdown_new_list_item_indent = 0 -- no auto-indenting for lists

      -- Command for easy making markdown link
      local actions = require('telescope.actions')
      local action_state = require('telescope.actions.state')
      -- FIXME: `cd` into dir if path isn't path of files
      local make_markdown_link = function()
        require('telescope.builtin').find_files {
          prompt_title = "Link file",
          attach_mappings = function(prompt_bufnr, _)
            actions.select_default:replace(function()
              actions.close(prompt_bufnr)
              local selection = action_state.get_selected_entry()
              local filename = selection[1]
              local file_without_dashes = string.gsub(filename, "-", " ")
              local ext_indx = string.find(filename, "%.")
              local file_without_ext = string.sub(file_without_dashes, 0, ext_indx - 1)
              local md_link = string.format("[%s](./%s)", file_without_ext, filename)
              vim.api.nvim_put({ md_link }, "", false, true)
            end)
            return true
          end,
        }
      end

      local curr_buf = vim.api.nvim_get_current_buf()
      vks('n', '<CR>', '<Plug>Markdown_EditUrlUnderCursor', { desc = 'Edit link under cursor', buffer = curr_buf })
      vks('n', ']]', '<Plug>Markdown_MoveToNextHeader', { desc = 'Go to next header', buffer = curr_buf })
      vks('n', '[[', '<Plug>Markdown_MoveToPreviousHeader', { desc = 'Go to previous header', buffer = curr_buf })

      vks('n', '<leader>t', ':Toc<CR>', { desc = 'Table of Contents', buffer = curr_buf })
      vks('n', '<leader>it', ':InsertToc<CR>', { desc = 'Insert Table of Contents', buffer = curr_buf })
      vks('n', '<leader>ml', make_markdown_link, { desc = 'Make Markdown Link', buffer = curr_buf })
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

      require('mini.comment').setup()
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
      require('mini.starter').setup({
        header = function ()
          return require('user.dashboard-art').get_art()
        end
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

  -- Tabular
  { 'godlygeek/tabular' },
}
