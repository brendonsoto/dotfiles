# Ideas

## Which-key <=> Telescope.builtins.keymaps
Just learned about `Telescope.builtins.keymaps`
Makes me wonder if I don't need `which-key`
I do wonder too, can you add metadata for keymaps you make to make them descriptive?
_Update:_ Nahhh, I like

## NOTE: Resolving webpack aliases when using "go to"
Problem:
You have a webpack alias and thus have import statements like:
`import MyComp from '~/components';`
You have `MyComp` under your cursor and try to "go-to" the definition
Sometimes that wouldn't happen.
Of course, now I cannot reproduce it.

New problem:
How to resolve webpack aliases when in insert mode when making an import statement
This makes me think it's a nvim-cmp thing

## Neorg -- table of contents for quick moving around
Kinda ish...
`:Telescope neorg search_headings` is broken
Using `:Telescope neorg find_linkable` for now
But I'd like to fix it...

## Lua linter/formatter?

## Markdown -- fix <CR> keymapping for relative links?
