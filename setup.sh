#!/bin/bash

mkdir -p $HOME/.config
mkdir -p $HOME/.emacs.d

ln -sf $HOME/.dotfiles/.bashrc           $HOME
ln -sf $HOME/.dotfiles/.bash_profile     $HOME
ln -sf $HOME/.dotfiles/.bash_aliases     $HOME
ln -sf $HOME/.dotfiles/.bash_functions   $HOME


ln -sf $HOME/.dotfiles/.inputrc          $HOME
ln -sf $HOME/.dotfiles/.editrc           $HOME
ln -sf $HOME/.dotfiles/.pryrc            $HOME
ln -sf $HOME/.dotfiles/.curlrc           $HOME


ln -sf $HOME/.dotfiles/.globalrc         $HOME
ln -sf $HOME/.dotfiles/.ctags            $HOME

ln -sf $HOME/.dotfiles/.emacs            $HOME/.emacs.d


if [ $(uname | grep -qe 'NT') ]; then
    # Windows
    ln -sf $HOME/.dotfiles/.minttyrc     $HOME
fi


git clone git://github.com/rbenv/rbenv.git ~/.rbenv
git clone git://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build


for i in $(find $HOME/.dotfiles/setup); do $i; done
