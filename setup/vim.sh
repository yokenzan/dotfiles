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


curl -Lko $HOME/.vim/ref/php-chunked-xhtml.tar http://jp2.php.net/get/php_manual_ja.tar.gz/from/this/mirror
cd $HOME/.vim/ref
tar xzf   php-chunked-xhtml.tar
cd -

git clone git://github.com/Shougo/dein.vim.git $HOME/.vim/dein/repos/github.com/Shougo/dein.vim

