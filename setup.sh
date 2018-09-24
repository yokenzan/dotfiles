#!/bin/bash

rm -rf $HOME/.vim
rm -rf $HOME/.tmux
rm -rf $HOME/.skk

mkdir -p $HOME/.vim/backup $HOME/.vim/swap $HOME/.vim/undo
mkdir -p $HOME/.vim/dein   $HOME/.vim/dein/repos/github.com
mkdir -p $HOME/.tmux/plugins
mkdir -p $HOME/.skk
mkdir -p $HOME/.config


curl -K -o $HOME/.skk/SKK-JISYO.L.gz http://openlab.jp/skk/dic/SKK-JISYO.L.gz
gunzip $HOME/.skk/SKK-JISYO.L.gz

ln -sf $HOME/.dotfiles/.gitconfig        $HOME

ln -sf $HOME/.dotfiles/.bashrc           $HOME
ln -sf $HOME/.dotfiles/.bash_profile     $HOME
ln -sf $HOME/.dotfiles/.bash_aliases     $HOME
ln -sf $HOME/.dotfiles/.bash_functions   $HOME

ln -sf $HOME/.dotfiles/.tmux.conf        $HOME
ln -sf $HOME/.dotfiles/.inputrc          $HOME
ln -sf $HOME/.dotfiles/.editrc           $HOME
ln -sf $HOME/.dotfiles/.pryrc            $HOME
ln -sf $HOME/.dotfiles/.curlrc           $HOME

ln -sf $HOME/.dotfiles/.globalrc         $HOME
ln -sf $HOME/.dotfiles/.ctags            $HOME

ln -sf $HOME/.dotfiles/.vimrc            $HOME
ln -sf $HOME/.dotfiles/.gvimrc           $HOME
ln -sf $HOME/.dotfiles/.vim/indent       $HOME/.vim
ln -sf $HOME/.dotfiles/.vim/plugin       $HOME/.vim
ln -sf $HOME/.dotfiles/.vim/ref          $HOME/.vim
ln -sf $HOME/.dotfiles/.vim/dein/.config $HOME/.vim/dein

ln -sf $HOME/.dotfiles/git               $HOME/.config


if [ $(echo $OS | grep -e 'Windows') ]; then
    ln -sf $HOME/.dotfiles/.minttyrc     $HOME
fi


git clone git://github.com/Shougo/dein.vim.git $HOME/.vim/dein/repos/github.com/Shougo/dein.vim
git clone git://github.com/tmux-plugins/tpm.git $HOME/.tmux/plugins/tpm


git clone git://github.com/rbenv/rbenv.git ~/.rbenv
git clone git://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build


curl -K -L -o $HOME/.vim/ref/php-chunked-xhtml.tar http://jp2.php.net/get/php_manual_ja.tar.gz/from/this/mirror
tar xvzf      $HOME/.vim/ref/php-chunked-xhtml.tar
