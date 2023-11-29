# Set editor to either neovim or vim
if [ -n "$(command -v nvim)" ]
then
  export EDITOR=nvim
  export VISUAL=nvim
  alias v="nvim"
else
  echo "neovim not installed!"
  export EDITOR=vim
  export VISUAL=vim
  alias v="vim"
fi
