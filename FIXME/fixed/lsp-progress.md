# LSP Progress
  Tools like fidget don't show anything until the whole server is loaded

## Repro
   - Open up a TS file

## Fix
   *tl;dr - delete plugins, remove `~/.config/nvim files`, and re-install*
   This is weird.
   I did fix it but I didn't really observe what the issue was.
   What I did to fix was basically uninstall almost every plugin (except lsp-config) and remove the files.
   This was while I was trying to debug.
   I was going to give up, I basically had, and decided to reset my setup for the morning.
   I decided to profile my setup with all of my plugins to check it out and to my surprise the loader was there!
