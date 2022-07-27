# dots

The dotfiles for my work laptop and personal desktop. There are slight
differences between the two machines so this git repository has two branches
for both machines. The goal is to have a functional system with 500 or less
packages installed.

## Installing

The core of the dependencies are listed in the
`~/.config/pgklist/pacman-xxx.lst` and `~/.config/pkglist/yay-xxx.lst` files.
The contents of these files will be installed via a script so you can edit
those files and add or remove dependencies you want. A couple of dependencies
are not listed because they need to be cloned from a personal git repository.

### Core

To get started you have to clone this repository and install all the packages
from various systems (pacman, AUR, npm, ruby). This can be done by executing
the following commands:

```bash
 $ git clone https://github.com/SCThijsse/dots.git
 $ shopt -s dotglob     # Enables to move dotfiles
 $ mv dots/* ./
 $ ./.local/scripts/arr # Installs pacman packages, AUR packages, nvm, npm &
                        # node, global npm packages, ruby gems when given the
                        # options.
```

### Suckless

The following suckless tools are used. `dmenu`, `dwm`, `slock`, `slstatus`,
`st`, `surf`, `sxiv` & `tabbed` You can install them via pacman or clone the
patched versions as instructed. If you are using the patched versions the third
step is optional if there is no `patches` folder in the root of the project
folder.

```sh
 $ git clone https://github.com/SCThijsse/<suckless-util>.git
 $ cd <suckless-util>/ &&
 $ find patches/ -type f -print0 | sort -z | xargs -n 1 -0 patch -Np1 -i
 $ sudo make install
```

### Others

#### tmux

Install `tmux` via:

```sh
 $ git clone https://github.com/SCThijsse/.tmux.git
 $ mv .tmux $XDG_CONFIG_HOME/tmux
```

## Backing up dependencies

There is a script located in `~/.local/scripts` called `arb` this script
outputs all the installed packages from pacman, the AUR, npm, and ruby gems to
separate `*.lst` files. These files are used by the `arr` script in the same
directory.

## WMs

This repository has configurations for various WMs. Mainly:
 - dwm      - dynamic tiling WM for X11
 - i3       - manual tiling WM for X11
 - openbox  - floating WM for X11
 - spectrwm - dynamic WM for X11
 - sway     - manual tiling WM for Wayland

#### X11

Programs used with X11:
 - dmenu (https://github.com/SCThijsse/dmenu)
 - dunst
 - feh
 - scrot
 - xclip
 - xautolock
 - xorg-server
 - xorg-xbacklight
 - xorg-xinit

#### Wayland

Programs used with Wayland:
 - brightnessctl (AUR)
 - dmenu (https://github.com/SCThijsse/dmenu)
 - grim
 - mako
 - slurp-git (AUR)
 - wl-clipboard-git (AUR)

### dwm

Supported natively.

 - dwm       - https://github.com/SCThijsse/dwm
 - slock     - https://github.com/SCThijsse/slock
 - slstatus  - https://github.com/SCThijsse/slstatus

### sway & i3

Trying to maintain it because the configuration of sway and i3 look familiar.
So it will be used as a fallback WM. Although you might run into some issues.

**sway:**
 - i3blocks
 - sway-git (AUR)
 - swaydb-git (AUR)
 - swayidle-git (AUR)
 - swaylock-blur-git (AUR)
 - swaylock-git (AUR)
 - wlroots-git (AUR)

**i3:**
 - i3-gaps
 - i3lock-color-git (AUR)
 - i3lock-fancy-rapid-git (AUR)
 - perl-anyevent-i3

### spectrwm

Tried it, liked it, but it is preforming to slow on the work laptop. Regions
has not been configured yet. The configuration in in the 'feat/spectrwm'
branch.

 - spectrwm

### openbox

Not supported anymore, you will certainly run into some problems when using
openbox.

Used in configuration files:
 - cbatticon
 - lxappearance
 - lxappearance-obconf
 - lxsession
 - network-manager-applet
 - obconf
 - obmenu
 - pnmixer (AUR)
 - slim (not configured)
 - tint2

Applications used with openbox:
 - atom-editor-bin
 - evince
 - file-roller
 - galculator
 - krita
 - gvfs
 - gvfs-mtp
 - libreoffice-fresh
 - thunar
 - thunar-archive-plugin
 - viewnior

## Known Issues

This will be a list of known issues with this setup. These issues may be fixed
by the relevant software or may be not fixed at all. I have decided to live
with theses issues, but for your convenience a possible fix is also listed if
available.

 - [M] IntelliJ has a couple of issues with sway; the diff window shows up
   blank, but after dragging the window the content will appear. The other
   issue is with the search file (Double shift) popup, it pops up for a second,
   but immediately disappears again.
 - [L] The image previews in `ranger` with `st` disappear when switching the
   focus to another window.
 - [L] The font displays "tofu" blocks in the Atom popup windows. This is an
   issue with the Terminus font. (Would be fixed by using another font, or a
   patched version of the Terminus font.)

## TODO

A list of things I still want to fix but have not looked into yet. Or
somethings I still want to dive into.

 - [ ] [L] Append layout for sway (https://github.com/swaywm/sway/pull/3022)

## License

MIT License
