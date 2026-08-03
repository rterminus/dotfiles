#!/bin/bash

volume=$(pamixer --get-volume)
is_mute=$(pamixer --get-mute)

if [ "$is_mute" == "true" ]; then
    dunstify -a "volume" -u low -h string:x-dunst-stack-tag:volume -i audio-volume-muted "muted"
else
    dunstify -a "volume" -u low -h string:x-dunst-stack-tag:volume -h int:value:"$volume" -i audio-volume-high "volume: ${volume}%"
fi
