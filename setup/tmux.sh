#!/bin/bash

rm -rf   $HOME/.tmux

mkdir -p $HOME/.tmux/plugins
ln -sf   $HOME/.dotfiles/.tmux.conf $HOME


git clone git@github.com:tmux-plugins/tpm.git $HOME/.tmux/plugins/tpm
