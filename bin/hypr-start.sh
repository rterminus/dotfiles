#!/usr/bin/env zsh

# --- Wayland Environment Variables ---
export XDG_CURRENT_DESKTOP=Hyprland
export XDG_SESSION_TYPE=wayland
export XDG_SESSION_DESKTOP=Hyprland

# Hardware Acceleration (AMD Ryzen 5700U)
export LIBVA_DRIVER_NAME=radeonsi
export VDPAU_DRIVER=radeonsi

# Toolkit fixes
export QT_QPA_PLATFORM=wayland
export GDK_BACKEND=wayland
export SDL_VIDEODRIVER=wayland
export CLUTTER_BACKEND=wayland

# Start the engine
exec start-hyprland

exec swww-daemon
exec swww img /home/terminus/Pictures/grdwpp.png
