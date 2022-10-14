# launcher is a symlink, so check beforehand
if [ -f "$HOME"/.config/broot/launcher/bash/br ]
then
  . "$HOME"/.config/broot/launcher/bash/br
else
  echo "Run broot --install"
fi
alias brf="br -f" # shorten br for files only
