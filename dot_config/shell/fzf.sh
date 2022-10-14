[ -f ~/.fzf.zsh ] && . ~/.fzf.zsh

# Set fzf to use ripgrep
if [ -n "$(command -v rg)" ]
then
  export FZF_DEFAULT_COMMAND="rg"
  export FZF_CTRL_T_COMMAND="rg"
else
  echo "ripgrep not installed!"
fi

_fzf_compgen_path() {
  rg
}

_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude '.git' . "$1"
}

if [ "$(command -v fd)" ]
then
  fzt() {
    dir=$(fd -t d | fzf)
    mk_tmux_sesh "$dir"
  }
fi
