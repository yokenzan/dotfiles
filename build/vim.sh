#!/bin/bash -x

echo ========== Installing VIM.. ==========

echo install packages needed to build vim
sudo apt install -y gettext build-essential libtinfo-dev libacl1-dev libgpm-dev
echo install Gtk3
sudo apt install -y libxmu-dev libxpm-dev libgtk-3-0 libgtk-3-dev

cd $HOME/wk/repos/oss

echo build VIM

git clone git://github.com/vim/vim.git
cd vim
make distclean

echo build with GUI
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
    make -j$(nproc) && sudo make install
else
  exit 1
fi

echo ========== Completed Installing VIM ==========
