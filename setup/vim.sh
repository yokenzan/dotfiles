#!/bin/bash

rm -rf $HOME/.vim
mkdir -p \
    $HOME/.vim/backup   \
    $HOME/.vim/swap     \
    $HOME/.vim/undo     \
    $HOME/.vim/dein     \
    $HOME/.vim/ref      \
    $HOME/.vim/dein/repos/github.com


ln -sf $HOME/.dotfiles/.vimrc            $HOME
ln -sf $HOME/.dotfiles/.gvimrc           $HOME
ln -sf $HOME/.dotfiles/.vim/indent       $HOME/.vim
ln -sf $HOME/.dotfiles/.vim/plugin       $HOME/.vim
ln -sf $HOME/.dotfiles/.vim/dein/.config $HOME/.vim/dein

git clone git://github.com/Shougo/dein.vim.git                                  $HOME/.vim/dein/repos/github.com/Shougo/dein.vim
git clone git://github.com/laravel/docs.git                                     $HOME/.vim/ref/laravel.doc
git clone git://github.com/mockery/mockery.git                                  $HOME/.vim/ref/mockery
git clone git://github.com/sebastianbergmann/phpunit-documentation-english.git  $HOME/.vim/ref/phpunit

