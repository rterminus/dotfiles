#!/bin/bash

brightness=$(brightnessctl info | grep -oP '\(\K[^%]+')

dunstify -a "brightness" -u low -h string:x-dunst-stack-tag:brightness -h int:value:"$brightness" -i display-brightness "brightness: ${brightness}%"
