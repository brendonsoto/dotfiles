local cmd = vim.cmd
local autocmd = vim.api.nvim_create_autocmd

-- Enable file detection and load any plugins for them
autocmd({ 'FileType' }, {
  pattern = 'plugin',
  command = 'indent on',
  desc = 'Enable file detection and load any plugins for them'
})

-- AutoClose quickfix window on selection
-- Relevant for only the current buffer
autocmd({ 'FileType' }, {
  pattern = 'qf',
  callback = function()
    vim.api.nvim_buf_set_keymap(0, 'n', '<CR>', '<CR>:lclose<CR>', {
      noremap = true,
    })
  end,
})

-- Disable auto commenting
autocmd({ 'FileType' }, {
  pattern = '*',
  desc = 'Disable auto commenting',
  callback = function()
     vim.opt.formatoptions:remove { 'c', 'r', 'o' }
  end,
})

-- Jump to last known position in a file after opening
-- From the vim docs, usr_05.txt
cmd([[
  autocmd BufRead * autocmd FileType <buffer> ++once
    \ if &ft !~# 'commit\|rebase' && line("'\"") > 1 && line("'\"") <= line("$") | exe 'normal! g`"' | endif
]])

-- Sync syntax highlighting
-- kudos https://vim.fandom.com/wiki/Fix_syntax_highlighting
autocmd({ 'BufEnter' }, {
  pattern = '*',
  command = 'syntax sync fromstart',
})
