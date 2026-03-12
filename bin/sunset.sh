#!/usr/bin/env bash

DAY_TEMP=6500
NIGHT_TEMP=3000
START_MIN=$((19 * 60))
END_MIN=$((22 * 60))
MORNING_MIN=$((6 * 60))

STATE_FILE="$HOME/.cache/hyprsunset_state"

apply_temp() {
    local temp=$1
    if ! pgrep -x "hyprsunset" > /dev/null || [ "$(cat "$STATE_FILE")" != "$temp" ]; then
        pkill hyprsunset
        hyprsunset --temperature "$temp" &
        echo "$temp" > "$STATE_FILE"
    fi
}

run_daemon() {
    while true; do
        H=$(date +%H); M=$(date +%M)
        CURRENT_MIN=$((10#$H * 60 + 10#$M))

        if [ "$CURRENT_MIN" -ge "$START_MIN" ] && [ "$CURRENT_MIN" -lt "$END_MIN" ]; then
            PROGRESS=$((CURRENT_MIN - START_MIN))
            DURATION=$((END_MIN - START_MIN))
            DIFF=$((DAY_TEMP - NIGHT_TEMP))

            TEMP=$((DAY_TEMP - (PROGRESS * DIFF / DURATION)))
            apply_temp "$TEMP"
        elif [ "$CURRENT_MIN" -ge "$END_MIN" ] || [ "$CURRENT_MIN" -lt "$MORNING_MIN" ]; then
            apply_temp "$NIGHT_TEMP"
        else
            if pgrep -x "hyprsunset" > /dev/null; then
                pkill hyprsunset
                echo "day" > "$STATE_FILE"
            fi
        fi
        sleep 60
    done
}

case $1 in
    --toggle | -t)
        if pgrep -x "hyprsunset" > /dev/null; then
            pkill hyprsunset && echo "off" > "$STATE_FILE"
        else
            apply_temp "$NIGHT_TEMP"
        fi
        ;;
    --daemon | -d) run_daemon ;;
    *) echo "Usage: sunset.sh [ --toggle | --daemon ]" ;;
esac
