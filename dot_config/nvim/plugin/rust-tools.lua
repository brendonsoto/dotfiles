local rt = require('rust-tools')

return {
  server = {
    on_attach = function(_, bufnr)
      -- Hover actions
      vim.keymap.set('n', '<c-space>', rt.hover_actions.hover_actions,
        { buffer = bufnr, desc = '[Rust Tools] Hover actions' })
      -- Code action groups
      vim.keymap.set('n', '<leader>a', rt.code_action_group.code_action_group,
        { buffer = bufnr, desc = '[Rust Tools] Action groups' })
    end,

    settings = {
      ['rust-analyzer'] = {
        inlayHints = { locationLinks = false },
      },
    },
  },
}
