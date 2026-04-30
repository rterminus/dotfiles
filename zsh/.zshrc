HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_ALL_DUPS
setopt SHARE_HISTORY
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS

autoload -Uz compinit
compinit

source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=8"

if [ -d /usr/share/zsh/site-functions ]; then
    fpath=(/usr/share/zsh/site-functions $fpath)
fi

ZVM_VI_INSERT_ESCAPE_BINDKEY="jj"
source /usr/share/zsh/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh

function zvm_after_init() {
    eval "$(starship init zsh)"
}
eval "$(zoxide init zsh)"
eval "$(tv init zsh)"
eval "$(fzf --zsh)"
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_DEFAULT_OPTS=" \
    --layout=reverse \
    --info=inline \
    --border=rounded \
    --prompt='> ' \
    --pointer='>' \
    --marker='*' \
    --color='fg:-1,bg:-1,fg+:-1,bg+:8' \
    --color='hl:4,hl+:12,info:3,prompt:2,pointer:1,marker:5,spinner:6,header:6'"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type d --hidden --strip-cwd-prefix --exclude .git"
export BAT_STYLE="numbers,changes"

eval "$(tmuxifier init -)"

# exports
export EDITOR="nvim"
export SUDO_EDITOR="nvim"
export PAGER="bat"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export PATH="$HOME/.cargo/bin:$PATH"

# aliases
alias cat='bat --style=plain --paging=never'
alias preview='bat --style=numbers --color=always'
alias q='exit'
alias c='clear'
alias g='git'
alias cff='clear && fastfetch'
alias v='nvim'
alias nv='nvim'
alias vim='nvim'
alias ff='fastfetch --config ~/.config/fastfetch/config.jsonc'
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'
alias hypr-start='~/dotfiles/bin/hypr-start.sh'
alias pkgupd='sudo pacman -Syyu && yay -Syyu'
if command -v eza > /dev/null; then
    alias ls='eza --icons'
    alias ll='eza -l --icons --git --group-directories-first'
    alias la='eza -la --icons --git --group-directories-first'
    alias lt='eza -l --tree --level=2 --icons --git --group-directories-first'
    alias lti='eza -l --tree --level=2 --icons --git --git-ignore --group-directories-first'
    alias ld='eza -lD --icons --git'
fi

function y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    yazi "$@" --cwd-file="$tmp"
    IFS= read -r -d '' cwd < "$tmp"
    [ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
    rm -f -- "$tmp"
}

function ex() {
    if [ -f "$1" ] ; then
        case "$1" in
            *.tar.bz2)   tar xjf "$1"   ;;
            *.tar.gz)    tar xzf "$1"   ;;
            *.bz2)       bunzip2 "$1"   ;;
            *.rar)       unrar x "$1"   ;;
            *.gz)        gunzip "$1"    ;;
            *.tar)       tar xf "$1"    ;;
            *.tbz2)      tar xjf "$1"   ;;
            *.tgz)       tar xzf "$1"   ;;
            *.zip)       unzip "$1"     ;;
            *.Z)         uncompress "$1";;
            *.7z)        7z x "$1"      ;;
            *.tar.xz)    tar xf "$1"    ;;
            *)           echo "'$1' cannot be extracted by ex()" ;;
        esac
    else
        echo "'$1' not a valid file"
    fi
}

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

export PATH=$PATH:/home/terminus/.spicetify
