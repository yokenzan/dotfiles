#!/bin/bash

mkdir -p \
    $HOME/.config/composer  \
    $HOME/.config/alacritty \
    $HOME/.config/i3        \
    $HOME/.config/ranger    \
    $HOME/.config/gtk-3.0   \
    $HOME/.config/phpactor  \
    $HOME/.mlterm

mkdir -p $HOME/.emacs.d

ln -sf $HOME/.dotfiles/.bashrc           $HOME
ln -sf $HOME/.dotfiles/.bash_profile     $HOME
ln -sf $HOME/.dotfiles/.bash_aliases     $HOME
ln -sf $HOME/.dotfiles/.bash_functions   $HOME
ln -sf $HOME/.dotfiles/.Xresources       $HOME

ln -sf $HOME/.dotfiles/.inputrc          $HOME
ln -sf $HOME/.dotfiles/.editrc           $HOME
ln -sf $HOME/.dotfiles/.pryrc            $HOME
ln -sf $HOME/.dotfiles/.curlrc           $HOME

ln -sf $HOME/.dotfiles/.globalrc         $HOME
ln -sf $HOME/.dotfiles/.ctags            $HOME
ln -sf $HOME/.dotfiles/.i3status.conf    $HOME
ln -sf $HOME/.dotfiles/.tigrc            $HOME

ln -sf $HOME/.dotfiles/.emacs            $HOME/.emacs.d/init.el
ln -sf $HOME/.dotfiles/.fanti.emacs      $HOME/.emacs.d/.fanti.emacs
ln -sf $HOME/.dotfiles/composer.json     $HOME/.config/composer

ln -sf $HOME/.dotfiles/.config/i3/config                  $HOME/.config/i3
ln -sf $HOME/.dotfiles/.config/alacritty/alacritty.yml    $HOME/.config/alacritty

ln -sf $HOME/.dotfiles/.config/ranger/commands.py         $HOME/.config/ranger
ln -sf $HOME/.dotfiles/.config/ranger/commands_full.py    $HOME/.config/ranger
ln -sf $HOME/.dotfiles/.config/ranger/rc.conf             $HOME/.config/ranger
ln -sf $HOME/.dotfiles/.config/ranger/rifle.conf          $HOME/.config/ranger
ln -sf $HOME/.dotfiles/.config/ranger/scope.sh            $HOME/.config/ranger

ln -sf $HOME/.dotfiles/.config/gtk-3.0/settings.ini       $HOME/.config/gtk-3.0

ln -sf $HOME/.dotfiles/.config/phpactor/phpactor.yml      $HOME/.config/phpactor
ln -sf $HOME/.dotfiles/.config/phpactor/templates         $HOME/.config/phpactor

ln -sf $HOME/.dotfiles/.mlterm/aafont                     $HOME/.mlterm
ln -sf $HOME/.dotfiles/.mlterm/main                       $HOME/.mlterm
ln -sf $HOME/.dotfiles/.mlterm/color                      $HOME/.mlterm

cp -f  $HOME/.dotfiles/.Xmodmap.sample                    $HOME/.Xmodmap


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

mkdir $HOME/.themes
git clone --depth=1 git://github.com/debug-ito/GtkEmacs-debug-ito.git $HOME/.themes/GtkEmacs-debug-ito
gsettings set org.gnome.desktop.interface gtk-key-theme GtkEmacs-debug-ito

