# Launching tmuxp without this results in a prompt asking for this to be added
export DISABLE_AUTO_TITLE='true'

# NOTES OF WHAT YOU"VE DONE BEFORE:
# Passed in arg to rename session outside of dir name.
# Removed this since I barely renamed.

# @description Create a named tmux session using the default config.
# @arg $1 string A path to a directory to use as the starting directory.
# @example
#   $ mk_tmux_sesh $HOME/Documents
#   $ Creating session named: Documents
#   $ my-session
mk_tmux_sesh() {
  sesh_name=$(basename "$1")
  echo "Creating session named: '$sesh_name'"

  DIR=$1 SESH_NAME=$sesh_name tmuxp load default
}
