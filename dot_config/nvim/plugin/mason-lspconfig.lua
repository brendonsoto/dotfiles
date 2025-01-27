local lspconfig = require('lspconfig')

local servers = {
  'eslint',
  'html',
  'lua_ls',
  'marksman',
  'ts_ls',
}

local on_attach = function(client, bufnr)
  local vks = vim.keymap.set
  local buf = vim.lsp.buf

  -- Enable completion triggered by <c-x><c-o>
  -- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  vks('n', 'gd', buf.definition, { desc = 'Go to definition' })
  vks('n', 'gD', buf.declaration, { desc = 'Go to declaration' })
  vks('n', 'gi', buf.implementation, { desc = 'Go to implementation' })
  -- vks('n', 'gr', buf.references, { desc = 'See references' })
  vks('n', 'gt', buf.type_definition, { desc = 'Go to type definition' })
  -- vks('n', 'K', buf.hover, { desc = 'Hover' })
  -- vks('n', '<leader>ca', buf.code_action, { desc = 'Code action' })
  vks('n', '<leader>fc', buf.format, { desc = 'format code' })
end

-- NOTE: Using this instead of cmp for now because cmp's capabilites don't work
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
local capabilities = require('cmp_nvim_lsp').default_capabilities()

require('mason-lspconfig').setup({
  ensure_installed = servers,
  automatic_installation = true,
  handlers = {
    -- The default handler
    -- Will be called for each installed server that doesn't have
    -- a dedicated handler.
    function (server_name) -- default handler (optional)
      require("lspconfig")[server_name].setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })
    end,
    -- Specific servers
    -- ["ts_ls"] = function () end, -- early return for tsserver so typescript-tools can take over
    ["lua_ls"] = function ()
      lspconfig.lua_ls.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          Lua = {
            runtime = {
              -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
              version = 'LuaJIT',
            },
            diagnostics = {
              -- Get the language server to recognize the `vim` global
              globals = {'vim'}
            },
            workspace = {
              -- Prevent asking if I'm using libs every time
              checkThirdParty = false,
              -- Make the server aware of Neovim runtime files
              library = vim.api.nvim_get_runtime_file("", true),
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {enable = false}
          }
        }
      }
    end,

    -- Don't need this specific config if not working w/ graphql
    -- ["eslint"] = function ()
    --   lspconfig.eslint.setup {
    --     on_attach = on_attach,
    --     capabilities = capabilities,
    --     settings = {
    --       filetypes = {
    --         "graphql",
    --         "javascript",
    --         "javascriptreact",
    --         "javascript.jsx",
    --         "typescript",
    --         "typescriptreact",
    --         "typescript.tsx",
    --         "vue",
    --       }
    --     }
    --   }
    -- end,
  },
})
