#!/usr/bin/env bash

FILES=$(find "$HOME/.config/hypr" -name "*.conf")

ROFI_THEME="* { font: \"IosevkaTerm Nerd Font 11\"; } window { width: 45em; border: 1px; border-radius: 0px; border-color: #444444BB; background-color: #0D0D0DBB; }"

output=$(cat $FILES | grep -E '^bind[e]*\s*=' | while read -r line; do
    clean_line=$(echo "$line" | sed 's/\$mainMod/Super/g' | sed 's/bind[e]*\s*=\s*//g')

    KEYS=$(echo "$clean_line" | cut -d',' -f1,2 | tr -d ' ' | sed 's/,/ + /g')

    RAW_CMD=$(echo "$clean_line" | cut -d',' -f3-)

    if [[ "$line" == *"#"* ]]; then
        DESC=$(echo "$line" | awk -F'#' '{print $NF}' | xargs)
        CMD=$(echo "$RAW_CMD" | awk -F'#' '{print $1}' | sed 's/^ *//;s/ *$//')
    else
        DESC="---"
        CMD=$(echo "$RAW_CMD" | sed 's/^ *//;s/ *$//')
    fi

    printf "%-22s ::: %-30s ::: %s\n" "$KEYS" "$DESC" "$CMD"
done)

if [ -z "$output" ]; then
    notify-send -u critical "Error" "No keybinds found in Hyprland configs."
    exit 1
fi

echo -e "$output" | rofi -dmenu -i -p "keybinds" \
    -theme-str "$ROFI_THEME" \
    -display-columns 1
