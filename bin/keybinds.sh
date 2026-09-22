#!/usr/bin/env bash

FILES=$(find "$HOME/.config/hypr" -name "*.lua")

ROFI_THEME="* { font: \"IosevkaTerm Nerd Font 11\"; } window { width: 65em; border: 1px; border-radius: 0px; border-color: #444444BB; background-color: #0D0D0DBB; }"

output=$(cat $FILES | grep 'hl\.bind(' | while read -r line; do
    
    if [[ "$line" == *"-- "* ]]; then
        DESC=$(echo "$line" | awk -F'-- ' '{print $NF}' | xargs)
        CODE=$(echo "$line" | awk -F'-- ' '{print $1}')
    else
        DESC="---"
        CODE="$line"
    fi

    temp=${CODE#*hl.bind(}
    
    KEYS=$(echo "$temp" | awk -F',' '{print $1}')
    
    KEYS=$(echo "$KEYS" | sed 's/mainMod \.\. /Super /g' | sed 's/ \.\. ws/[1-9]/g' | tr -d '"' | tr -s ' ' | sed 's/^ *//;s/ *$//')

    CMD=$(echo "$temp" | sed "s/^[^,]*,[ \t]*//" | sed 's/)[ \t]*$//' | sed 's/^ *//;s/ *$//')

    printf "%-25s ::: %-35s ::: %s\n" "$KEYS" "$DESC" "$CMD"
done)

if [ -z "$output" ]; then
    notify-send -u critical "Error" "No keybinds found in Hyprland configs."
    exit 1
fi

echo -e "$output" | rofi -dmenu -i -p "keybinds" \
    -theme-str "$ROFI_THEME" \
    -display-columns 1
