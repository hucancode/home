#! /usr/bin/env fish
# run the following line in bash before running this script
# sudo pacman -Syu fish
chsh -s $(which fish)
sudo pacman -S base-devel git
# change the following line to your username
set GH_USERNAME hucancode
# change the following line to your github repository
set GH_REPO home
# checkout configurations
git init
git remote add origin https://github.com/$GH_USERNAME/$GH_REPO
git fetch
git reset origin/main
git checkout -t origin/main
git submodule update --init --recursive
# install yay
git clone https://aur.archlinux.org/yay-bin.git
begin cd yay-bin; and makepkg -si; end
# install packages
set THEME "lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings arc-gtk-theme"
set FONTS "ttf-fira-code noto-fonts noto-fonts-cjk noto-fonts-emoji"
set WM "openbox rofi yad dunst xdg-user-dirs nitrogen xclip xdotool xorg-xsetroot maim"
set WM_AUR "i3lock-color eww-git ksuperkey"
set MEDIA "alsa-utils ffmpeg mpd mpc mpv viewnior"
set MEDIA_AUR "vieb-bin"
set FILE_MANAGER_AUR "lf"
set TERMINAL "kitty neovim fzf fd ripgrep exa git-delta"
set KEYRING "gnome-keyring libgnome-keyring"
sudo pacman -S $THEME $FONTS $WM $MEDIA $TERMINAL $KEYRING
yay -S $WM_AUR $MEDIA_AUR $FILE_MANAGER_AUR
# neovim first time setting
# nvim -c "PackerInstall"
# wallpaper/icon settings
curl -L -o avatar.png https://github.com/$GH_USERNAME.png; and sudo cp {avatar.png,.config/lightdm/wallpaper.jpg} /usr/share/lightdm-gtk-greeter-settings; and rm avatar.png
sudo mkdir /usr/share/openbox; and sudo mv ~/.config/openbox/icons /usr/share/openbox
sudo systemctl enable lightdm
sudo mkdir -p /etc/lightdm; and sudo cp .config/lightdm/lightdm-gtk-greeter.conf /etc/lightdm
# bloat sections
read -p "Do you wish to add more bloat to you system? [y/N] " yn
switch $yn
	case y Y
	case '*'
		exit 0
end
# install bloats
set PERSONAL_BLOAT "ibus-anthy"
set PERSONAL_BLOAT_AUR "ibus-bamboo megacmd teamviewer"
set DEV_BLOAT "docker docker-compose mono krita clang llvm"
sudo pacman -S $PERSONAL_BLOAT $DEV_BLOAT
yay -S $PERSONAL_BLOAT_AUR
# post-install setup
sudo groupadd docker; and sudo usermod -aG docker $USER
set IBUS_SETTING "\n# Settings for Japanese input\nexport GTK_IM_MODULE=QT_IM_MODULE=XMODIFIERS=@im='ibus'\n# Toolbar for ibus\nibus-daemon -drx"
echo -e ${IBUS_SETTING} >> ~/.xprofile
# steam require multilib, uncomment the [multilib] section in /etc/pacman.conf
sudo pacman -S steam
