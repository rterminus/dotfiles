#!/usr/bin/env bash

sleep 1

systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP

systemctl --user start graphical-session.target

systemctl --user restart xdg-desktop-portal-hyprland
systemctl --user restart xdg-desktop-portal
