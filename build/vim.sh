#!/bin/bash

: ========== Installing VIM.. ==========

cd $HOME/wk/repos/oss

#build VIM

git clone --depth=5 git://github.com/vim/vim.git
cd vim
make distclean

# build with GUI
./configure \
    --prefix=/usr/local \
    --enable-fail-if-missing \
    --with-features=huge \
    --enable-gui=gtk3 \
    --enable-python3interp \
    --enable-rubyinterp \
    --with-ruby-command=$HOME/.rbenv/shims/ruby \
    --enable-gpm \
    --enable-acl \
    --enable-multibyte \
    --enable-cscope \
    --enable-xim \
    --enable-nls \
    --enable-fontset \
    --enable-xsmp \
    --enable-terminal \
    --enable-gtk3-check \
    --disable-selinux \
    --disable-netbeans \
    --with-x

# build without GUI
# ./configure \
#     --prefix=/usr/local \
#     --enable-fail-if-missing \
#     --with-features=huge \
#     --disable-gui \
#     --enable-python3interp \
#     --enable-rubyinterp \
#     --enable-gpm \
#     --enable-acl \
#     --without-x \
#     --enable-multibyte \
#     --enable-cscope \
#     --enable-xim \
#     --enable-fontset \
#     --disable-selinux \
#     --enable-nls \
#     --disable-netbeans \
#     --disable-xsmp


if [ $? ]; then
    make && sudo make install
else
  exit 1
fi

vim -c "quit"
vim -c "call dein#install()" -c "quit"

: ========== Completed Installing VIM ==========
