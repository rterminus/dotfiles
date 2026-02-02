HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_ALL_DUPS
setopt SHARE_HISTORY

# Initialize Autocompletion
autoload -Uz compinit
compinit

# Use the Arch-installed plugins
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Monochrome-friendly Autosuggestion color (Gray)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=8"

# Standard ZSH completions
if [ -d /usr/share/zsh/site-functions ]; then
    fpath=(/usr/share/zsh/site-functions $fpath)
fi

eval "$(starship init zsh)"

eval "$(zoxide init zsh)"

eval "$(fzf --zsh)"
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"

eval "$(tmuxifier init -)"

export EDITOR="nvim"
export SUDO_EDITOR="nvim"

alias c='clear'
alias cl='clear && fastfetch'
alias v='nvim'
alias nv='nvim'
alias vim='nvim'
alias fastfetch='fastfetch --logo-type kitty'
alias neofetch='fastfetch'

if command -v eza > /dev/null; then
    alias l='eza -l --icons --git -a'
    alias lt='eza --tree --level=2 --icons'
fi

alias ..='cd ..'
alias ...='cd ../..'

function y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    yazi "$@" --cwd-file="$tmp"
    IFS= read -r -d '' cwd < "$tmp"
    [ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
    rm -f -- "$tmp"
}

clear
fastfetch
