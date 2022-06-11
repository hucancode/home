#!/usr/bin/env fish
# run the following line in bash before running this script
# sudo pacman -Syu fish && chsh -s $(which fish)
sudo pacman -S base-devel git
# change the following line to your username
set GH_USERNAME hucancode
# change the following line to your github repository
set GH_REPO home
# install yay
git clone https://aur.archlinux.org/yay-bin.git
begin cd yay-bin; and makepkg -si; end
# install packages
set THEME "lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings arc-gtk-theme"
set WM "bspwm sxhkd openbox rofi yad dunst xdg-user-dirs nitrogen xclip xdotool xorg-xsetroot maim picom"
set WM_AUR "i3lock-color eww-git ksuperkey"
set MEDIA "alsa-utils ffmpeg mpd mpc mpv viewnior chromium"
set FILE_MANAGER "ranger python-pillow meld"
set TERMINAL "kitty neovim starship fzf fd ripgrep zoxide exa sd"
set FONTS "ttf-fira-code noto-fonts noto-fonts-cjk noto-fonts-emoji"
set KEYRING "gnome-keyring libgnome-keyring"
sudo pacman -S $THEME $WM $MEDIA $FILE_MANAGER $TERMINAL $FONTS $KEYRING
yay -S $WM_AUR
# rice settings
git clone https://github.com/$GH_USERNAME/$GH_REPO
mv $GH_REPO/* . ; and rm -rf $GH_REPO
curl -L -o avatar.png https://github.com/$GH_USERNAME.png; and sudo cp {avatar.png,.config/lightdm/wallpaper.jpg} /usr/share/lightdm-gtk-greeter-settings; and rm avatar.png
sudo mkdir /usr/share/openbox; sudo mv ~/.config/openbox/icons /usr/share/openbox
sudo systemctl enable lightdm
sudo mkdir -p /etc/lightdm
sudo cp .config/lightdm/lightdm-gtk-greeter.conf /etc/lightdm
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
set DEV_BLOAT "docker docker-compose mono gimp inkscape clang llvm"
sudo pacman -S $PERSONAL_BLOAT $DEV_BLOAT
yay -S $PERSONAL_BLOAT_AUR
# post-install setup
sudo groupadd docker; and sudo usermod -aG docker $USER
set IBUS_SETTING "\n# Settings for Japanese input\nexport GTK_IM_MODULE=QT_IM_MODULE=XMODIFIERS=@im='ibus'\n# Toolbar for ibus\nibus-daemon -drx"
echo -e ${IBUS_SETTING} >> ~/.xprofile
# steam require multilib, uncomment the [multilib] section in /etc/pacman.conf
sudo pacman -S steam
