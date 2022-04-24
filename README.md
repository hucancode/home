# Hello 👋
This is my personal ricing setup. Powered by [Arch](https://archlinux.org/). Heavily influenced by [Archcraft](https://archcraft.io/).
<details>
  <summary> What is ricing? </summary>
    The term ‘rice’ is used to describe a person’s unix desktop where ‘ricing’ is when someone is custom their desktop such as the icons, panels, or system interface. When it comes to ricing a tiling window manager though, the ricing of a user’s system becomes much more involved. Basic things such as the panel bar and application launcher must be configured by the user.
    The reddit community /r/unixporn is a great place to stay up to date on what people are using for their setups.
    // by [thatnixguy](https://thatnixguy.github.io/)
</details>

## ✨ Features:
- 🪟 Window manager, [bspwm](https://wiki.archlinux.org/title/bspwm), [sxhkd](https://wiki.archlinux.org/title/sxhkd). `bspwm` is pretty harsh, if something went wrong you are welcomed with a black screen and no mouse/keyboard input. In case `bspwm` didn't work or you just don't like a tiling window manager, login with [openbox](https://wiki.archlinux.org/title/openbox)
- 🔑 Display manager (the login thing) [lightdm](https://wiki.archlinux.org/title/lightdm)
- 📊 Status bar [polybar](https://wiki.archlinux.org/title/polybar)
- 🚀 Program launcher [rofi](https://wiki.archlinux.org/title/rofi)
- 🔔 Notification panel [dunst](https://wiki.archlinux.org/title/dunst)
- 📂 File manager [ranger](https://wiki.archlinux.org/title/Ranger)
- 📋 Text editor [helix](https://helix-editor.com/)
- 🐱 Terminal emulator [zsh](https://wiki.archlinux.org/title/zsh), [kitty](https://wiki.archlinux.org/title/Kitty)
- 🎧 Music player [mpd](https://wiki.archlinux.org/title/Music_Player_Daemon)
# 👀 Screenshots
![](Pictures/Screenshots/1.png)
![](Pictures/Screenshots/2.png)
![](Pictures/Screenshots/3.png)
![](Pictures/Screenshots/4.png)
![](Pictures/Screenshots/5.png)
# 🚀 Installation
## 🐌 TL;DR
Use this script 
```bash
git clone https://github.com/hucancode/home
mv home/* . && rm -rf home
git submodule update --init
chmod +x rice.sh && ./rice.sh
```
## ⚙️ Install Arch
Assume that you use `archinstall`. Make sure you use `pulseaudio` instead of `pipewire` for audio driver. `polybar` doesn't work well with `pipewire` yet.
## 🌾 Checkout rice configurations
My `~` folder is a git repo with `.gitignore` set to `*`. That's super convenient, I recommend you doing the same.
```bash
git clone https://github.com/hucancode/home
mv home/* . && rm -rf home
git submodule update --init
```
## 📦 Install softwares
```bash
sudo pacman -Syu base-devel git
# install packages
THEME="lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings arc-gtk-theme"
WM="bspwm sxhkd openbox rofi yad dunst xdg-user-dirs nitrogen xclip xdotool maim"
MEDIA="ffmpeg mpd mpc ncmpcpp mpv"
FILE_MANAGER="ranger python-pillow"
TERMINAL="zsh kitty helix fzf fd"
FONTS="noto-fonts noto-fonts-cjk noto-fonts-emoji"
KEYRING="gnome-keyring libgnome-keyring"
sudo pacman -S $THEME $WM $MEDIA $FILE_MANAGER $TERMINAL $FONTS $KEYRING
```
Install `yay`
```bash
git clone https://aur.archlinux.org/yay-bin.git
(cd yay-bin && makepkg -si)
```
Use `yay` to install what's missing
```bash
THEME_AUR="vimix-cursors i3lock-color"
WM_AUR="polybar ksuperkey"
yay -S $THEME_AUR $WM_AUR
```
## 🐚 Change default shell to zsh
```bash
chsh -s $(which zsh)
```
## 🔑 Config `lightdm`
Copy avatar and wallpaper to somewhere `lightdm` have access to.
```bash
curl -L -o avatar.png https://github.com/hucancode.png && sudo cp {avatar.png,.config/lightdm/wallpaper.jpg} /usr/share/lightdm-gtk-greeter-settings && rm avatar.png
```
You can alternatively put those picture at `~` and give `lightdm` access to your `~` folder
Set `lightdm` as your default display manager.
```bash
systemctl enable lightdm;
```
Enable `lightdm-gtk-greeter` (`lightdm` default to gtk greeter, but just in case something went wrong, please check `lightdm.conf`)
```bash
helix /etc/lightdm/lightdm.conf
# enable [Seat:*]
# ...
# greeter-session=lightdm-gtk-greeter
# ...
```
Rice your greeter with this
```bash
lightdm-gtk-greeter-settings
# select theme, wallpaper, avatar
```
This is how `/etc/lightdm/lightdm-gtk-greeter.conf` should looks like after configuration. Alternatively you can skip GUI setting program and straight up copy this.
```ini
[greeter]
background = /usr/share/lightdm-gtk-greeter-settings/wallpaper.jpg
default-user-image = /usr/share/lightdm-gtk-greeter-settings/avatar.jpeg
theme-name = Arc-Dark
icon-theme-name = Qogir-dark
indicators = ~spacer;~clock;~spacer;~session;~power
```
## 🎧 Config `mpd`
Assume that `mpd` is running safe and sound, if not, check for `~/.config/mpd/mpd.conf`. My configuration looks like this:
```bash
pid_file "~/.config/mpd/mpd.pid"
state_file "~/.config/mpd/mpdstate"
db_file "~/.config/mpd/database"
music_directory "~/Music"
playlist_directory "~/.config/mpd/playlists"

audio_output {
    type  "pulse"
    name  "pulse audio"
}
```
Open `ncmpcpp` and edit your playlist
```bash
ncmpcpp
# press 2 to open browse
# select your folder and press A to add all songs in that folder to playelist
# or press 4 to open library
# press space to add current song to playlist
```
