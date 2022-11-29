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
        -- { name = 'omni' },
        -- { name = 'path' },
        -- { name = 'neorg' }
    }, {
        -- Buffer in its own group as a fallback. See cmp.config.sources
        { name = 'buffer', keyword_length = 5 },
    }),
    formatting = {
        -- adds text to say where the entry is coming from
        format = function(entry, vim_item)
            vim_item.menu = ({
                buffer = '[Buffer]',
                luasnip = '[LuaSnip]',
                nvim_lsp = '[LSP]',
            })[entry.source.name]
            return vim_item
        end
    }
})

-- Use buffer source for `/`.
-- cmp.setup.cmdline('/', {
--   mapping = cmp.mapping.preset.cmdline(),
--   sources = {
--     { name = 'buffer' }
--   }
-- })

-- Use cmdline & path source for ':'.
-- cmp.setup.cmdline(':', {
--   mapping = cmp.mapping.preset.cmdline(),
--   sources = cmp.config.sources({
--     { name = 'path' }
--   }, {
--     { name = 'cmdline' }
--   })
-- })
