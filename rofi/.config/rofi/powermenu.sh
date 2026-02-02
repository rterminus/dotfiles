#!/usr/bin/env bash

# Options
lock="󰌾 Lock"
logout="󰗽 Logout"
reboot="󰜉 Reboot"
shutdown="󰐥 Shutdown"

# Variable passed to rofi
options="$lock\n$logout\n$reboot\n$shutdown"

chosen="$(echo -e "$options" | rofi -dmenu -i -p "Power" -theme ~/.config/rofi/powermenu.rasi)"

case $chosen in
    $shutdown)
        systemctl poweroff ;;
    $reboot)
        systemctl reboot ;;
    $logout)
        hyprctl dispatch exit ;;
    $lock)
        hyprlock ;;
esac
