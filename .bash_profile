# .bash_profile


# Initialize Ruby environment
if [ -d "$HOME/.rbenv/bin" ]; then
    export PATH="$HOME/.rbenv/bin:$PATH"
    eval "$(rbenv init -)"
elif [ -d "$HOME/.gem/ruby/" ]; then
    export PATH=$PATH:$HOME/.gem/ruby/$(ls -r $HOME/.gem/ruby/ | head -1)/bin
fi


# Initialize Python environment
if [ -d "$HOME/.pyenv/bin" ]; then
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi


# Initialize PHP environment
if [ -d "$HOME/.phpenv/bin" ]; then
    export PHPENV_ROOT="$HOME/.phpenv"
    export PATH="$PHPENV_ROOT/bin:$PATH"
    eval "$(phpenv init -)"
fi

# Initialize Node.js environment
if [ -d "$HOME/.nodenv/bin" ]; then
    export NODENV_ROOT="$HOME/.nodenv"
    export PATH="$NODENV_ROOT/bin:$PATH"
    eval "$(nodenv init -)"
fi

which npm > /dev/null 2>&1
if [ $? = 0 ]; then
    eval "$(npm completion)"
    export PATH="$(npm prefix --location=global)/bin:$PATH"
fi

uname | grep -q 'Darwin' > /dev/null 2>&1
if [ $? = 0 ]; then
    # coreutils
    PATH=/usr/local/opt/coreutils/libexec/gnubin:${PATH}
    MANPATH=/usr/local/opt/coreutils/libexec/gnuman:${MANPATH}
    # ed
    PATH=/usr/local/opt/ed/libexec/gnubin:${PATH}
    MANPATH=/usr/local/opt/ed/libexec/gnuman:${MANPATH}
    # findutils
    PATH=/usr/local/opt/findutils/libexec/gnubin:${PATH}
    MANPATH=/usr/local/opt/findutils/libexec/gnuman:${MANPATH}
    # sed
    PATH=/usr/local/opt/gnu-sed/libexec/gnubin:${PATH}
    MANPATH=/usr/local/opt/gnu-sed/libexec/gnuman:${MANPATH}
    # tar
    PATH=/usr/local/opt/gnu-tar/libexec/gnubin:${PATH}
    MANPATH=/usr/local/opt/gnu-tar/libexec/gnuman:${MANPATH}
    # grep
    PATH=/usr/local/opt/grep/libexec/gnubin:${PATH}
    MANPATH=/usr/local/opt/grep/libexec/gnuman:${MANPATH}
fi

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi


# User specific environment and startup programs
PATH=$HOME/bin:/usr/local/bin:$PATH
PATH="$PATH:$HOME/.local/bin"
PATH="$PATH:$HOME/.bin"

export PATH
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8


if [ -f ~/.Xmodmap ]; then
    xmodmap ~/.Xmodmap
fi


# 初回シェル時のみtmux実行
if [ $SHLVL = 1 ]; then
    tmux -2
fi


# if using WSL2 and not using WSLg
if [ "x$BASH_ENV_WSL2_LOCAL_IP" == "x1" ]; then
    LOCAL_IP=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}')
    export DISPLAY=$LOCAL_IP:0
fi

if [ "x$BASH_ENV_WSL_LOCALHOST_IP" == "x1" ]; then
    export DISPLAY=127.0.0.1:0.0
fi

# https://github.com/microsoft/wslg/wiki/GPU-selection-in-WSLg
export MESA_D3D12_DEFAULT_ADAPTER_NAME=RTX

export PATH="$HOME/.ebcli-virtual-env/executables:$PATH"

export PATH="$HOME/.dotnet:$HOME/.dotnet/tools:$PATH"
export DOTNET_ROOT="$HOME/.dotnet"
export DOTNET_ROOT_X64="$HOME/.dotnet"

# https://zenn.dev/cat2151/scraps/53076d45431d49
export PULSE_SERVER=unix:$(sed 's/unix://g' <<< "$PULSE_SERVER")
. "$HOME/.cargo/env"
