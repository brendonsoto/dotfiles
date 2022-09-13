if [ -f ~/.fzf.zsh ]
then
  source ~/.fzf.zsh

  # Set fzf to use ag
  if [ -n "$(command -v ag)" ]
  then
    export FZF_DEFAULT_COMMAND="ag -p ~/dotfiles/.ignore -g ''"
    export FZF_CTRL_T_COMMAND="ag -p ~/dotfiles/.ignore -g ''"
  else
    echo "ag not installed!"
  fi

  _fzf_compgen_path() {
    ag -p ~/dotfiles/.ignore -g ''
  }

  _fzf_compgen_dir() {
    fd --type d --hidden --follow --exclude '.git' . "$1"
  }
fi
