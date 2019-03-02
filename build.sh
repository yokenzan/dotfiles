#!/bin/bash

# global pygmentize global ctags

 sudo apt update sudo apt upgrade

 # install basic packages
 sudo apt install -y curl git tig ibus-skk xsel tmux highlight w3m w3m-img rxvt-unicode-256color emacs fzy global

 # install web server and database related packages
 sudo apt install -y apache2 mysql-client mysql-server libsqlite3-dev sqlite3

 # install ruby related packages
 sudo apt install -y ruby2.5 ruby2.5-dev

 # install php related packages
 sudo apt install -y php7.2 php7.2-dev php7.2-curl php7.2-gmp php7.2-mysql php7.2-readline php7.2-tidy php7.2-xml php7.2-cli php7.2-intl php7.2-json php7.2-gd php7.2-zip php-xdebug

 # install python related packages
 sudo apt install -y python3.7 python3.7-dev python3-pip

 # install web browser Vivaldi
 wget https://downloads.vivaldi.com/stable/vivaldi-stable_2.3.1440.48-1_amd64.deb
 sudo dpkg -i vivaldi-stable_2.3.1440.48-1_amd64.deb

 # install packages needed to build vim
 sudo apt install -y gettext build-essential libtinfo-dev libacl1-dev libgpm-dev


wget https://raw.githubusercontent.com/composer/getcomposer.org/76a7060ccb93902cd7576b67264ad91c8a2700e2/web/installer -O - -q | php -- --quiet
sudo mv composer.phar /usr/local/bin/composer

composer global install

pip3 install pynvim typing neovim ranger-fm

sudo gem install solargraph pry pry-doc pry-stack_explorer color_echo byebug pry-byebug yard bundler google-ime-skk


#build VIM

mkdir -p $HOME/wk/repos/oss
cd $HOME/wk/repos/oss
git clone git://github.com/vim/vim.git
cd vim
./configure \
    --prefix=/usr/local \
    --enable-fail-if-missing \
    --with-features=huge \
    --disable-gui \
    --enable-python3interp \
    --enable-rubyinterp \
    --enable-gpm \
    --enable-acl \
    --without-x \
    --enable-multibyte \
    --enable-cscope \
    --enable-xim \
    --enable-fontset \
    --disable-selinux \
    --enable-nls \
    --disable-netbeans \
    --disable-xsmp

if [ $? ]; then
    make && sudo make install
fi

vim -c "call dein#install()"



#build alacritty

cd $HOME/wk/repos/oss/
git clone git://github.com/jwilm/alacritty.git
cd alacritty
curl https://sh.rustup.rs -sSf | sh
rustup override set stable
rustup update stable
sudo apt-get install cmake pkg-config libfreetype6-dev libfontconfig1-dev xclip
cargo build --release
sudo cp target/release/alacritty /usr/local/bin # or anywhere else in $PATH
sudo desktop-file-install alacritty.desktop
sudo update-desktop-database

