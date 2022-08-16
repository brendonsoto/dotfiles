local null_ls = require('null-ls')
local builtins = null_ls.builtins

-- NOTE to self:
-- If you're wondering "where are the tools for other langs I use?"
-- The lang servers take care of it.
-- null_ls is for injecting non-LSP diagnostics and more into the editor
null_ls.setup({
  debug = true,
  sources = {
    -- General
    builtins.completion.spell,

    -- Docker
    builtins.diagnostics.hadolint,

    -- JSON
    builtins.formatting.fixjson,

    -- Shell
    builtins.diagnostics.shellcheck,

    -- YAML
    builtins.diagnostics.yamllint.with({
      extra_args = { "-c", vim.fn.expand("~/.config/yamllint/my_rules.yml" )}
    }),
  },
})
