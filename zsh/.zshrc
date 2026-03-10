HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_ALL_DUPS
setopt SHARE_HISTORY

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
eval "$(fzf --zsh)"
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"

eval "$(tmuxifier init -)"

# exports
export EDITOR="nvim"
export SUDO_EDITOR="nvim"
export PAGER="bat"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# aliases
alias cat='bat --style=plain --paging=never'
alias preview='bat --style=numbers --color=always'
alias q='exit'
alias c='clear'
alias cff='clear && fastfetch'
alias v='nvim'
alias nv='nvim'
alias vim='nvim'
alias fastfetch='fastfetch --config ~/.config/fastfetch/config.jsonc'
alias ff='fastfetch --config ~/.config/fastfetch/config.jsonc'
alias ..='cd ..'
alias ...='cd ../..'
if command -v eza > /dev/null; then
    alias l='eza -l --icons --git -a'
    alias lt='eza --tree --level=2 --icons'
fi

function y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    yazi "$@" --cwd-file="$tmp"
    IFS= read -r -d '' cwd < "$tmp"
    [ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
    rm -f -- "$tmp"
}

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
