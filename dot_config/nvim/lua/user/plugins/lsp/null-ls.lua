local null_ls = require('null-ls')
local builtins = null_ls.builtins

null_ls.setup({
  sources = {
    -- General
    builtins.completion.spell,

    -- Docker
    builtins.diagnostics.hadolint,

    -- JS/TS
    builtins.diagnostics.eslint,
    builtins.diagnostics.tsc,
    builtins.formatting.eslint,

    -- JSON
    builtins.diagnostics.jsonlint,
    builtins.formatting.json_tool,

    -- Lua
    -- builtins.diagnostics.luacheck,
    builtins.formatting.stylua,

    -- Python
    -- builtins.diagnostics.flake8,
    builtins.diagnostics.pyproject_flake8,
    builtins.formatting.black,

    -- Shell
    builtins.diagnostics.shellcheck,

    -- YAML
    builtins.diagnostics.yamllint,
  },
})
