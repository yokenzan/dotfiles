#!/bin/bash

rm   -rf $HOME/.skk
mkdir -p $HOME/.skk

if [ $(curl -s http://openlab.jp/skk/dic/SKK-JISYO.L.gz) ]; then
    curl -ko $HOME/.skk/SKK-JISYO.L.gz http://openlab.jp/skk/dic/SKK-JISYO.L.gz
    gunzip   $HOME/.skk/SKK-JISYO.L.gz
else
    cp -f $HOME/.dotfiles/SKK-JISYO.L $HOME/.skk
fi


