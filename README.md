# Hello 👋
This is my personal ricing setup. Powered by [Arch](https://archlinux.org/). Heavily influenced by [Archcraft](https://archcraft.io/).
# Contain settings for
- [bspwm](https://wiki.archlinux.org/title/bspwm), [sxhkd](https://wiki.archlinux.org/title/sxhkd)
- [Openbox](https://wiki.archlinux.org/title/openbox)
- [polybar](https://wiki.archlinux.org/title/polybar)
- [rofi](https://wiki.archlinux.org/title/rofi)
- [dunst](https://wiki.archlinux.org/title/dunst)
- [thunar](https://wiki.archlinux.org/title/thunar)
- [vim](https://wiki.archlinux.org/title/vim)
- [ZSH](https://wiki.archlinux.org/title/zsh), [Alacritty](https://wiki.archlinux.org/title/alacritty)
- [XOrg](https://wiki.archlinux.org/title/Xorg)
# Screenshots
![](screenshots/1.png)
![](screenshots/2.png)
![](screenshots/3.png)
![](screenshots/4.png)
# Installation
## Install Arch
Assume that you use `archinstall`.
These packages below should be installed during arch installation (When it asks you to `arch-chroot` into your new disk, please accept). If you don't want to install everything right now, at least install `dhcpcd` and `vim` to make sure we have internet and a debug tool after reboot.
```
sudo pacman -S dhcpcd xorg \
    lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings \
    vim git \
    bspwm sxhkd openbox rofi dunst ksuperkey xsettingsd nitrogen maim \
    mpd mpc ncmpcpp mpv \
    thunar xarchiver thunar-archive-plugin ranger ueberzug \
    alacritty zsh \
    ttf-iosevka-nerd ttf-jetbrains-mono noto-fonts noto-fonts-cjk noto-fonts-emoji \
    ibus-anthy \
    base-devel gnome-keyring docker mono;
```
## Install `yay`
```
git clone https://aur.archlinux.org/yay-bin.git; cd yay-bin; makepkg -si;
```
## Use `yay` to install what's missing
```
yay -S polybar qogir-icon-theme vimix-cursors i3lock-color \
    google-chrome visual-studio-code-bin nerd-fonts-jetbrains-mono ttf-iosevka zsh-theme-powerlevel10k-git \
    ibus-bamboo;
systemctl enable lightdm;
```
## Checkout rice configurations, move everything to `~`
```
git clone https://github.com/hucancode/dotfiles
cd dotfiles; cp . ~;
```
You may want to delete .git and README.md at your ~ after this. 
Then copy avatar and wallpaper to somewhere `lightdm` have access to.
```
cp {avatar.jpeg,wallpaper.jpg} /usr/share/lightdm-gtk-greeter-settings
```
You can alternatively put those picture at `~` and give `lightdm` access to your `~` folder
## Config `lightdm`
Enable `lightdm-gtk-greeter`
```
vim /etc/lightdm/lightdm.conf
# enable [Seat:*]
# ...
# greeter-session=lightdm-gtk-greeter
# ...
```
Rice your greeter with this
```
lightdm-gtk-greeter-settings
# select theme, wallpaper, avatar
```
This is how `/etc/lightdm/lightdm-gtk-greeter.conf` should looks like after configuration. Alternatively you can skip GUI setting program and straight up copy this.
```
[greeter]
background = /usr/share/lightdm-gtk-greeter-settings/wallpaper.jpg
default-user-image = /usr/share/lightdm-gtk-greeter-settings/avatar.jpeg
theme-name = Arc-Dark
icon-theme-name = Qogir-dark
indicators = ~spacer;~clock;~spacer;~session;~power
```