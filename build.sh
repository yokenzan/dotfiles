#!/bin/bash

# update packages

sudo apt update
sudo apt upgrade -y

sudo apt --fix-broken install

# install basic packages
sudo apt install -y curl git tig xsel highlight w3m w3m-img fzy tree jq htop ibus-skk

# install i3 window manager and related packages
# sudo apt install -y i3 rofi feh volumeicon-alsa

# install web server and database related packages
sudo apt install -y libsqlite3-dev sqlite3

# install python related packages
sudo apt install -y python3.8 python3.8-dev python3-pip

pip3 install pynvim typing neovim ranger-fm

# install web browser Vivaldi
# wget https://downloads.vivaldi.com/stable/vivaldi-stable_2.3.1440.48-1_amd64.deb
# sudo dpkg -i vivaldi-stable_2.3.1440.48-1_amd64.deb

# install packages needed to build vim
sudo apt install -y gettext build-essential libtinfo-dev libacl1-dev libgpm-dev

# install packages needed to build tmux
sudo apt install -y libevent-dev libncurses5 libncurses5-dev zlib1g-dev

# install Gtk3
sudo apt install -y libxmu-dev libxpm-dev libgtk-3-0 libgtk-3-dev

mkdir -p $HOME/wk/oss
chmod +x -R $HOME/.dotfiles/build

$HOME/.dotfiles/build/ruby.sh
$HOME/.dotfiles/build/node.sh
$HOME/.dotfiles/build/php.sh
$HOME/.dotfiles/build/mysql.sh
$HOME/.dotfiles/build/vim.sh
$HOME/.dotfiles/build/tmux.sh

# cd $HOME/wk/repos/oss
# git clone --depth=5 git://github.com/tmux/tmux.git
# cd tmux
# sh autogen.sh
# ./configure
#
# if [ $? ]; then
#     make && sudo make install
# else
#   exit 1
# fi


#build alacritty

# cd $HOME/wk/repos/oss/
# git clone git://github.com/jwilm/alacritty.git
# cd alacritty
# curl https://sh.rustup.rs -sSf | sh
# rustup override set stable
# rustup update stable
# sudo apt-get install cmake pkg-config libfreetype6-dev libfontconfig1-dev xclip
# cargo build --release
# sudo cp target/release/alacritty /usr/local/bin # or anywhere else in $PATH
# sudo desktop-file-install alacritty.desktop
# sudo update-desktop-database
