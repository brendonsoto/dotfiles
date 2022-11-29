local cmp = require('cmp')

cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end
    },
    mapping = cmp.mapping.preset.insert({
        ['<c-b>'] = cmp.mapping.scroll_docs(-4),
        ['<c-f>'] = cmp.mapping.scroll_docs(4),
        ['<c-space>'] = cmp.mapping.complete(),
        ['<c-e>'] = cmp.mapping.abort(),
        ['<cr>'] = cmp.mapping.confirm({
            -- behavior = cmp.ConfirmBehavior.Insert,
            select = false -- Explicitly require confirming selection
        })
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
    }, {
        -- Buffer in its own group as a fallback. See cmp.config.sources
        { name = 'buffer', keyword_length = 5 },
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
    }
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
