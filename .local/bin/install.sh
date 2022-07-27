#!/usr/bin/env sh
#
# Script to reinstall dependencies. See `arb`.
#

# shellcheck source=/dev/null disable=SC2002
base="$HOME/.config/pkglist"

# from: https://github.com/dylanaraps/pure-sh-bible#split-a-string-on-a-delimiter
split() {
    # Disable globbing.
    # This ensures that the word-splitting is safe.
    set -f

    # Store the current value of 'IFS' so we
    # can restore it later.
    old_ifs=$IFS

    # Change the field separator to what we're
    # splitting on.
    IFS=$2

    # Create an argument list splitting at each
    # occurance of '$2'.
    #
    # This is safe to disable as it just warns against
    # word-splitting which is the behavior we expect.
    # shellcheck disable=2086
    set -- $1

    # Print each list value on its own line.
    printf '%s\n' "$@"

    # Restore the value of 'IFS'.
    IFS=$old_ifs

    # Re-enable globbing.
    set +f
}

err() {
    printf '%s\n' "$1"
    exit 1
}

usg() {
    printf '%s\n' "usage arr [arguments]"
    printf '\n'
    printf '%s\n' "Options"
    printf '\t%s\n' "-t - required, either 'laptop' or 'desktop'"
    printf '\t%s\n' "-a - install apm packages"
    printf '\t%s\n' "-c - clone dots project"
    printf '\t%s\n' "-g - install gems packages"
    printf '\t%s\n' "-l - install suckless tools"
    printf '\t%s\n' "-m - enable systemd services"
    printf '\t%s\n' "-n - install npm packages"
    printf '\t%s\n' "-p - install pacman packages"
    printf '\t%s\n' "-r - install rtorrent-vi-color"
    printf '\t%s\n' "-s - apply shell changes"
    printf '\t%s\n' "-v - install nvim plugins"
    printf '\t%s\n' "-x - install tmux config"
    printf '\t%s\n' "-y - install yay with aur packages"
    printf '\t%s\n' "-h - display this"
    exit
}

install_pacman() {
    if [ -n "$pacmanflag" ]; then
        printf '%s\n' "installing pacman packages..."
        sudo pacman -Syyu --needed --noconfirm > /dev/null 2>&1
        cat "$base/pacman-$VARIANT.lst" | xargs sudo pacman -S --needed --noconfirm \
            > /dev/null 2>&1
    fi
}

install_yay() {
    if [ -n "$yayflag" ]; then
        printf '%s\n' "installing yay..."

        aur="https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h="

        curl "${aur}yay" -o PKGBUILD -s
        makepkg -si --noconfirm > /dev/null 2>&1

        rm -rf src pkg yay* PKGBUILD > /dev/null 2>&1

        printf '%s\n' "installing yay packages..."
        cat "$base/yay-$VARIANT.lst" | xargs yay -S --noconfirm \
            > /dev/null 2>&1
    fi
}

install_npm() {
    if [ -n "$npmflag" ]; then
        printf '%s\n' "installing nvm, npm & node..."
        export XDG_CONFIG_HOME="$HOME/.config"
        export NVM_DIR="$XDG_CONFIG_HOME/nvm"
        mkdir -p "$NVM_DIR"

        nvm="https://raw.githubusercontent.com/creationix/nvm/v0.37.2/install.sh"
        curl -o- "$nvm" -s | bash > /dev/null 2>&1

        . "$NVM_DIR/nvm.sh"
        nvm install stable > /dev/null 2>&1
        nvm use stable > /dev/null 2>&1
    fi
}

install_apm() {
    if [ -n "$apmflag" ]; then
        printf '%s\n' "installing npm & apm packages..."
        [ -n "$(command -v apm)" ] && cat "$base/apm-$VARIANT.lst" | apm install
        [ -n "$(command -v npm)" ] && \
            cat "$base/npm-$VARIANT.lst"  | xargs npm install -g > /dev/null 2>&1
    fi
}

install_gems() {
    if [ -n "$gemsflag" ]; then
        printf '%s\n' "installing gem packages..."
        [ -n "$(command -v gem)" ] && \
            cat "$base/gems-$VARIANT.lst" | xargs gem install
    fi
}

install_nvim() {
    if [ -n "$nvimflag" ]; then
        printf '%s\n' "installing nvim plugins..."
        curl -fLo "$HOME/.config/nvim/autoload/plug.vim" --create-dirs "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" --silent
        nvim -c :PlugInstall +qall > /dev/null
    fi
}

install_shell() {
    if [ -n "$shellflag" ]; then
        if [ -z "$(command -v zsh)" ]; then
            sudo pacman -S --needed --noconfirm zsh > /dev/null 2>&1
        fi
        printf '%s\n' "setting default shell as zsh..."
        sudo chsh -s /usr/bin/zsh "$USER" > /dev/null 2>&1
        ln -s -f "$HOME/.profile" "$HOME/.zprofile"

        if [ -z "$(command -v dash)" ]; then
            sudo pacman -S --needed --noconfirm dash >/dev/null 2>&1
        fi
        printf '%s\n' "symlinking sh to dash..."
        # sudo ln -sfT dash /usr/bin/sh
    fi
}

install_suckless_tool() {
    old_dir="$(pwd)"
    printf '\t- %s' "$1"

    workdir="$HOME/Software/$1"
    if [ ! -d "$workdir" ]; then
        link="https://github.com/SCThijsse/$1.git"
        git clone --quiet "$link" "$workdir" > /dev/null
    fi

    if [ -d "$workdir/patches" ]; then
        cd "$workdir" || return
        find "$workdir/patches/" -type f -print0 | sort -z | \
            xargs -n 1 -0 patch -Np1 -i >/dev/null 2>&1
    fi
    sudo make -C "$workdir" --quiet clean install > /dev/null 2>&1

    cd "$old_dir" || return
    printf ' done\n'
}

install_suckless() {
    if [ -n "$sucklessflag" ]; then
        printf '%s\n' "installing suckless tools..."
        mkdir -p "$HOME/Software"

        tools="$(split "$sucklessflag" ",")"
        printf '%s' "$tools" | while IFS= read -r tool || [ -n "$tool" ]; do
            install_suckless_tool "$tool"
        done
    fi
}

install_tmux() {
    if [ -n "$tmuxflag" ]; then
        printf '%s\n' "installing tmux..."
        sudo pacman -S --needed --noconfirm tmux > /dev/null 2>&1
        if [ ! -d "$HOME/.config/tmux" ]; then
            project="tmux"
            printf '%s\n' "cloning $project project"

            link="https://github.com/SCThijsse/.$project.git"
            git clone --quiet "$link" "$HOME/.config/$project" > /dev/null
        fi

        printf '%s\n' "installing tmux config..."
        [ -f "$HOME/.tmux.conf" ] && \
            ln -s -f "$HOME/.config/tmux/.tmux.conf" "$HOME/.tmux.conf"
        [ -f "$HOME/.tmux.conf.local" ] && \
            ln -s -f "$HOME/.config/tmux/.tmux.conf.local" "$HOME/.tmux.conf.local"
    fi
}

install_systemd_service() {
    printf '\t- %s' "$1"
    sudo gpasswd -a "$USER" docker > /dev/null
    sudo gpasswd -a "$USER" lp > /dev/null
    if sudo systemctl enable --now "$1" >/dev/null; then
        printf ' done\n'
    else
        printf ' failed\n'
    fi
}

install_systemd_services() {
    if [ -n "$servicesflag" ]; then
        printf '%s' "setting up systemd services"
        services="$(split "docker,iwd,bluetooth,touchegg" ",")"
        printf '%s' "$services" | while IFS= read -r service || [ -n "$service" ]; do
            install_systemd_service "$service"
        done
    fi
}

install_rtorrent() {
    if [ -n "$rtorrentflag" ]; then
        printf '%s' "installing rtorrent"
        old_dir="$(pwd)"
        project="rtorrent-vi-color"

        workdir="$HOME/Software/$project"
        git clone --quiet "https://github.com/SCThijsse/$project.git" "$workdir" > /dev/null
        cd "$workdir" || return
        makepkg -si > /dev/null

        cd "$old_dir" || return
    fi
}

install_deps() {
    printf '%s\n' "installing dependencies for install.sh script..."
    sudo pacman -S --needed --noconfirm git patch > /dev/null 2>&1
}

clone_project() {
    if [ -n "$cloneflag" ]; then
        project="dots"
        printf '%s\n' "cloning $project project..."

        link="https://github.com/SCThijsse/$project.git"
        git clone --quiet "$link" "$HOME/$project" > /dev/null

        mv "$HOME/$project/"* "$HOME/" > /dev/null 2>&1
        mv "$HOME/$project/".[!.]* "$HOME/" > /dev/null 2>&1
        rm -rf "${HOME:?}/$project" > /dev/null 2>&1
    fi
}

main() {
    while getopts ":acghmnprsvxuy" opt; do
        case "$opt" in
            t)  VARIANT="$OPTARG" ;;
            a)  apmflag="true" ;;
            c)  cloneflag="true" ;;
            g)  gemsflag="true" ;;
            n)  npmflag="true" ;;
            m)  servicesflag="true" ;;
            p)  pacmanflag="true" ;;
            r)  rtorrentflag="true" ;;
            s)  shellflag="true" ;;
            u)  sucklessflag="dmenu,dwm,dwmblocks,slock,st,sxiv,sxiv,tabbed" ;;
            v)  nvimflag="true" ;;
            x)  tmuxflag="true" ;;
            y)  yayflag="true" ;;
            h)  usg ;;
            \?) err "invalid option: -$OPTARG" >&2 ;;
            :)  err "option -$OPTARG requires an argument" >&2 ;;
        esac
    done

    VARIANT="${VARIANT:-desktop}"
    # throw errors when needed
    [ "$VARIANT" != "laptop" ] && [ "$VARIANT" != "desktop" ] && \
        err "error: -t flag argument can only be 'laptop' or 'desktop'"

    install_deps
    clone_project

    install_pacman
    install_yay
    install_npm
    install_apm
    install_gems
    install_nvim
    install_shell
    install_suckless
    install_tmux
    install_systemd_services
    install_rtorrent

    printf '%s\n' "finished."
}

if [ "$#" -eq 0 ]; then
    main -acgnmprsuvxy
else
    main "$@"
fi

