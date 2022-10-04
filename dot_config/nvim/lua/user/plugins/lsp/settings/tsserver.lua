-- Helpers
-- Special stuff for tsserver because react :(
-- Kudos: https://github.com/typescript-language-server/typescript-language-server/issues/216#issuecomment-1005272952
-- local function filter(arr, fn)
--     if type(arr) ~= "table" then return arr end
--
--     local filtered = {}
--     for k, v in pairs(arr) do
--         if fn(v, k, arr) then table.insert(filtered, v) end
--     end
--
--     return filtered
-- end
--
-- local function filterReactDTS(value)
--     return string.match(value.uri, 'react/index.d.ts') == nil
-- end

-- Settings
return {
  settings = {
    filetypes = {
      "javascript",
      "javascriptreact",
      "javascript.jsx",
      "typescript",
      "typescriptreact",
      "typescript.tsx",
    },

    -- Handlers is commented out because something here breaks on neovim .8
    -- handlers = {
    --   ['textDocument/definition'] = function(err, result, method, ...)
    --     if vim.tbl_islist(result) and #result > 1 then
    --       local filtered_result = filter(result, filterReactDTS)
    --       return vim.lsp.handlers['textDocument/definition'](err,
    --         filtered_result,
    --         method,
    --         ...)
    --     end
    --
    --     vim.lsp.handlers['textDocument/definition'](err, result, method,
    --       ...)
    --   end
    -- },
  }
}
