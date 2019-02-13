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

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi


# User specific environment and startup programs
PATH=$PATH:$HOME/bin:/usr/local/bin


# 初回シェル時のみtmux実行
if [ $SHLVL = 1 ]; then
    tmux -2
fi


export PATH="$PATH:$HOME/.cargo/bin"
export PATH="$PATH:$HOME/.config/composer/vendor/bin"


if [ -f ~/.Xmodmap ]; then
    xmodmap ~/.Xmodmap
fi
