local vks = require('user.utils').vks
local saga = require('lspsaga')

saga.init_lsp_saga({
  show_outline = {
    auto_enter = false,
    jump_key = '<CR>',
  },
})

-- Lsp finder find the symbol definition implement reference
-- if there is no implement it will hide
-- when you use action in finder like open vsplit then you can
-- use <C-t> to jump back
vks('n', 'gh', '<cmd>Lspsaga lsp_finder<CR>', { desc = 'LSP finder', silent = true })

-- Code action
vks({'n','v'}, '<leader>ca', '<cmd>Lspsaga code_action<CR>', { desc = 'Code action', silent = true })

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
vks('n','<leader>o', '<cmd>LSoutlineToggle<CR>', { desc = 'LSP Outline', silent = true })

-- Hover Doc
vks('n', 'K', '<cmd>Lspsaga hover_doc<CR>', { silent = true })
