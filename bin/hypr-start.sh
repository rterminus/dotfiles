#!/usr/bin/env zsh

# wayland env variables
export XDG_CURRENT_DESKTOP=Hyprland
export XDG_SESSION_TYPE=wayland
export XDG_SESSION_DESKTOP=Hyprland

# hardware acceleration
export LIBVA_DRIVER_NAME=radeonsi
export VDPAU_DRIVER=radeonsi

# toolkit fixes
export QT_QPA_PLATFORM=wayland
export GDK_BACKEND=wayland
export SDL_VIDEODRIVER=wayland
export CLUTTER_BACKEND=wayland

# keyring init
if [ -n "$DESKTOP_SESSION" ]; then
    eval $(gnome-keyring-daemon --start)
    export SSH_AUTH_SOCK
fi

# start the engine
exec start-hyprland
