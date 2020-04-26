#!/bin/bash

: ========== Installing Ruby.. ==========

git clone git://github.com/rbenv/rbenv.git ~/.rbenv
git clone git://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build

eval "$(rbenv init -)"
rbenv install $(rbenv install -l | grep "^[\d\.]+$" | tail -1)

rbenv exec gem install \
    solargraph \
    pry \
    pry-doc \
    pry-stack_explorer \
    color_echo \
    byebug \
    pry-byebug \
    yard \
    bundler \
    google-ime-skk

: ========== Completed Installing Ruby ==========
