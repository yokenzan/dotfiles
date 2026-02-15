#!/usr/bin/env bash
set -euo pipefail

echo "========== Build Vim (pyenv Python3) =========="

sudo apt update
sudo apt install -y \
  build-essential \
  gettext \
  git \
  libacl1-dev \
  libattr1-dev \
  libgpm-dev \
  libtinfo-dev \
  libxmu-dev \
  libxpm-dev \
  libgtk-3-dev

if ! command -v pyenv >/dev/null 2>&1; then
  echo "pyenv is required but not found"
  exit 1
fi

# Use current pyenv Python by default. Override with PYENV_PYTHON_VERSION=3.x.y
PYVER="${PYENV_PYTHON_VERSION:-$(pyenv version-name)}"
PY_PREFIX="$(pyenv prefix "${PYVER}")"
PY_BIN="${PY_PREFIX}/bin/python3"
PY_CONFIG_DIR="$("${PY_BIN}"-config --configdir)"

echo "Using Python: ${PY_BIN}"
echo "Python config: ${PY_CONFIG_DIR}"

# Optional: rebuild Python with shared library when REBUILD_PYTHON=1
if [[ "${REBUILD_PYTHON:-0}" == "1" ]]; then
  env PYTHON_CONFIGURE_OPTS="--enable-shared" pyenv install -f "${PYVER}"
  pyenv global "${PYVER}"
  hash -r
  PY_PREFIX="$(pyenv prefix "${PYVER}")"
  PY_BIN="${PY_PREFIX}/bin/python3"
  PY_CONFIG_DIR="$("${PY_BIN}"-config --configdir)"
fi

"${PY_BIN}" -m pip install -U pip setuptools wheel
"${PY_BIN}" -m pip install -U pynvim msgpack

mkdir -p "${HOME}/wk/oss"
if [[ ! -d "${HOME}/wk/oss/vim/.git" ]]; then
  git clone https://github.com/vim/vim.git "${HOME}/wk/oss/vim"
fi

cd "${HOME}/wk/oss/vim"
git fetch --tags --prune
git pull --ff-only
make distclean || true

./configure \
  --prefix=/usr/local \
  --with-features=huge \
  --enable-fail-if-missing \
  --enable-gui=gtk3 \
  --enable-terminal \
  --enable-multibyte \
  --enable-cscope \
  --enable-gpm \
  --enable-acl \
  --enable-python3interp=yes \
  --with-python3-config-dir="${PY_CONFIG_DIR}" \
  --enable-rubyinterp \
  --with-ruby-command="${HOME}/.rbenv/shims/ruby" \
  --disable-netbeans \
  --disable-selinux \
  LDFLAGS="-Wl,-rpath,${PY_PREFIX}/lib -Wl,-E"

make -j"$(nproc)"
sudo make install

echo "========== Verify =========="
vim --version | rg "python3|Linking" || true
vim -Nu NONE -n -es -V1/tmp/vim_python_check.log \
  +"python3 import math,pynvim" \
  +"qall" || true
tail -n 80 /tmp/vim_python_check.log || true

echo "========== Done =========="
