# Reloading shell removes vim bindings
## Fix
   Reverted from antidote to regular oh-my-zsh
   Call `omz reload` after re-sourcing `~/.zshrc`
   I changed my `reload` alias to `source ~/.zshrc && omz reload` for convenience.

   Kudos {https://github.com/jeffreytse/zsh-vi-mode/issues/169}
