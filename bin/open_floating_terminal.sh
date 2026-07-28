#!/usr/bin/env bash

kitty --class floating_terminal & 
sleep 0.1

hyprctl dispatch togglefloating class:floating_terminal

hyprctl dispatch centerwindow
hyprctl dispatch resizewindowpixel exact 800 500,class:floating_terminal
