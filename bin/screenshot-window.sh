#!/bin/bash
# Get the geometry of the currently focused window
WINDOW=$(hyprctl activewindow -j | jq -r '"\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"')

# Capture only that area and send it to your Swappy editor
grim -g "$WINDOW" - | swappy -f -
