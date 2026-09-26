#!/usr/bin/env bash

WPP_1080="$HOME/Pictures/asciiwpp2.png"
WPP_1440="$HOME/Pictures/asciiwpp2_21x9.png"
STATE_FILE="$HOME/.config/hypr/monitor_state.lua"

sleep 1 

apply_hdmi() {
    # write state to lua file (usando enabled = false)
    echo 'hl.monitor({ output = "eDP-1", enabled = false })' > "$STATE_FILE"
    echo 'hl.monitor({ output = "HDMI-A-1", mode = "3440x1440@100", position = "0x0", scale = 1 })' >> "$STATE_FILE"
    
    # reload config and apply wallpaper
    hyprctl reload
    awww img "$WPP_1440"
}

apply_edp() {
    # invert state (usando enabled = false)
    echo 'hl.monitor({ output = "HDMI-A-1", enabled = false })' > "$STATE_FILE"
    echo 'hl.monitor({ output = "eDP-1", mode = "preferred", position = "0x0", scale = 1 })' >> "$STATE_FILE"
    
    hyprctl reload
    awww img "$WPP_1080"
}

# 1. initial check
if hyprctl monitors all | grep -q "Monitor HDMI-A-1"; then
    apply_hdmi
else
    apply_edp
fi

# 2. listen to real-time events
socat -U - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | while read -r line; do
    case "$line" in
        monitoradded*HDMI-A-1*) apply_hdmi ;;
        monitorremoved*HDMI-A-1*) apply_edp ;;
    esac
done
