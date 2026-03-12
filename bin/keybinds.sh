#!/usr/bin/env bash

FILES=$(find "$HOME/.config/hypr" -name "*.conf")

ROFI_THEME="* { font: \"JetBrainsMono Nerd Font 10\"; } window { width: 45em; border: 2px; border-radius: 8px; border-color: #444444; background-color: #111111; }"

output=$(cat $FILES | grep -E '^bind[e]*\s*=' | while read -r line; do
    clean_line=$(echo "$line" | sed 's/\$mainMod/Super/g' | sed 's/bind[e]*\s*=\s*//g')

    KEYS=$(echo "$clean_line" | cut -d',' -f1,2 | tr -d ' ')
    CMD=$(echo "$clean_line" | cut -d',' -f3-)

    if [[ "$line" == *"#"* ]]; then
        DESC=$(echo "$line" | awk -F'#' '{print $NF}' | xargs)
    else
        DESC="Command: $(echo "$CMD" | cut -c1-30)..."
    fi

    printf "%-25s ::: %s\n" "$KEYS" "$DESC"
done)

if [ -z "$output" ]; then
    notify-send -u critical "Error" "No keybinds found in Hyprland configs."
    exit 1
fi

echo -e "$output" | rofi -dmenu -i -p "⌨️ Keybinds" \
    -theme-str "$ROFI_THEME" \
    -display-columns 1
