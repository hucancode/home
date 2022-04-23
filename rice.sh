sudo pacman -Syu
# change the following line to your username
GH_USERNAME=hucancode
# change the following line to your github repository
GH_REPO=home
BASE="dhcpcd base-devel git"
THEME="lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings arc-gtk-theme"
WM="bspwm sxhkd openbox rofi yad dunst xdg-user-dirs nitrogen xclip xdotool maim"
MEDIA="ffmpeg ffmpegthumbnailer mpd mpc ncmpcpp mpv"
FILE_MANAGER="thunar thunar-volman xarchiver thunar-archive-plugin ranger ueberzug"
TERMINAL="alacritty zsh zsh-theme-powerlevel10k helix fzf fd"
FONTS="noto-fonts noto-fonts-cjk noto-fonts-emoji"
KEYRING="gnome-keyring libgnome-keyring"

sudo pacman -S $BASE $THEME $WM $MEDIA $FILE_MANAGER $TERMINAL $FONTS $KEYRING
chsh -s $(which zsh)

git clone https://aur.archlinux.org/yay-bin.git
(cd yay-bin && makepkg -si)
yay -S polybar ksuperkey qogir-icon-theme vimix-cursors i3lock-color

git clone https://github.com/$GH_USERNAME/$GH_REPO
mv $GH_REPO/* . && rm -rf $GH_REPO
git submodule update --init
curl -L -o avatar.png https://github.com/$GH_USERNAME.png && sudo cp {avatar.png,.config/lightdm/wallpaper.jpg} /usr/share/lightdm-gtk-greeter-settings && rm avatar.png
sudo systemctl enable lightdm
sudo mkdir -p /etc/lightdm
sudo cp .config/lightdm/lightdm-gtk-greeter.conf /etc/lightdm

read -p "Do you wish to add more bloat to you system? [y/N] " yn
case $yn in
	[Yy]* ) ;;
	* ) exit 0;;
esac

sudo pacman -S ibus-anthy docker docker-compose mono gimp inkscape clang llvm
sudo groupadd docker && sudo usermod -aG docker $USER
yay -S google-chrome visual-studio-code-bin ibus-bamboo megacmd
IBUS_SETTING="\n# Settings for Japanese input\nexport GTK_IM_MODULE=QT_IM_MODULE=XMODIFIERS=@im='ibus'\n# Toolbar for ibus\nibus-daemon -drx"
echo -e ${IBUS_SETTING} >> ~/.xprofile

# steam require multilib, uncomment the [multilib] section in /etc/pacman.conf
sudo pacman -S steam