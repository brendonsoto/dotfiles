# FIXME

## macOS
- Brew installation requires another step now so not sure if I can automate it right away :/
- Rust?
  - wait until you're using it more regularly
  - script for git worktree?

## Neovim
### Markdown -- fix <CR> keymapping for relative links?

### Neorg -- table of contents for quick moving around
Kinda ish...
`:Telescope neorg search_headings` is broken
Using `:Telescope neorg find_linkable` for now
But I'd like to fix it...

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
