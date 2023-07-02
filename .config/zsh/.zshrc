if [ -z $TMUX ] && [ -z $SKIP_TMUX ]; then
    session=$(tmux list-sessions -F "#{session_attached} #{session_id}" 2>/dev/null | awk '/^0/ {print substr($2, 2)}' | head --line 1)
    if [ -z $session ]; then
        exec tmux new-session
    else
        exec tmux attach-session -t $session
    fi
fi

setopt autocd              # change directory just by typing its name
setopt interactivecomments # allow comments in interactive mode
setopt magicequalsubst     # enable filename expansion for arguments of the form ‘anything=expression’
setopt nonomatch           # hide error message if there is no match for the pattern
setopt notify              # report the status of background jobs immediately
setopt numericglobsort     # sort filenames numerically when it makes sense
setopt promptsubst         # enable command substitution in prompt

export MANPAGER="sh -c 'col -bx | bat -l man -p'"

export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

export SAVEHIST=1000000

setopt HIST_IGNORE_ALL_DUPS     # do not put duplicated command into history list
setopt HIST_SAVE_NO_DUPS        # do not save duplicated command
setopt HIST_REDUCE_BLANKS       # remove unnecessary blanks
setopt INC_APPEND_HISTORY_TIME  # append command to history file immediately after execution
setopt EXTENDED_HISTORY         # record command start time

autoload -Uz compinit
compinit -d ~/.cache/zcompdump
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' rehash true
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'
_comp_options+=(globdots)

if [ -d ~/.config/emacs/bin ]; then
    export PATH=~/.config/emacs/bin/:$PATH
fi

[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"

plug "zap-zsh/supercharge"
plug "zsh-users/zsh-autosuggestions"
plug "zdharma-continuum/fast-syntax-highlighting"
plug "MichaelAquilina/zsh-you-should-use"
plug "zsh-users/zsh-history-substring-search"

# Pretty print json tools
source ~/.config/zsh/plugins/jsontools.plugin.zsh

function zvm_config() {
    ZVM_LINE_INIT_MODE=$ZVM_MODE_INSERT
    ZVM_VI_INSERT_ESCAPE_BINDKEY=jk
}
# Improved vi mode for zsh
source /usr/share/zsh/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh

# Keys for history search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

emacs() {
    emacsclient "$@" 2>/dev/null || emacs "$@"
}

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'

if [ -f /usr/bin/zoxide ]; then
    alias cd='z'
    alias zz='z -'
fi

if [ -f /usr/bin/exa ]; then
    alias ls='exa -al --color=always --group-directories-first --icons'
    alias la='exa -a --color=always --group-directories-first --icons'
    alias ll='exa -l --color=always --group-directories-first --icons'
    alias lt='exa -aT --color=always --group-directories-first --icons'
    alias l.="exa -a | grep -E '^\.'"
fi

if [ -f /usr/bin/docker ]; then
    alias dps='docker ps -a'
    alias dc='docker'
    alias dci='docker images'
    alias dcp='docker container prune'
fi

if [ -f /usr/bin/tmux ]; then
    alias tls='tmux list-sessions 2>/dev/null'
fi

alias zc='$EDITOR $HOME/.config/zsh/.zshrc'
alias zsc='source $HOME/.config/zsh/.zshrc'

alias p='ipython --no-banner --no-confirm-exit'
alias psv='source ./venv/bin/activate'
alias pcv='python -m venv venv'

alias gc="git commit -m"
alias ga="git add"
alias gp="git push"
alias gs="git status"

alias c="source ~/.config/scripts/cdier.sh"
alias cls="clear"
alias sf="fc-list | grep -i"
alias sudo="sudo "
alias yt-audio="yt-dlp -x --audio-format mp3 --audio-quality 0"
alias speedtest="curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python -"
alias v="emacs"
alias cat="bat"
alias wget="wget -c "
alias grep="grep --color=auto"
alias hw="hwinfo --short"
alias tb="curl -F "file=@-" gcg.sh"
alias ipa="ip --brief address"

eval "$(navi widget zsh)" # Ctrl + G

eval "$(starship init zsh)"

eval "$(zoxide init zsh)"
