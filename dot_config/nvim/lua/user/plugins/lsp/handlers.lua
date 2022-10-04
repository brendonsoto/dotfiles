local M = {}

M.on_attach = function(client, bufnr)
  -- TODO: refactor this into a method that checks if string in list
  if client.name == "tsserver" then
    client.server_capabilities.document_formatting = false
  end
  require('illuminate').on_attach(client)
  require('aerial').on_attach(client, bufnr)
end

-- Setup capabilities using default vim func & cmp
local client_capabilities = vim.lsp.protocol.make_client_capabilities()

M.capabilities = require('cmp_nvim_lsp').update_capabilities(client_capabilities)

return M
