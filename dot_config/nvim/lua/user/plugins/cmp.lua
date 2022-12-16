local cmp = require('cmp')
local compare = require('cmp.config.compare')

cmp.setup({
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
                neorg = '[Neorg]',
                nvim_lsp = '[LSP]',
                path = '[Path]',
            })[entry.source.name]
            return vim_item
        end
    },
    enabled = function()
      -- disable completion in comments
      local context = require 'cmp.config.context'
      -- keep command mode completion enabled when cursor is in a comment
      if vim.api.nvim_get_mode().mode == 'c' then
        return true
      else
        return not context.in_treesitter_capture("comment")
          and not context.in_syntax_group("Comment")
      end
    end,
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
})

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

-- Neorg setup
cmp.setup.filetype('norg', {
  sources = cmp.config.sources({
    { name = 'neorg' }
  }, {
    { name = 'buffer' }
  }, {
    { name = 'path' }
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
