# Ideas

## Git
- only show local branches for autocomplete? but how to handle remotes for checking out other's work...

## Git commit linting?
I feel like I need to make sure I have at least a title and some description.
No. Descriptions aren't always needed.

## Update `notify_when_done`
I want to call it like `notify_when_done process`
Maybe rename it to `lmk`

## Neovim
### Which-key <=> Telescope.builtins.keymaps
Just learned about `Telescope.builtins.keymaps`
Makes me wonder if I don't need `which-key`
I do wonder too, can you add metadata for keymaps you make to make them descriptive?
_Update:_ Nahhh, I like
_Update2:_ Going to try again. I think it's more helpful than typing a key and waiting.

Need to move keymaps around from which-key
Did so 2022-Nov-27


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

### LSP - format on save?

### LSP - explore workspaces?

### How does LSP work?
