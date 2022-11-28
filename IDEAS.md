# Ideas

## Neovim
### Which-key <=> Telescope.builtins.keymaps
Just learned about `Telescope.builtins.keymaps`
Makes me wonder if I don't need `which-key`
I do wonder too, can you add metadata for keymaps you make to make them descriptive?
_Update:_ Nahhh, I like
_Update2:_ Going to try again

### Lua linter/formatter?

### nvim-cmp -- path -- sort alphabetically

### Treesitter -- different color for highlighting a term?
Instead of dimming it, make it like, pink

### More notes than ideas...
Here's how to set a description for a keymap without using `which-key`
Note, `desc = ...`
```lua
vim.keymap.set(
    'n',
    '<Plug>(comment_toggle_linewise)',
    call('toggle.linewise', 'g@'),
    { expr = true, desc = 'Comment toggle linewise' }
)
```
