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
FILE_MANAGER_AUR="lf"
TERMINAL="neovim fzf fd ripgrep exa git-delta"
yay -S --nocleanmenu --noeditmenu --nodiffmenu --noupgrademenu $TERMINAL $FILE_MANAGER_AUR
# neovim first time setting
nvim -c "PackerInstall" -c "qa"
