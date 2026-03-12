#!/usr/bin/env bash

LOW=20
CRITICAL=10
FULL=80

while true; do
    BAT=$(ls /sys/class/power_supply/ | grep BAT | head -n 1)
    CAP=$(cat "/sys/class/power_supply/$BAT/capacity")
    STAT=$(cat "/sys/class/power_supply/$BAT/status")

    if [ "$STAT" = "Discharging" ]; then
        if [ "$CAP" -le "$CRITICAL" ]; then
            notify-send -u critical -a "Power" -r 5 -i "battery-empty" "CRITICAL BATTERY" "$CAP% - Suspending soon!"
            sleep 60
        elif [ "$CAP" -le "$LOW" ]; then
            notify-send -u normal -a "Power" -r 5 -i "battery-low" "Battery Low" "Plug in charger ($CAP%)"
            sleep 300
        fi
    elif [ "$STAT" = "Charging" ] || [ "$STAT" = "Full" ]; then
        if [ "$CAP" -ge "$FULL" ] && [ "$CAP" -lt 100 ]; then
             notify-send -a "Power" -r 5 -i "battery-full" "Battery Charged" "You can unplug ($CAP%)"
             sleep 600
        fi
    fi
    sleep 60
done
