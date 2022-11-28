local servers = {
  'eslint',
  'html',
  'sumneko_lua',
  'tsserver',
}

require('mason').setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    }
  }
})

require('mason-lspconfig').setup({
  ensure_installed = servers,
  automatic_installation = true,
})

-- Setup LSP configs
for _, server in pairs(servers) do
  local opts = {}
  -- local opts = {
  --   on_attach = require('user.plugins.lsp.handlers').on_attach,
  --   capabilities = require('user.plugins.lsp.handlers').capabilities,
  -- }

  -- local server_module = 'user.plugins.lsp.settings.' .. server
  -- local has_custom_opts, custom_opts = pcall(require, server_module)
  --
  -- if has_custom_opts then
  --   opts = vim.tbl_extend("force", opts, custom_opts)
  -- end

  require("lspconfig")[server].setup(opts)
end


-- Extras
-- Configure more helpful virtual text
vim.diagnostic.config {
  virtual_text = false,
  float = {
    format = function(diagnostic)
      if diagnostic.source == 'eslint' then
        return string.format(
          '[%s]\n%s',
          diagnostic.user_data.lsp.code,
          -- shows the name of the rule
          diagnostic.message
        )
      end
      return string.format('%s [%s]', diagnostic.message, diagnostic.source)
    end,
    severity_sort = true,
    close_events = { 'BufLeave', 'CursorMoved', 'InsertEnter', 'FocusLost' },
    max_width = 80,
  },
}
