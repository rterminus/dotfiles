#!/usr/bin/env bash

languages=$(echo "cpp c lua python bash javascript html css" | tr ' ' '\n')
core_utils=$(echo "find xargs sed awk grep nmap tcpdump curl tar tmux" | tr ' ' '\n')

selected=$(echo -e "$languages\n$core_utils" | fzf --prompt="Cheat.sh > " --layout=reverse --border)

if [[ -z $selected ]]; then
    exit 0
fi

read -p "$selected (Query): " query

query=$(echo $query | tr ' ' '+')

if echo "$languages" | grep -qs $selected; then
    curl -s cht.sh/$selected/$query | less -R
else
    curl -s cht.sh/$selected~$query | less -R
fi
