# Launching tmuxp without this results in a prompt asking for this to be added
export DISABLE_AUTO_TITLE='true'

# @description Create a named tmux session using the default config.
# @arg $1 string A path to a directory to use as the starting directory.
# @example
#   $ mk_tmux_sesh $HOME/Documents
#   $ Session name? (default is 'default'):
#   $ my-session
mk_tmux_sesh() {
  echo "Session name? (default is 'default'): "
  read -r input

  name="default"
  [ "$input" ] && name="$input"

  DIR=$1 SESH_NAME=$name tmuxp load default
}
