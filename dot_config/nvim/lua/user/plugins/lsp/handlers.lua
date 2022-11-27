local M = {}

M.on_attach = function(client, bufnr)
  -- TODO: refactor this into a method that checks if string in list
  if client.name == "tsserver" then
    client.server_capabilities.document_formatting = false
  end
end

M.capabilities = require('cmp_nvim_lsp').default_capabilities()

return M
