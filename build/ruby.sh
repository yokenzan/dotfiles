#!/bin/bash

echo ========== Installing Ruby.. ==========

# install packages needed to build ruby
sudo apt install -y ruby-dev libssl-dev

git clone git://github.com/rbenv/rbenv.git ~/.rbenv
git clone git://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build

exec $SHELL -l
eval "$(rbenv init -)"
local ruby_version="$(rbenv install -l | grep '^[\d\.]+$' | tail -1)"
rbenv install -v $ruby_version

exec $SHELL -l

rbenv global $ruby_version

rbenv exec gem install \
    solargraph \
    color_echo \
    byebug \
    yard \
    bundler \
    google-ime-skk

echo ========== Completed Installing Ruby ==========
