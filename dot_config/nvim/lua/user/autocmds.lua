local cmd = vim.cmd

-- AutoClose quickfix window on selection
cmd([[autocmd FileType qf nnoremap <buffer> <CR> <CR>:cclose<CR>]])

-- Disable auto commenting
cmd([[
  autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
]])

-- Jump to last known position in a file after opening
cmd([[
  autocmd BufRead * autocmd FileType <buffer> ++once
    \ if &ft !~# 'commit\|rebase' && line("'\"") > 1 && line("'\"") <= line("$") | exe 'normal! g`"' | endif
]])

-- Sync syntax highlighting
-- kudos https://vim.fandom.com/wiki/Fix_syntax_highlighting
cmd([[autocmd BufEnter * :syntax sync fromstart]])

-- TODO: Move these to their own files?
-- Set .Xmonad-related files to use Haskell syntax highlighting
cmd([[autocmd BufRead,BufNewFile .xmobarrc set filetype=haskell]])

-- Set JSON-like files to use json syntax highlighting
cmd([[autocmd BufRead,BufNewFile *.json,.eslintrc,.babelrc set filetype=json]])

-- Tmux files
cmd([[autocmd BufRead,BufNewFile *.tmux set filetype=tmux]])

-- Fugitive - auto-clean fugitive buffers
cmd([[autocmd BufReadPost fugitive://* set bufhidden=delete]])
