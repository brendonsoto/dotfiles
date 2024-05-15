local autocmd = vim.api.nvim_create_autocmd

-- Set JSON-like files to use json syntax highlighting
autocmd({ 'BufNewFile', 'BufRead' }, {
  pattern = { '*.json', '.babelrc', '.eslintrc' },
  desc = 'Set certain files\' filetype to json',
  callback = function()
    vim.o.filetype = 'json'
  end,
})

-- Tmux files
-- autocmd({ 'BufRead', 'BufNewFile' }, {
--   pattern = '*.tmux',
--   desc = 'Set certain files\' filetype to json',
--   callback = function()
--     vim.o.filetype = 'tmux'
--   end,
-- })

-- Add JS/JSX/TS/TSX suffixes to files of the same type for easy nav
autocmd({ 'BufNewFile', 'BufRead' },  {
  pattern = { '*.js',' *.jsx',' *.ts', '*.tsx' },
  desc = 'Set certain files\' filetype to json',
  callback = function()
    vim.opt.suffixesadd = { '.js', '.jsx', '.ts', '.tsx' }
  end,
})
