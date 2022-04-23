sudo pacman -Syu base-devel git
# change the following line to your username
GH_USERNAME=hucancode
# change the following line to your github repository
GH_REPO=home
# install yay
git clone https://aur.archlinux.org/yay-bin.git
(cd yay-bin && makepkg -si)
# install packages
THEME="lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings arc-gtk-theme"
THEME_AUR="vimix-cursors i3lock-color"
WM="bspwm sxhkd openbox rofi yad dunst xdg-user-dirs nitrogen xclip xdotool maim"
WM_AUR="polybar ksuperkey"
MEDIA="ffmpeg mpd mpc ncmpcpp mpv viewnior"
FILE_MANAGER="ranger ueberzug"
TERMINAL="zsh alacritty helix fzf fd"
FONTS="noto-fonts noto-fonts-cjk noto-fonts-emoji"
KEYRING="gnome-keyring libgnome-keyring"
sudo pacman -S $THEME $WM $MEDIA $FILE_MANAGER $TERMINAL $FONTS $KEYRING
yay -S $THEME_AUR $WM_AUR
# set default shell to zsh
chsh -s $(which zsh)
# rice settings
git clone https://github.com/$GH_USERNAME/$GH_REPO
mv $GH_REPO/* . && rm -rf $GH_REPO
git submodule update --init
curl -L -o avatar.png https://github.com/$GH_USERNAME.png && sudo cp {avatar.png,.config/lightdm/wallpaper.jpg} /usr/share/lightdm-gtk-greeter-settings && rm avatar.png
sudo systemctl enable lightdm
sudo mkdir -p /etc/lightdm
sudo cp .config/lightdm/lightdm-gtk-greeter.conf /etc/lightdm
# bloat sections
read -p "Do you wish to add more bloat to you system? [y/N] " yn
case $yn in
	[Yy]* ) ;;
	* ) exit 0;;
esac
PERSONAL_BLOAT="ibus-anthy"
PERSONAL_BLOAT_AUR="ibus-bamboo"
QOL_BLOAT="thunar thunar-volman xarchiver thunar-archive-plugin ffmpegthumbnailer"
QOL_BLOAT_AUR="qogir-icon-theme google-chrome megacmd"
DEV_BLOAT="docker docker-compose mono gimp inkscape clang llvm"
DEV_BLOAT_AUR="visual-studio-code-bin"
sudo pacman -S $PERSONAL_BLOAT $QOL_BLOAT $DEV_BLOAT
yay -S $PERSONAL_BLOAT_AUR $QOL_BLOAT_AUR $DEV_BLOAT_AUR
# post-install setup
sudo groupadd docker && sudo usermod -aG docker $USER
IBUS_SETTING="\n# Settings for Japanese input\nexport GTK_IM_MODULE=QT_IM_MODULE=XMODIFIERS=@im='ibus'\n# Toolbar for ibus\nibus-daemon -drx"
echo -e ${IBUS_SETTING} >> ~/.xprofile
# steam require multilib, uncomment the [multilib] section in /etc/pacman.conf
sudo pacman -S steam