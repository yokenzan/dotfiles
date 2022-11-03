#!/bin/bash -x

echo ========== Installing TMUX.. ==========

# install packages needed to build tmux
sudo apt install -y libevent-dev libncurses5 libncurses5-dev zlib1g-dev

cd $HOME/wk/oss
curl -OL https://github.com/tmux/tmux/releases/download/3.3a/tmux-3.3a.tar.gz
tar xvzf tmux-3.3a.tar.gz
cd tmux-3.3a && ./configure && make -j$(nproc)
sudo make install

echo ========== Completed Installing TMUX ==========
