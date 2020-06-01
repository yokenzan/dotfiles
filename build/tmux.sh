#!/bin/bash

: ========== Installing TMUX.. ==========

cd $HOME/wk/oss
curl -OL https://github.com/tmux/tmux/releases/download/3.1/tmux-3.1.tar.gz
tar xvzf tmux-3.1.tar.gz
cd tmux-3.1 && ./configure && make && sudo make install

: ========== Completed Installing TMUX ==========
