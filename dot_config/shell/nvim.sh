# Set editor to either neovim or vim
if [ -n "$(command -v nvim)" ]
then
  export EDITOR=nvim
  alias v="nvim"
else
  echo "neovim not installed!"
  export EDITOR=vim
  alias v="vim"
fi
