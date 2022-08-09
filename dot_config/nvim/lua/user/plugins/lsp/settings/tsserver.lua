-- Check if extra modules are in
local status_ok, _ = pcall(require, "nvim-lsp-ts-utils")
if not status_ok then
  print("nvim-lsp-ts-utils not installed")
  return {}
end

-- Helpers
-- Special stuff for tsserver because react :(
-- Kudos: https://github.com/typescript-language-server/typescript-language-server/issues/216#issuecomment-1005272952
local function filter(arr, fn)
    if type(arr) ~= "table" then return arr end

    local filtered = {}
    for k, v in pairs(arr) do
        if fn(v, k, arr) then table.insert(filtered, v) end
    end

    return filtered
end

local function filterReactDTS(value)
    return string.match(value.uri, 'react/index.d.ts') == nil
end

-- Settings
return {
  init_options = require("nvim-lsp-ts-utils").init_options,

  on_attach = function(client, bufnr)
    local ts_utils = require("nvim-lsp-ts-utils")
    ts_utils.setup({})
    ts_utils.setup_client(client)
    require("user.plugins/lsp.handlers").setup_keymaps(client, bufnr)
  end,

  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
  },

  handlers = {
    ['textDocument/definition'] = function(err, result, method, ...)
      if vim.tbl_islist(result) and #result > 1 then
        local filtered_result = filter(result, filterReactDTS)
        return vim.lsp.handlers['textDocument/definition'](err,
          filtered_result,
          method,
          ...)
      end

      vim.lsp.handlers['textDocument/definition'](err, result, method,
        ...)
    end
  },
}
