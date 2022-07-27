#! /usr/bin/env zsh
#
# $XDG_CONFIG_HOME/zsh/.zshrc
#

# shellcheck source=/dev/null

# Enable colors and change prompt:
autoload -U colors && colors
PS1=" %F{white}%~ %B>>%F{blue}>%F{white}%b "

# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE="$XDG_CACHE_HOME/zsh/history"
TERM=screen-256color

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit -d "$XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION"
_comp_options+=(globdots)		# Include hidden files.

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Reverse search
bindkey '^R' history-incremental-search-backward

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# nvm support
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

# Include aliases and functions
[ -f "$XDG_CONFIG_HOME/bash/aliases" ] && \
    . "$XDG_CONFIG_HOME/bash/aliases"
[ -f "$XDG_CONFIG_HOME/bash/functions" ] && \
    . "$XDG_CONFIG_HOME/bash/functions"

# Include shortcuts
[ -f "$XDG_CONFIG_HOME/bash/shortcuts" ] && \
    . "$XDG_CONFIG_HOME/bash/shortcuts"

# Git aliases
for al in $(git --list-cmds=alias); do
  # shellcheck disable=SC2139,2086
  alias g$al="git $al"
done

# Display some info
icy

# Terminal Aliases
[ -f "$XDG_CONFIG_HOME/bash/taliases" ] && \
    . "$XDG_CONFIG_HOME/bash/taliases"

# Load zsh-syntax-highlighting; should be last.
[ -f "$XDG_CONFIG_HOME/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ] && \
    . "$XDG_CONFIG_HOME/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" \
    > /dev/null
