# Hello π
This is my personal ricing setup. Powered by [Arch](https://archlinux.org/). Heavily influenced by [Archcraft](https://archcraft.io/).
<details>
  <summary> What is ricing? </summary>
    The term βriceβ is used to describe a personβs unix desktop where βricingβ is when someone is custom their desktop such as the icons, panels, or system interface. When it comes to ricing a tiling window manager though, the ricing of a userβs system becomes much more involved. Basic things such as the panel bar and application launcher must be configured by the user.
    The reddit community /r/unixporn is a great place to stay up to date on what people are using for their setups.
    // by [thatnixguy](https://thatnixguy.github.io/)
</details>

## β¨ Features:
- πͺ Window manager, [bspwm](https://wiki.archlinux.org/title/bspwm), [sxhkd](https://wiki.archlinux.org/title/sxhkd). `bspwm` is pretty harsh, if something went wrong you are welcomed with a black screen and no mouse/keyboard input. In case `bspwm` didn't work or you just don't like a tiling window manager, login with [openbox](https://wiki.archlinux.org/title/openbox)
- π Display manager (the login thing) [lightdm](https://wiki.archlinux.org/title/lightdm)
- π Status bar [eww](https://github.com/elkowar/eww)
- π Program launcher [rofi](https://wiki.archlinux.org/title/rofi)
- π Notification panel [dunst](https://wiki.archlinux.org/title/dunst)
- π File manager [lf](https://github.com/gokcehan/lf)
- π Text editor [neovim](https://neovim.io/)
- π± Shell and terminal emulator [fish](https://wiki.archlinux.org/title/fish), [kitty](https://wiki.archlinux.org/title/Kitty)
- π§ Music player [mpd](https://wiki.archlinux.org/title/Music_Player_Daemon)
# π Screenshots
![](Pictures/Screenshots/1.png)
![](Pictures/Screenshots/2.png)
![](Pictures/Screenshots/3.png)
![](Pictures/Screenshots/4.png)
![](Pictures/Screenshots/5.png)
# π Installation
## π TL;DR
Use this script 
```bash
sudo pacman -Syu fish git
git clone https://github.com/hucancode/home
mv home/* . && rm -rf home
chmod +x rice.sh && fish ./rice.sh
```
## βοΈ Install Arch
Assume that you use `archinstall`. 
## π Change default shell to `fish`
```bash
sudo pacman -Syu fish
chsh -s $(which fish)
```
and then restart your terminal.
## πΎ Checkout rice configurations
My `~` folder is a git repo with `.gitignore` set to `*`. That's super convenient, I recommend you doing the same.
```fish
sudo pacman -S git
git clone https://github.com/hucancode/home
mv home/* . ; and rm -rf home
sudo mkdir /usr/share/openbox; sudo mv ~/.config/openbox/icons /usr/share/openbox
```
## π¦ Install softwares
Install `yay`
```fish
git clone https://aur.archlinux.org/yay-bin.git
begin cd yay-bin; and makepkg -si; end
```
Install required packages
```fish
set WM_AUR "i3lock-color eww-git ksuperkey"
set MEDIA "alsa-utils ffmpeg mpd mpc mpv viewnior chromium"
set FILE_MANAGER "meld"
set FILE_MANAGER_AUR "lf"
set TERMINAL "kitty neovim fisher fzf fd ripgrep exa sd"
set FONTS "ttf-fira-code noto-fonts noto-fonts-cjk noto-fonts-emoji"
set KEYRING "gnome-keyring libgnome-keyring"
sudo pacman -S $THEME $WM $MEDIA $FILE_MANAGER $TERMINAL $FONTS $KEYRING
yay -S $WM_AUR $FILE_MANAGER_AUR
```
## π Config `lightdm`
Copy avatar and wallpaper to somewhere `lightdm` have access to.
```fish
curl -L -o avatar.png https://github.com/hucancode.png; and sudo cp {avatar.png,.config/lightdm/wallpaper.jpg} /usr/share/lightdm-gtk-greeter-settings; and rm avatar.png
sudo mkdir -p /etc/lightdm
sudo cp .config/lightdm/lightdm-gtk-greeter.conf /etc/lightdm
```
Set `lightdm` as your default display manager.
```fish
systemctl enable lightdm
```
Enable `lightdm-gtk-greeter` (`lightdm` default to gtk greeter, but just in case something went wrong, please check `lightdm.conf`)
```fish
vi /etc/lightdm/lightdm.conf
# enable [Seat:*]
# ...
# greeter-session=lightdm-gtk-greeter
# ...
```
