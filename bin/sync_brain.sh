#!/bin/bash

PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

BRAIN_DIR="/home/terminus/second-brain"

DOTFILES_DIR="/home/terminus/dotfiles"

cd "$BRAIN_DIR"

if [[ -n $(git status -s) ]]; then
    git add .
    git commit -m "sync: backup on $(date +'%Y-%m-%d %H:%M')"
    
    GIT_SSH_COMMAND="ssh -i /home/terminus/.ssh/id_ed25519 -o StrictHostKeyChecking=no" git push origin main
fi

cd "$DOTFILES_DIR" || exit

if [[ -n $(git status -s) ]]; then
    git add .
    git commit -m "sync: backup on $(date +'%Y-%m-%d %H:%M')"
    
    GIT_SSH_COMMAND="ssh -i /home/terminus/.ssh/id_ed25519 -o StrictHostKeyChecking=no" git push origin main
fi
