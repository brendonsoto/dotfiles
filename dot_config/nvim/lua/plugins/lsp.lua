local lspconfig = require('lspconfig')

vuels_setup = {
    init_options = {
        config = {
            css = {},
            emmet = {},
            html = {suggest = {}},
            javascript = {format = {}},
            stylusSupremacy = {},
            typescript = {format = {}},
            vetur = {
                completion = {
                    autoImport = false,
                    tagCasing = "kebab",
                    useScaffoldSnippets = false
                },
                format = {
                    enable = true,
                    scriptInitialIndent = false,
                    styleInitialIndent = false
                },
                useWorkspaceDependencies = false,
                validation = {script = true, style = false, template = true}
            }
        }
    }
}

local setup_keymaps = function(_client, bufnr)
    local is_wk_present, wk = pcall(require, "which-key")
    if (is_wk_present == false) then
        print("which-key not found")
        return
    end
    local buf = vim.lsp.buf
    local diagnostic = vim.diagnostic

    wk.register({
      g = {
        d = { buf.definition, "Go to definition" },
        D = { buf.declaration, "Go to declaration" },
        i = { buf.implementation, "Go to implementation" },
        r = { buf.references, "See references" },
        t = { buf.type_definition, "Go to type definition" },
      },
      K = { buf.hover, "Hover" },
      ["[d"] = { diagnostic.goto_prev, "Go to prev diagnostic" },
      ["]d"] = { diagnostic.goto_next, "Go to next diagnostic" },
    }, {
      mode = "n",
      buffer = bufnr
    })
end

local on_attach = function(client, bufnr)
  setup_keymaps(client, bufnr)
end

local capabilities = vim.lsp.protocol.make_client_capabilities(cmp_nvim_lsp)

lspconfig.vuels.setup {
    capabilities = capabilities,
    on_attach = on_attach,
    init_options = vuels_setup.init_options
}

lspconfig.graphql.setup {
    on_attach = on_attach,
    filetypes = { "graphql" },
    capabilities = capabilities,
}

-- Special stuff for tsserver because react :(
-- Kudos: https://github.com/typescript-language-server/typescript-language-server/issues/216#issuecomment-1005272952
local function filter(arr, fn)
  if type(arr) ~= "table" then
    return arr
  end

  local filtered = {}
  for k, v in pairs(arr) do
    if fn(v, k, arr) then
      table.insert(filtered, v)
    end
  end

  return filtered
end

local function filterReactDTS(value)
  return string.match(value.uri, 'react/index.d.ts') == nil
end

lspconfig.tsserver.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = {
    "javascript", "javascriptreact", "javascript.jsx", "typescript",
    "typescriptreact", "typescript.tsx", "vue"
  },
  handlers = {
    ['textDocument/definition'] = function(err, result, method, ...)
      if vim.tbl_islist(result) and #result > 1 then
        local filtered_result = filter(result, filterReactDTS)
        return vim.lsp.handlers['textDocument/definition'](err, filtered_result, method, ...)
      end

      vim.lsp.handlers['textDocument/definition'](err, result, method, ...)
    end
  }
}
