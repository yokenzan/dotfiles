# to the extent possible under law, the author(s) have dedicated all 
# copyright and related and neighboring rights to this software to the 
# public domain worldwide. This software is distributed without any warranty. 
# You should have received a copy of the CC0 Public Domain Dedication along 
# with this software. 
# If not, see <http://creativecommons.org/publicdomain/zero/1.0/>. 

# ~/.bashrc: executed by bash(1) for interactive shells.

# The copy in your home directory (~/.bashrc) is yours, please
# feel free to customise it to create a shell
# environment to your liking.  If you feel a change
# would be benifitial to all, please feel free to send
# a patch to the msys2 mailing list.

# User dependent .bashrc file

# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

# Shell Options
#
# See man bash for more options...
#
# Don't wait for job termination notification
set -o notify
#
# Don't use ^D to exit
# set -o ignoreeof
#
# Use case-insensitive filename globbing
shopt -s nocaseglob
#
# When changing directory small typos can be ignored by bash
# for example, cd /vr/lgo/apaache would find /var/log/apache
# shopt -s cdspell

# enable '**'
shopt -s globstar

# enable to execute `cd` command without input `cd`
shopt -s autocd

shopt -s lithist # これを有効にして cmdhist オプションを有効にすると、可能な場合はセミコロン区切り記号を使用するのではなく、改行を埋め込んだ複数行コマンドが履歴に保存される。
shopt -s cmdhist # 複数行のコマンドの全ての行を1つの履歴エントリに保存


# Completion options
#
# These completion tuning parameters change the default behavior of bash_completion:
#
# Define to access remotely checked-out files over passwordless ssh for CVS
# COMP_CVS_REMOTE=1
#
# Define to avoid stripping description in --option=description of './configure --help'
COMP_CONFIGURE_HINTS=1
#
# Define to avoid flattening internal contents of tar files
# COMP_TAR_INTERNAL_PATHS=1
#
# Uncomment to turn on programmable completion enhancements.
# Any completions you add in ~/.bash_completion are sourced last.
[[ -f /etc/bash_completion ]] && . /etc/bash_completion
# Load my config
if [ -f "${HOME}/.bash-env" ]; then
    . $HOME/.bash-env
fi


# History Options
#
# Don't put duplicate lines in the history.
export HISTCONTROL=erasedups,ignoreboth,ignorespace
# export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}erasedups,ignorespace

export HISTTIMEFORMAT='%F %T: '
#
# Ignore some controlling instructions
# HISTIGNORE is a colon-delimited list of patterns which should be excluded.
# The '&' is a special pattern which suppresses duplicate entries.
export HISTIGNORE=$'[ \t]*:&:[fb]g:exit:ls:ll:lla:llal:emacs:vim:history:e:v:vs:gs:gv:tig:r:*rm -rf*:r:git push*:*--force*:gm-:git merge:gcmn:gcm:gsp:git stash drop*:..:...:t:l:~:git*--no-verify*:*APP_ENV=production *'
# shopt -s histverify

if [ "x$BASH_ENV_SHARE_HISTORY" == "x1" ]; then
    export PROMPT_COMMAND='share_history'
    shopt -u histappend
else
    export PROMPT_COMMAND=
    shopt -s histappend
fi

share_history() {
    history -a
    history -c
    history -r
}
export HISTSIZE=20000


# Umask
#
# /etc/profile sets 022, removing write perms to group + others.
# Set a more restrictive umask: i.e. no exec perms for others:
# umask 027
# Paranoid: neither group nor others have any perms:
# umask 077

# Functions
#
# Some people use a different file for functions
if [ -f "${HOME}/.bash_functions" ]; then
    . "${HOME}/.bash_functions"
fi
#
# Some example functions:
#
# a) function settitle
# settitle () 
# { 
#   echo -ne "\e]2;$@\a\e]1;$@\a"; 
# }
# 


# Some people use a different file for aliases
if [ -f "${HOME}/.bash_aliases" ]; then
    . "${HOME}/.bash_aliases"
fi

# Source global definitions
if [ -f /etc/bashrc ]; then
    .  /etc/bashrc
fi

# Setting prompt
if [ -f "${HOME}/.dotfiles/gradle-completion.bash" ]; then
    . $HOME/.dotfiles/gradle-completion.bash
fi

if [ -f "${HOME}/.config/git/completion/git-prompt.sh" ]; then
    . $HOME/.config/git/completion/git-prompt.sh
fi

if [ -f "${HOME}/.config/git/completion/git-completion.bash" ]; then
    . $HOME/.config/git/completion/git-completion.bash
fi

if [ -f "${HOME}/.dotfiles/npm-completion.bash" ]; then
    . $HOME/.dotfiles/npm-completion.bash
fi

GIT_PS1_SHOWUNTRACKEDFILES=1    # %
GIT_PS1_SHOWDIRTYSTATE=1        # * / +
GIT_PS1_SHOWSTASHSTATE=1        # $
GIT_PS1_SHOWUPSTREAM=1          # < / > / = / <>

# https://www.ryotosaito.com/blog/?p=455
#
# PROMPT_COMMAND=__prompt_command
__prompt_command() {
    # 最初に直前コマンドの終了ステータスを記録
    local status=$?
    # SGRパラメータ（文字装飾：色付けを行うためのエスケープシーケンス）
    local reset='\001\e[0m\002' red='\001\e[31m\002' green='\001\e[32m\002' yellow='\001\e[33m\002'
    # 連想配列で終了ステータスとシグナル名の対応を管理
    local -A err_code=(
    [1]=ERROR [2]='builtin error' [126]=NO_EXE [127]=TYPO
    [128]=SIGHUP [129]=SIGINT [130]=SIGQUIT [131]=SIGILL [132]=SIGTRAP
    [133]=SIGABRT [134]=SIGEMT [135]=SIGFPE [136]=SIGKILL [137]=SIGBUS
    [138]=SIGSEGV [139]=SIGSYS [140]=SIGPIPE [141]=SIGALRM [142]=SIGTERM
    [143]=SIGURG [144]=SIGSTOP [145]=SIGTSTP [146]=SIGCONT [147]=SIGCHLD
    [148]=SIGTTIN [149]=SIGTTOU [150]=SIGIO [151]=SIGXCPU [152]=SIGXFSZ
    [153]=SIGVTALRM [154]=SIGPROF [155]=SIGWINCH [156]=SIGINFO [157]=SIGUSR1
    [158]=SIGUSR2
    )
    if [[ $status -eq 0 ]]; then
        echo -e "$green〇$reset"
    elif [[ $status -eq 130 ]]; then
        echo -e "$yellow！$status\001\e[2m\002(${err_code[$status]})$reset"
    else
        echo -e "$redＸ$status\001\e[2m\002(${err_code[$status]})$reset"
    fi
}


uname | grep -q 'NT' > /dev/null 2>&1
if [ $? = 0 ]; then
    PS1='\n\[\033[38;5;214m\]\D{%Y/%m/%d %H:%M:%S}\[\033[00m\] \[\033[38;5;220m\]\u@\h\[\033[00m\]'

    # Vim
    if [[ $VIMRUNTIME != "" ]] ; then
        PS1=$PS1' \[\033[5;1;33m\](vim)\[\033[00m\]'
    fi

    # Ranger
    if [[ $RANGER_LEVEL != "" ]] ; then
        PS1=$PS1' \[\033[5;38;5;213m\](ranger)\[\033[00m\]'
    fi

    # export PS1=$PS1' \[\033[3;35m\]\w\[\033[00m\]\[\033[31m\]$(__git_ps1)\[\033[00m\]\n\[\033[38;5;213m\]\$\[\033[00m\] '
    export PS1=$PS1' \[\033[3;35m\]\w\[\033[00m\]\[\033[31m\]$(__git_ps1)\[\033[00m\]\n$(__prompt_command) \[\033[38;5;213m\]\$\[\033[00m\] '
else
    # PS1='\n\[\033[38;5;213m\]\D{%Y/%m/%d %H:%M:%S}\[\033[00m\] \[\033[36m\]\u@\h\[\033[00m\]'
    PS1='\n\[\033[38;5;69m\]\D{%Y/%m/%d %H:%M:%S}\[\033[00m\] \[\033[38;5;48m\]\u@\h\[\033[00m\]'

    # Vim
    if [[ $VIMRUNTIME != "" ]] ; then
        PS1=$PS1' \[\033[5;1;32m\](vim)\[\033[00m\]'
    fi

    # Ranger
    if [[ $RANGER_LEVEL != "" ]] ; then
        PS1=$PS1' \[\033[5;38;5;228m\](ranger)\[\033[00m\]'
    fi

    # export PS1=$PS1' \[\033[3;35m\]\w\[\033[00m\]\[\033[31m\]$(__git_ps1)\[\033[00m\]\n\[\033[33m\]\$\[\033[00m\] '
    export PS1=$PS1' \[\033[3;38;5;13m\]\w\[\033[00m\]\[\033[31m\]$(__git_ps1)\[\033[00m\]\n$(__prompt_command) \[\033[33m\]\$\[\033[00m\] '
fi


stty stop undef
stty discard undef
export EDITOR=vim
export MANPAGER="vim +MANPAGER -"


complete -cf sudo

export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && . "$HOME/.sdkman/bin/sdkman-init.sh"


PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
PATH="$HOME/.config/alacritty/alacritty.bash:$PATH"

if [[ $(uname) = "Darwin" ]]; then
    export PATH="$HOME/.nodebrew/current/bin:$PATH"
fi

PATH="$PATH:$HOME/.config/composer/vendor/bin"

export GOPATH="$HOME/.go"
PATH="$PATH:$HOME/go/bin"
PATH="$GOPATH/bin:$PATH"

export DENO_INSTALL="/home/yosuke/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

if [ "x$BASH_ENV_USE_GOOGLE_IME_SKK" == "x1" ]; then
    if ps aux | grep google-ime-skk | grep -vqs grep ; then
        : nothing todo
    else
        google-ime-skk >/dev/null 2>&1 &
    fi
else
    pkill google-ime-skk
fi

if [ "x$BASH_ENV_LAUNCH_RECEIPTISAN" == "x1" ]; then
    if [ $(port_is_busy 4567) == "free" ] ; then __launch_receiptisan; fi
fi

which symfony-autocomplete > /dev/null 2>&1

if [ $? = 0 ]; then
    eval "$(symfony-autocomplete)"
fi

which gh > /dev/null 2>&1

if [ $? = 0 ]; then
    eval "$(gh completion -s bash)"
fi

if [ -f "${HOME}/.bashrc.local" ]; then
    . "${HOME}/.bashrc.local"
fi
