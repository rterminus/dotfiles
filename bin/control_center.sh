#!/bin/bash

export PATH="$HOME/go/bin:$HOME/.local/bin:$PATH"
PROJECTS_DIR="$HOME/dev"

if [[ "$1" == "execute" ]]; then
    case "$2" in
        "network")
            nmtui
            ;;
        "processes")
            btop
            ;;
        "projects")
            TARGET=$(sesh list | fzf \
                --prompt=" sesh> " \
                --border="sharp" \
                --info="hidden" \
                --cycle \
                --bind "ctrl-k:up,ctrl-j:down" \
                --color 'bg:#030303,bg+:#1A1A1A,fg:#B8B8B8,fg+:#eeeeee,border:#4C4C4C,prompt:#eeeeee,pointer:#eeeeee')

            if [[ -n "$TARGET" ]]; then
                hyprctl dispatch exec "kitty -- bash -c 'export PATH=\"$HOME/go/bin:$HOME/.local/bin:\$PATH\"; sesh connect \"$TARGET\"'"
            fi
            ;;
        "updates")
            kitty --class floating_shell -e bash -c 'yay; echo done; read -n1'
            ;;
        "media")
            pulsemixer
            ;;
    esac
    exit 0
fi

if [[ "$1" == "preview" ]]; then
    (
        case "$2" in
            "system")
                echo -e "=== cpu (load average) ==="
                cat /proc/loadavg | awk '{print "1m: "$1" | 5m: "$2" | 15m: "$3}'
                echo -e "\n=== memory ==="
                free -h | awk 'NR==1{print $0} NR==2{print $0}'
                echo -e "\n=== disk (/) ==="
                df -h / | awk 'NR==2 {print "used: "$3" / "$2" ("$5")"}'
                echo -e "\n=== battery ==="
                cat /sys/class/power_supply/BAT0/status 2>/dev/null || echo "desktop"
                cat /sys/class/power_supply/BAT0/capacity 2>/dev/null | awk '{print $1"%"}' || echo "n/a"
                echo -e "\n=== caffeine ==="
                pgrep -x hypridle >/dev/null 2>&1 && echo "off (normal)" || echo "on (awake)"
                echo -e "\n>> alt+c: toggle caffeine | alt+spc: system tray<<"
                ;;
            "processes")
                echo -e "=== top cpu ==="
                ps -eo pid,%cpu,comm --sort=-%cpu | head -n 6
                echo -e "\n=== top ram ==="
                ps -eo pid,%mem,comm --sort=-%mem | head -n 6
                echo -e "\n>> enter: open btop <<"
                ;;
            "network")
                INTERFACE=$(ip route get 8.8.8.8 2>/dev/null | awk -- '{print $5; exit}')
                if [ -z "$INTERFACE" ]; then INTERFACE="wlan0"; fi

                R1=$(cat /sys/class/net/$INTERFACE/statistics/rx_bytes)
                T1=$(cat /sys/class/net/$INTERFACE/statistics/tx_bytes)
                sleep 0.4
                R2=$(cat /sys/class/net/$INTERFACE/statistics/rx_bytes)
                T2=$(cat /sys/class/net/$INTERFACE/statistics/tx_bytes)

                RX_BPS=$(( (R2 - R1) * 2 ))
                TX_BPS=$(( (T2 - T1) * 2 ))

                echo -e "=== interface: $INTERFACE ==="
                ip -br a show $INTERFACE
                echo -e "\n=== real-time throughput ==="
                echo -e "down: $(numfmt --to=iec $RX_BPS)/s"
                echo -e "up:   $(numfmt --to=iec $TX_BPS)/s"

                echo -e "\n=== connectivity ==="
                ping -c 1 8.8.8.8 >/dev/null 2>&1 && echo "online" || echo "offline"
                echo -e "\n>> enter: nmtui | alt+s: run speedtest <<"
                ;;
            "ports")
                echo -e "=== listening ports ==="
                ss -tuln | awk 'NR>1 {print $1, $5}' | column -t
                ;;
            "power")
                echo -e "=== cpu governor ==="
                echo "active: $(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor 2>/dev/null)"
                echo -e "\n=== auto-cpufreq ==="
                systemctl is-active --quiet auto-cpufreq && echo "daemon: running" || echo "daemon: stopped"
                echo -e "\n=== thermals ==="
                sensors | awk '/Tctl/ {print "cpu: " $2} /edge/ {print "gpu: " $2} /Composite/ {print "ssd: " $2} /fan1/ {print "fan: " $2 " " $3}'
                ;;
            "media")
                echo -e "=== player ==="
                playerctl status 2>/dev/null || echo "off"
                echo -e "\n=== now playing ==="
                echo -e "$(playerctl metadata --format 'artist: {{artist}}\ntrack:  {{title}}\nalbum:  {{album}}' 2>/dev/null)" || echo "no media."
                echo -e "\n=== volume ==="
                wpctl get-volume @DEFAULT_AUDIO_SINK@ 2>/dev/null | awk '{vol=$2*100; printf "%.0f%%\n", vol}' || echo "n/a"
                echo -e "\n>> enter: pulsemixer | alt+spc: play/pause | alt+k: vol up | alt+j: vol down | alt+m: mute <<"
                ;;
            "workspaces")
                echo -e "=== workspaces ==="
                hyprctl clients | awk '/Window / {in_win=1} /workspace:/ {if(in_win) ws=$2} /class:/ {if(in_win) cls=$2} /title:/ {if(in_win) {title=$0; sub(/^[ \t]*title: /, "", title); printf "[ws %s] %s : %s\n", ws, cls, title; in_win=0}}' | sort -n
                ;;
            "projects")
                echo -e "=== git projects ==="
                ls -d $PROJECTS_DIR/*/ 2>/dev/null | xargs -n1 basename
                echo -e "\n>> enter: open project picker (sesh) <<"
                ;;
            "updates")
                echo -e "=== pending updates ==="
                (checkupdates; yay -Qu) 2>/dev/null | column -t | head -n 20
                echo -e "\n>> enter: update system <<"
                ;;
        esac
        ) | tr '[:upper:]' '[:lower:]'
        exit 0
fi

options="system\nprocesses\nnetwork\nports\npower\nmedia\nworkspaces\nprojects\nupdates"

CHOICE=$(echo -e "$options" | fzf \
    --prompt=" ctrl_ctr> " \
    --border="sharp" \
    --info="hidden" \
    --cycle \
    --bind "ctrl-k:up,ctrl-j:down" \
    --preview="$0 preview {}" \
    --preview-window="right:65%:wrap" \
    --bind "alt-space:execute-silent(if [[ {1} == 'system' ]]; then kitty --class floating_shell -e tray-tui; elif [[ {1} == 'media' ]]; then playerctl play-pause; fi)+refresh-preview" \
    --bind "alt-k:execute-silent(if [[ {1} == 'media' ]]; then wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+; fi)+refresh-preview" \
    --bind "alt-j:execute-silent(if [[ {1} == 'media' ]]; then wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-; fi)+refresh-preview" \
    --bind "alt-m:execute-silent(if [[ {1} == 'media' ]]; then wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle; fi)+refresh-preview" \
    --bind "alt-c:execute-silent(if [[ {1} == 'system' ]]; then ~/.config/waybar/scripts/caffeine.sh; fi)+refresh-preview" \
    --bind "alt-s:execute(if [[ {1} == 'network' ]]; then kitty --class floating_shell -e speedtest; fi)+refresh-preview" \
    --color 'bg:#030303,bg+:#1A1A1A,fg:#B8B8B8,fg+:#eeeeee,border:#4C4C4C,prompt:#eeeeee,header:#888888,pointer:#eeeeee')

if [[ -n "$CHOICE" ]]; then
    $0 execute "$CHOICE"
fi
