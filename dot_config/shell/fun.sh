#!/bin/sh
# Launch an aquarium on startup on non tmux!
if [ "$(command -v asciiquarium)" ]
then
  asciiquarium
fi
