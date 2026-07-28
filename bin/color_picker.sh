#!/bin/bash

color=$(hyprpicker)

if [[ -n "$color" ]]; then
    color_lower=$(echo "$color" | tr '[:upper:]' '[:lower:]')

    echo -n "$color_lower" | wl-copy

    notify-send -u low "color picker" "hex: $color_lower copied."
fi
