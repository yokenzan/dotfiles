# .bash_profile


# Initialize Ruby environment
if [ -d "$HOME/.gem/ruby/" ]; then
    export PATH=$PATH:$HOME/.gem/ruby/$(ls -r $HOME/.gem/ruby/ | head -1)/bin
fi

if [ -d "$HOME/.rbenv/bin" ]; then
    export PATH="$HOME/.rbenv/bin:$PATH"
    eval "$(rbenv init -)"
fi


# Initialize Python environment
if [ -d "$HOME/.pyenv/bin" ]; then
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
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
PATH=$PATH:$HOME/bin:/usr/local/bin


PATH="$PATH:$HOME/.cargo/bin"
PATH="$PATH:$HOME/.config/composer/vendor/bin"
PATH="$PATH:$HOME/.local/bin"
PATH="/usr/local/opt/ruby/bin:$PATH"
PATH="/usr/local/lib/ruby/gems/2.6.0/bin:$PATH"
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

export DISPLAY=127.0.0.1:0.0
