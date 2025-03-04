-- cmp at top, luasnip at bottom
-- the two aren't in separated files since luasnip's referenced in cmp

-- CMP
local cmp = require('cmp') -- cmp = nvim-cmp


-- For use in `cmp.setup.formatting.format` for contexts where formatting does
-- not make sense (e.g. search, commandline)
local function remove_formatting(entry, vim_item)
  vim_item.kind = ''
  return vim_item
end

local function confirm_active(fallback)
  if cmp.visible() and cmp.get_active_entry() then
    cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
  else
    fallback()
  end
end

cmp.setup({
  completion = {
    autocomplete = false,
  },
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end
  },
  mapping = {
  -- navigating through the list of options
  -- derived from the source code
  ['<c-n>'] = function()
    if cmp.visible() then
      cmp.select_next_item({ behavior = cmp.ConfirmBehavior.Select })
    else
      cmp.complete()
    end
  end,
  ['<c-p>'] = function()
    if cmp.visible() then
      cmp.select_prev_item({ behavior = cmp.ConfirmBehavior.Select })
    else
      cmp.complete()
    end
  end,
  -- 'docs' here refers to docs in the completion menu
  -- ['<c-b>'] = cmp.mapping.scroll_docs(-4),
  -- ['<c-f>'] = cmp.mapping.scroll_docs(4),
  -- 'complete' as in "show the completion menu"
  ['<c-space>'] = cmp.mapping.complete(),
  ['<c-e>'] = cmp.mapping.abort(),
  -- only apply whatever is selected
  ['<CR>'] = cmp.mapping({
    i = confirm_active,
    s = cmp.mapping.confirm({ select = true }),
  }),
  -- apply whatever the top option is
  ['<c-y>'] = cmp.mapping.confirm({ select = true }),
},
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer' },
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
})

local command_line_mapping = {
  ['<C-n>'] = {
    c = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end,
  },
  ['<C-p>'] = {
    c = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end,
  },
  ['<C-e>'] = {
    c = cmp.mapping.abort(),
  },
  ['<C-y>'] = {
    c = cmp.mapping.confirm({ select = true }),
  },
  ['<CR>'] = {
    c = confirm_active
  }
}

-- Use buffer source for `/`.
-- This says "when using the '/' command, only pull from what's in the buffer"
cmp.setup.cmdline('/', {
  formatting = {
    format = remove_formatting
  },
  -- derived from the source code
  mapping = command_line_mapping,
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':'.
cmp.setup.cmdline(':', {
  formatting = {
    format = remove_formatting
  },
  mapping = command_line_mapping,
  sources = cmp.config.sources({
    { name = 'path' },
    { name = 'cmdline' }
  }),
  matching = { disallow_symbol_nonprefix_matching = false }
})

-- Markdown setup
cmp.setup.filetype('markdown', {
  sources = cmp.config.sources({
    { name = 'mkdnflow' },
    { name = 'buffer' },
    { name = 'path' },
  })
})

cmp.setup.filetype('lua', {
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'nvim_lua' },
    { name = 'luasnip' },
    { name = 'buffer' },
  }),
})


-- LUASNIP
local ls = require('luasnip')
local vks = vim.keymap.set

vks({ 'i', 's' }, '<c-j>', function() ls.jump(1) end, { silent = true })
vks({ 'i', 's' }, '<c-k>', function() ls.jump(-1) end, { silent = true })
