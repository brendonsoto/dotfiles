local lspconfig = require('lspconfig')

local lsp_get_capabilities = function(cmp_nvim_lsp)
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    local cmp_nvim_lsp_present, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
    if (cmp_nvim_lsp_present == false) then
        print("Cannot find cmp_nvim_lsp")
        return capabilities
    end

    return cmp_nvim_lsp.update_capabilities(capabilities)
end

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

local capabilities = lsp_get_capabilities(cmp_nvim_lsp)

lspconfig.vuels.setup {
    capabilities = capabilities,
    on_attach = on_attach,
    init_options = vuels_setup.init_options
}

lspconfig.tsserver.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = {
      "javascript", "javascriptreact", "javascript.jsx", "typescript",
      "typescriptreact", "typescript.tsx", "vue"
    },
}

lspconfig.graphql.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}
