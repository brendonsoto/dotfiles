require('telescope').load_extension('heading')
vim.keymap.set('n', '<leader>dh', ':Telescope heading<CR>', {
  desc = 'Doc header (Markdown)',
})
