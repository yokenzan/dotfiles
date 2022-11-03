#!/bin/bash

# update packages

sudo apt update
sudo apt upgrade -y

# sudo apt --fix-broken install

# install basic packages
sudo apt install -y curl git tig highlight fzy tree jq htop

# if ubuntu, install more packages
# sudo apt install -y xsel w3m w3m-img ibus-skk

# install i3 window manager and related packages
# sudo apt install -y i3 rofi feh volumeicon-alsa

# install web server and database related packages
sudo apt install -y libsqlite3-dev sqlite3

mkdir -p $HOME/wk/oss
chmod +x -R $HOME/.dotfiles/build

$HOME/.dotfiles/build/python.sh
$HOME/.dotfiles/build/vim.sh
$HOME/.dotfiles/build/ruby.sh
$HOME/.dotfiles/build/tmux.sh
$HOME/.dotfiles/build/docker.sh
$HOME/.dotfiles/build/node.sh
# $HOME/.dotfiles/build/php.sh
# $HOME/.dotfiles/build/mysql.sh
