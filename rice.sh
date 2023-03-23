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
THEME="lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings arc-gtk-theme"
FONTS="ttf-fira-code noto-fonts noto-fonts-cjk noto-fonts-emoji"
WM="openbox rofi yad dunst xdg-user-dirs nitrogen xclip xdotool xorg-xsetroot maim"
WM_AUR="i3lock-color eww-git ksuperkey"
MEDIA="alsa-utils ffmpeg mpd mpc mpv viewnior mousepad"
MEDIA_AUR="vieb-bin"
FILE_MANAGER_AUR="lf"
TERMINAL="kitty neovim fzf fd ripgrep exa git-delta"
KEYRING="gnome-keyring libgnome-keyring"
yay -S --nocleanmenu --noeditmenu --nodiffmenu --noupgrademenu $THEME $FONTS $WM $MEDIA $TERMINAL $KEYRING $WM_AUR $MEDIA_AUR $FILE_MANAGER_AUR
# neovim first time setting
nvim -c "PackerInstall" -c "qa"
# wallpaper/icon settings
curl -L -o avatar.png https://github.com/$GH_USERNAME.png && sudo cp {avatar.png,.config/lightdm/wallpaper.jpg} /usr/share/lightdm-gtk-greeter-settings && rm avatar.png
sudo mkdir /usr/share/openbox && sudo mv .config/openbox/icons /usr/share/openbox
sudo systemctl enable lightdm
sudo mkdir -p /etc/lightdm && sudo cp .config/lightdm/lightdm-gtk-greeter.conf /etc/lightdm
