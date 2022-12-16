local vks = require('user.utils').vks
local buf = vim.lsp.buf

local M = {}

M.on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  vks('n', 'gd', buf.definition, { desc = 'Go to definition' })
  vks('n', 'gD', buf.declaration, { desc = 'Go to declaration' })
  vks('n', 'gi', buf.implementation, { desc = 'Go to implementation' })
  -- vks('n', 'gr', buf.references, { desc = 'See references' })
  vks('n', 'gt', buf.type_definition, { desc = 'Go to type definition' })
  -- vks('n', 'K', buf.hover, { desc = 'Hover' })
  -- vks('n', '<leader>ca', buf.code_action, { desc = 'Code action' })
  vks('n', '<leader>fc', buf.formatting, { desc = 'format code' })
end

-- NOTE: Using this instead of cmp for now because cmp's capabilites don't work
-- M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities = require('cmp_nvim_lsp').default_capabilities()

return M
