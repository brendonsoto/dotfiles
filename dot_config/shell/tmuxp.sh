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

# @description Start a tmux session from a list of dirs from FZF
#              Depends on $WORK_DIRS set to a colon separated list of paths and
#              $WORK_PATH being set.
# @example
#   $ twerk
twerk() {
  service_list=$(printf "%s" "$WORK_DIRS" | tr ':' '\n')
  service=$(printf "%s\n" "$service_list" | fzf)
  service_path=$(printf "%s/%s" "$WORK_PATH" "$service")

  mk_tmux_sesh "$service_path"
}
