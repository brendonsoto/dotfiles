local lsp_installer = require("nvim-lsp-installer")

-- Auto install some servers
local servers = {
  'dockerls',
  'eslint',
  'graphql',
  'hls',
  'html',
  'rust_analyzer',
  'solargraph',
  'sumneko_lua',
  'tsserver',
  'vuels',
}

for _, name in pairs(servers) do
  local server_is_found, server = lsp_installer.get_server(name)
  if server_is_found and not server:is_installed() then
    print("Installing " .. name)
    server:install()
  end
end


-- LSP helpers
local lsp_get_capabilities = function()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  local cmp_nvim_lsp_present, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
  if (cmp_nvim_lsp_present == false) then
    print("Cannot find cmp_nvim_lsp")
    return capabilities
  end

  return cmp_nvim_lsp.update_capabilities(capabilities)
end

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
  require "lsp_signature".on_attach()
  setup_keymaps(client, bufnr)
end

local capabilities = lsp_get_capabilities()

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

local enhance_server_opts = {
  ["tsserver"] = function(opts)
    opts.init_options = require("nvim-lsp-ts-utils").init_options

    opts.on_attach = function(client, bufnr)
      require "lsp_signature".on_attach()
      local ts_utils = require("nvim-lsp-ts-utils")
      ts_utils.setup({})
      ts_utils.setup_client(client)
      setup_keymaps(client, bufnr)
    end

    opts.filetypes = {
      "javascript", "javascriptreact", "javascript.jsx", "typescript",
      "typescriptreact", "typescript.tsx", "vue"
    }

    opts.handlers = {
      ['textDocument/definition'] = function(err, result, method, ...)
        if vim.tbl_islist(result) and #result > 1 then
          local filtered_result = filter(result, filterReactDTS)
          return vim.lsp.handlers['textDocument/definition'](err, filtered_result, method, ...)
        end

        vim.lsp.handlers['textDocument/definition'](err, result, method, ...)
      end
    }
  end,
  ["vuels"] = function(opts)
    opts.init_options = {
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
  end,
}

-- Register a handler that will be called for each installed server when it's ready (i.e. when installation is finished
-- or if the server is already installed).
lsp_installer.on_server_ready(function(server)
  local opts = {
    on_attach = on_attach,
    capabilities = capabilities,
  }

  if server.name == "rust_analyzer" then
    require("rust-tools").setup {
      server = vim.tbl_deep_extend("force", server:get_default_options(), opts),
    }
    server:attach_buffers()
    return
  end

  if enhance_server_opts[server.name] then
    enhance_server_opts[server.name](opts)
  end

  -- This setup() function will take the provided server configuration and decorate it with the necessary properties
  -- before passing it onwards to lspconfig.
  -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
  server:setup(opts)
end)

require('fidget').setup {}
