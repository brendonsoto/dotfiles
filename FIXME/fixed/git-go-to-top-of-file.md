# Git go to top of file
  This is for commits

## Repro
   - make changes
   - `git ci` (commit)
   - notice how your cursor may be at a random position

## FIX
### Before
    @code vimscript
      :au BufReadPost *
  \ if line("'\"") > 1 && line("'\"") <= line("$") && &ft !~# 'gitcommit'
  \ |   exe "normal! g`\""
    \ | endif
    @end

### After
    See `:h restore-cursor`
