#!/bin/bash

rm -rf $HOME/.vim

mkdir -p $HOME/.vim/backup $HOME/.vim/swap $HOME/.vim/undo
mkdir -p $HOME/.vim/dein   $HOME/.vim/dein/repos/github.com
mkdir -p $HOME/.vim/ref

ln -sf $HOME/.dotfiles/.gitconfig        $HOME

ln -sf $HOME/.dotfiles/.bashrc           $HOME
ln -sf $HOME/.dotfiles/.bash_profile     $HOME
ln -sf $HOME/.dotfiles/.bash_aliases     $HOME

ln -sf $HOME/.dotfiles/.tmux.conf        $HOME
ln -sf $HOME/.dotfiles/.inputrc          $HOME
ln -sf $HOME/.dotfiles/.editrc           $HOME
ln -sf $HOME/.dotfiles/.pryrc            $HOME
ln -sf $HOME/.dotfiles/.minttyrc         $HOME

ln -sf $HOME/.dotfiles/.globalrc         $HOME
ln -sf $HOME/.dotfiles/.ctags            $HOME

ln -sf $HOME/.dotfiles/.vimrc            $HOME
ln -sf $HOME/.dotfiles/.gvimrc           $HOME
ln -sf $HOME/.dotfiles/.vim/indent       $HOME/.vim
ln -sf $HOME/.dotfiles/.vim/plugin       $HOME/.vim
ln -sf $HOME/.dotfiles/.vim/ref          $HOME/.vim
ln -sf $HOME/.dotfiles/.vim/dein/.config $HOME/.vim/dein

git clone git://github.com/Shougo/dein.vim.git $HOME/.vim/dein/repos/github.com/Shougo/dein.vim
