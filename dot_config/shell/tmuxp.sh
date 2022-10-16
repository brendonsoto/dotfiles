# Launching tmuxp without this results in a prompt asking for this to be added
export DISABLE_AUTO_TITLE='true'

# @description Create a named tmux session using the default config.
# Prompts user for session name (uses selected dir as default).
# @arg $1 string A path to a directory to use as the starting directory.
# @example
#   $ mk_tmux_sesh $HOME/Documents
#   $ Session name? (default is 'default'):
#   $ my-session
mk_tmux_sesh() {
  sesh_name=$(basename "$1")
  echo "Session name? (Will default to '$sesh_name'): "
  read -r input

  [ "$input" ] && sesh_name="$input"

  DIR=$1 SESH_NAME=$sesh_name tmuxp load default
}
