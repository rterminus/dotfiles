#!/bin/bash

brightness=$(brightnessctl info | grep -oP '\(\K[^%]+')

dunstify -a "Brilho" -u low -h string:x-dunst-stack-tag:brightness -h int:value:"$brightness" -i display-brightness "Brilho: ${brightness}%"
