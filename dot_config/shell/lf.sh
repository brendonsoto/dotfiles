if [ -n "$(command -v lf)" ]
then
  # For what the keys mean, check out https://github.com/gokcehan/lf/blob/aebff483a79edbde020a63816acbceb3278ed3e6/icons.go#L79
  export LF_ICONS="ln=:di=:fi=:ex=:*.html=:*.js=:*.jsx=:*.ts=:*.tsx=:*.json=ﬥ:*.rb=:*.hs=:*.norg=:*.vim=:*.vimrc:*.lua=:*.*rc=:Dockerfile=:"

  LFCD="$HOME/.config/lf/lfcd.sh"
  . "$LFCD"
  alias lf="lfcd"
fi
