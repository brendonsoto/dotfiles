local lsp_lines = require("lsp_lines")

lsp_lines.setup()

vim.diagnostic.config({ virtual_text = false })

require('which-key').register({
  ["<leader>tl"] = { lsp_lines.toggle, "Toggle LSP Lines" },
})
