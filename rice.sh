#! /usr/bin/sh
sudo pacman --noconfirm -Syu base-devel git
# change the following line to your username
GH_USERNAME=hucancode
# change the following line to your github repository
GH_REPO=home
# checkout configurations
git init
git remote add origin https://github.com/$GH_USERNAME/$GH_REPO
git fetch
git reset origin/main
git checkout -t origin/main
git submodule update --init --recursive
# install yay
git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin && makepkg -si && cd -
# install packages
THEME="sddm arc-gtk-theme"
FONTS="ttf-fira-code ttf-firacode-nerd noto-fonts noto-fonts-cjk noto-fonts-emoji"
WM="hyprland hyprpaper mako grim slurp wl-clipboard"
WM_AUR="eww-wayland ulauncher"
MEDIA="ario alsa-utils ffmpeg mpd mpc mpv gthumb firefox"
FILE_MANAGER_AUR="joshuto"
TERMINAL="alacritty helix exa git-delta"
KEYRING="gnome-keyring"
yay -S --nocleanmenu --noeditmenu --nodiffmenu --noupgrademenu $THEME $FONTS $WM $MEDIA $TERMINAL $KEYRING $WM_AUR $FILE_MANAGER_AUR
