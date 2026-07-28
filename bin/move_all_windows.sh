#!/usr/bin/env bash

TARGET_WS=$1
CURRENT_WS=$(hyprctl activeworkspace -j | jq '.id')

if [ "$TARGET_WS" == "$CURRENT_WS" ]; then
    exit 0
fi

hyprctl clients -j | jq -r ".[] | select(.workspace.id == $CURRENT_WS) | .address" | while read -r address; do
    hyprctl dispatch movetoworkspacesilent "$TARGET_WS,address:$address"
done

hyprctl dispatch workspace "$TARGET_WS"
