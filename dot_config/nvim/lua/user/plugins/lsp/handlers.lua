local M = {}

-- Uses illuminate to highlight other instances of the currently selected word
local function setup_highlight_document(client)
  local status_ok, illuminate = pcall(require, "illuminate")
  if not status_ok then
    return
  end
  illuminate.on_attach(client)
end

-- Use which-key to setup keymaps
local setup_keymaps = function(_, bufnr)
  local is_wk_present, wk = pcall(require, "which-key")
  if (is_wk_present == false) then
    print("which-key not found")
    return
  end
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
      ["fc"] = {buf.formatting, "format code"}
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
  setup_highlight_document(client)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

-- If cmp is available, use that to replace lsp default capabilities
local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if status_ok then
  M.capabilities = cmp_nvim_lsp.update_capabilities(capabilities)
else
  M.capabilities = capabilities
end

return M
