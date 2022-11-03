#!/bin/bash -x

echo ========== Installing Python.. ==========

# install packages needed to build python3
sudo apt install -y make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev

git clone git@github.com:pyenv/pyenv.git ~/.pyenv
git clone git@github.com:pyenv/pyenv-virtualenv.git $(pyenv root)/plugins/pyenv-virtualenv

exec $SHELL -l
eval "$(pyenv init -)"
local python_version="$(pyenv install --list | sed -e '/[^. 0-9]/d' | tail -1)"
pyenv install -v $python_version

exec $SHELL -l

pyenv global $python_version

pip install --upgrade pip
pip install pynvim typing neovim ranger-fm pygments

echo ========== Completed Installing Python ==========
