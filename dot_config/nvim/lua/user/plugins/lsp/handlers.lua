local M = {}

-- Use which-key to setup keymaps
local setup_keymaps = function(_, bufnr)
  local wk = require('which-key')
  local buf = vim.lsp.buf
  local diagnostic = vim.diagnostic

  wk.register({
    g = {
      d = {buf.definition, "Go to definition"},
      D = {buf.declaration, "Go to declaration"},
      i = {buf.implementation, "Go to implementation"},
      r = {buf.references, "See references"},
      t = {buf.type_definition, "Go to type definition"}
    },
    K = {buf.hover, "Hover"},
    ["[d"] = {diagnostic.goto_prev, "Go to prev diagnostic"},
    ["]d"] = {diagnostic.goto_next, "Go to next diagnostic"},
    ["<leader>"] = {
      ["ca"] = {buf.code_action, "Code action"},
      ["fc"] = {buf.formatting, "format code"},
      ["dl"] = {require("telescope.builtin").diagnostics, "Diagnostic list"},
      ["ds"] = {require("telescope.builtin").lsp_document_symbols, "Document Symbols"},
    }
  }, {mode = "n", buffer = bufnr})
end

M.setup_keymaps = setup_keymaps

M.on_attach = function(client, bufnr)
  -- TODO: refactor this into a method that checks if string in list
  if client.name == "tsserver" then
    client.resolved_capabilities.document_formatting = false
  end
  setup_keymaps(bufnr)
  require('illuminate').on_attach(client)
end

-- Setup capabilities using default vim func & cmp
local client_capabilities = vim.lsp.protocol.make_client_capabilities()

M.capabilities = require('cmp_nvim_lsp').update_capabilities(client_capabilities)

return M
