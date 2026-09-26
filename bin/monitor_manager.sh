#!/usr/bin/env bash

HYPR_SOCK="$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock"

WALL_1440="$HOME/Pictures/asciiwpp2_21x9.png"
WALL_1080="$HOME/Pictures/asciiwpp2.png"

apply_hdmi() {
    hyprctl eval 'hl.monitor({ output = "HDMI-A-1", mode = "3440x1440@100", position = "0x0", scale = 1, disabled = false })'
    hyprctl eval 'hl.monitor({ output = "eDP-1", disabled = true })'
    awww img "$WALL_1440" --outputs HDMI-A-1
}

apply_laptop_only() {
    hyprctl eval 'hl.monitor({ output = "eDP-1", mode = "preferred", position = "0x0", scale = 1, disabled = false })'
    hyprctl eval 'hl.monitor({ output = "HDMI-A-1", disabled = true })'
    awww img "$WALL_1080" --outputs eDP-1
}

check_and_apply() {
    if hyprctl monitors -j | jq -e '.[] | select(.name=="HDMI-A-1")' >/dev/null 2>&1; then
        apply_hdmi
    else
        apply_laptop_only
    fi
}

check_and_apply

socat -U - UNIX-CONNECT:"$HYPR_SOCK" | while read -r line; do
    case "$line" in
        monitoradded*|monitorremoved*)
            sleep 1
            check_and_apply
            ;;
    esac
done
