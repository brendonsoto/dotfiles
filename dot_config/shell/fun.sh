#!/bin/sh
# Launch an aquarium on startup on non tmux!
if [ -z "$TMUX" ] || [ -z "$ZELLIJ" ] && [ "$(command -v asciiquarium)" ]
then
  asciiquarium
fi
