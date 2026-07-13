#!/bin/bash

BRAIN_DIR="$HOME/second-brain"

z "$BRAIN_DIR" || exit

if [[ -n $(git status -s) ]]; then
    git add .
    git commit -m "sync: automatic backup on $(date +'%Y-%m-%d %H:%M')"
    
    git push origin main
fi
