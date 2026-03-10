#!/bin/bash

volume=$(pamixer --get-volume)
is_mute=$(pamixer --get-mute)

if [ "$is_mute" == "true" ]; then
    dunstify -a "Volume" -u low -h string:x-dunst-stack-tag:volume -i audio-volume-muted "Mutado"
else
    dunstify -a "Volume" -u low -h string:x-dunst-stack-tag:volume -h int:value:"$volume" -i audio-volume-high "Volume: ${volume}%"
fi
