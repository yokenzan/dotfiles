#!/bin/bash

rm -rf   $HOME/.tmux

mkdir -p $HOME/.tmux/plugins
ln -sf   $HOME/.dotfiles/.tmux.conf             $HOME


if [ $(uname | grep -qe 'NT') ]; then
    # Windows
    ln -sf $HOME/.dotfiles/.tmux.conf.msys      $HOME
else
    ln -sf $HOME/.dotfiles/.tmux.conf.unix 	$HOME
fi


git clone git://github.com/tmux-plugins/tpm.git $HOME/.tmux/plugins/tpm
