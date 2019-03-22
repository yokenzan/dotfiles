#!/bin/bash

mkdir -p \
    $HOME/.config/composer  \
    $HOME/.config/alacritty \
    $HOME/.config/i3        \
    $HOME/.config/ranger

mkdir -p $HOME/.emacs.d

ln -sf $HOME/.dotfiles/.bashrc           $HOME
ln -sf $HOME/.dotfiles/.bash_profile     $HOME
ln -sf $HOME/.dotfiles/.bash_aliases     $HOME
ln -sf $HOME/.dotfiles/.bash_functions   $HOME
ln -sf /home/cyrt/.dotfiles/.Xresources  $HOME

ln -sf $HOME/.dotfiles/.inputrc          $HOME
ln -sf $HOME/.dotfiles/.editrc           $HOME
ln -sf $HOME/.dotfiles/.pryrc            $HOME
ln -sf $HOME/.dotfiles/.curlrc           $HOME

ln -sf $HOME/.dotfiles/.globalrc         $HOME
ln -sf $HOME/.dotfiles/.ctags            $HOME

ln -sf $HOME/.dotfiles/.emacs            $HOME/.emacs.d/init.el
ln -sf $HOME/.dotfiles/composer.json     $HOME/.config/composer


ln -sf $HOME/.dotfiles/.config/i3/config               $HOME/.config/i3
ln -sf $HOME/.dotfiles/.config/alacritty/alacritty.yml $HOME/.config/alacritty

ln -sf $HOME/.dotfiles/.config/ranger/commands.py      $HOME/.config/ranger
ln -sf $HOME/.dotfiles/.config/ranger/commands_full.py $HOME/.config/ranger
ln -sf $HOME/.dotfiles/.config/ranger/rc.conf          $HOME/.config/ranger
ln -sf $HOME/.dotfiles/.config/ranger/rifle.conf       $HOME/.config/ranger
ln -sf $HOME/.dotfiles/.config/ranger/scope.sh         $HOME/.config/ranger


if [ $(uname | grep -qe 'NT') ]; then
    # Windows
    ln -sf $HOME/.dotfiles/.minttyrc     $HOME
fi


git clone git://github.com/rbenv/rbenv.git ~/.rbenv
git clone git://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build


chmod -R 777 $HOME/.dotfiles/setup
for i in $(find $HOME/.dotfiles/setup -type f); do $i; done

chmod -R 777 $HOME/.dotfiles/build.sh
$HOME/.dotfiles/build.sh

chmod 777 $HOME/.dotfiles/vt
sudo ln -sf $HOME/.dotfiles/vt /usr/local/bin

if [ $(env | grep -ie ubuntu) ]; then
    gsettings set org.gnome.desktop.interface gtk-key-theme Emacs
fi

