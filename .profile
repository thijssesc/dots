#!/usr/bin/env sh
#
# ~/.profile
#

# shellcheck source=/dev/null

# General environment variables
export EDITOR=nvim
export LC_TYPE=UTF-8
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export NVM_DIR="$XDG_CONFIG_HOME/nvm"
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

# XDG support for various applications
export _JAVA_OPTIONS="-Djava.util.prefs.userRoot=$XDG_CONFIG_HOME/java"
export ANDROID_SDK_HOME="$XDG_CONFIG_HOME/android"
export ANSIBLE_CONFIG="${XDG_CONFIG_HOME}/ansible.cfg"
export ANSIBLE_GALAXY_CACHE_DIR="${XDG_CACHE_HOME}/ansible/galaxy_cache"
export ANSIBLE_HOME="$XDG_CONFIG_HOME/ansible"
export ANSIBLE_HOME="${XDG_CONFIG_HOME}/ansible"
export ATOM_HOME="$XDG_CONFIG_HOME/atom"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"
export GEM_HOME="$XDG_CONFIG_HOME/gem"
export GEM_SPEC_CACHE="$XDG_CACHE_HOME/gem"
export GNUPGHOME="$XDG_CONFIG_HOME/gnupg"
export GOPATH="$XDG_DATA_HOME/go"
export GRADLE_USER_HOME="$XDG_CONFIG_HOME/gradle"
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc"
export GTK_RC_FILES="$XDG_CONFIG_HOME/gtk-1.0/gtkrc"
export HISTFILE="$XDG_DATA_HOME/bash/history"
export IDEA_PROPERTIES="$XDG_CONFIG_HOME/intellij-idea/idea.properties"
export IDEA_WM_OPTIONS="$XDG_CONFIG_HOME/intellij-idea/idea.vmoptions"
export INPUTRC="$XDG_CONFIG_HOME/readline/inputrc"
export KUBECACHEDIR="$XDG_CACHE_HOME/kube"
export KUBECONFIG="$XDG_CONFIG_HOME/kube"
export LESSHISTFILE="$XDG_CACHE_HOME/lesshst"
export MACHINE_STORAGE_PATH="$XDG_DATA_HOME/docker-machine"
export MINIKUBE_HOME="$XDG_DATA_HOME/minikube"
export NODE_REPL_HISTORY="$XDG_DATA_HOME/node_repl_history"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export PASSWORD_STORE_DIR="$XDG_CONFIG_HOME/pass"
export SSB_HOME="$XDG_DATA_HOME/zoom"
export TMUX_TMPDIR="$XDG_RUNTIME_DIR"
export VAGRANT_ALIAS_FILE="$XDG_DATA_HOME/vagrant/aliases"
export VAGRANT_HOME="$XDG_DATA_HOME/vagrant"
export WINEPREFIX="$XDG_DATA_HOME/wineprefixes/default"
export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"
export XINITRC="$XDG_CONFIG_HOME/X11/xinitrc"
export XSERVERRC="$XDG_CONFIG_HOME/X11/xserverrc"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh/"

# Set clipboard variable based on wayland
if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
  export CLIPBOARD=wl-copy
else
  export CLIPBOARD=xclip
fi

# nnn config
export NNN_BMS="D:~/Documents;d:~/Downloads;E:/etc/;i:~/IdeaProjects;h:~/;m:/mnt;p:~/Pictures;S:~/Software;c:~/.config;s:~/.local/scripts"
export NNN_PLUG="d:dps;i:mnf;m:nmt;s:sxv"
export NNN_TMPFILE="$XDG_CONFIG_HOME/nnn/.lastd"
export NNN_OPENER="gio open"
export NNN_COPIER="$CLIPBOARD"
[ -n "$NNNLVL" ] && PS1="N$NNNLVL $PS1"

# Other environment variables
export _JAVA_AWT_WM_NONREPARENTING=1

# bemenu options
. "$HOME/.local/scripts/clr"
background="$(background)"
foreground="$(foreground)"
blue="$(colors 4)"
red="$(colors 1)"
export BEMENU_OPTS="--cb $background --cf $background --fb $background --ff $foreground --nb $background --nf $foreground --hb $blue --hf $background --tb $background --tf $red --ab $background --af $foreground"

# Add bin & scripts to path
[ -d "$HOME/.local/bin" ] && PATH="$PATH:$HOME/.local/bin"
[ -d "$HOME/.local/scripts" ] && PATH="$PATH:$HOME/.local/scripts"

# Add $GOPATH/bin to path
[ -d "$GOPATH/bin" ] && PATH="$PATH:$GOPATH/bin"

# Add "$HOME/.local/share/nvim/mason/bin" to path
[ -d "$HOME/.local/share/nvim/mason/bin" ] && PATH="$PATH:$HOME/.local/share/nvim/mason/bin"

# Add "$HOME/.local/share/bob/nvim-bin" to path
[ -d "$HOME/.local/share/bob/nvim-bin" ] && PATH="$PATH:$HOME/.local/share/bob/nvim-bin"

# Add "/opt/zscaler/bin" to path
[ -d "/opt/zscaler/bin" ] && PATH="$PATH:/opt/zscaler/bin"

# Export secrets
[ -s "$HOME/.local/scripts/scr" ] && . "$HOME/.local/scripts/scr"

# Set if is desktop or laptop based if machine has wifi
if [ "$(lsmod | grep -ic iwlwifi)" -gt 0 ]; then
    export TOP_TYPE="laptop"
else
    export TOP_TYPE="desktop"
fi

if [ -z "$DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
    MOZ_ENABLE_WAYLAND=1 XKB_DEFAULT_LAYOUT=us exec hyprland
elif [ -z "$DISPLAY" ] && [ "$(tty)" = "/dev/tty2" ]; then
    exec startx "$XDG_CONFIG_HOME/X11/xinitrc" dwm
elif [ -z "$DISPLAY" ] && [ "$(tty)" = "/dev/tty3" ]; then
    exec startx "$XDG_CONFIG_HOME/X11/xinitrc" awesome
fi

# If running bash include the ~/.bashrc file
printf '%s' "$0" | grep "bash$" >/dev/null &&
  [ -f "$XDG_CONFIG_HOME/bashrc" ] && . "$XDG_CONFIG_HOME/bashrc"
