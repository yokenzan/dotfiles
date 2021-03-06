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
# set -o notify
#
# Don't use ^D to exit
# set -o ignoreeof
#
# Use case-insensitive filename globbing
# shopt -s nocaseglob
#
# Make bash append rather than overwrite the history on disk
# shopt -s histappend
#
# When changing directory small typos can be ignored by bash
# for example, cd /vr/lgo/apaache would find /var/log/apache
# shopt -s cdspell

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

# History Options
#
# Don't put duplicate lines in the history.
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}erasedups
#
# Ignore some controlling instructions
# HISTIGNORE is a colon-delimited list of patterns which should be excluded.
# The '&' is a special pattern which suppresses duplicate entries.
export HISTIGNORE=$'[ \t]*:&:[fb]g:exit:ls:ll:lla:llal:e:v:vs:gs:rm -rf*:r:git push:*--force*:gcmn:gcm:gsp:git stash drop*' # Ignore the ls command as well
#
# Whenever displaying the prompt, write the previous line to disk
# export PROMPT_COMMAND="history -a"


function share_history {
    history -a
    history -c
    history -r
}
export PROMPT_COMMAND='share_history'
shopt -u histappend
export HISTSIZE=100000

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
  source "${HOME}/.bash_functions"
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
# b) function cd_func
# This function defines a 'cd' replacement function capable of keeping, 
# displaying and accessing history of visited directories, up to 10 entries.
# To use it, uncomment it, source this file and try 'cd --'.
# acd_func 1.0.5, 10-nov-2004
# Petar Marinov, http:/geocities.com/h2428, this is public domain
# cd_func ()
# {
#   local x2 the_new_dir adir index
#   local -i cnt
#
#   if [[ $1 ==  "--" ]]; then
#     dirs -v
#     return 0
#   fi
#
#   the_new_dir=$1
#   [[ -z $1 ]] && the_new_dir=$HOME
#
#   if [[ ${the_new_dir:0:1} == '-' ]]; then
#     #
#     # Extract dir N from dirs
#     index=${the_new_dir:1}
#     [[ -z $index ]] && index=1
#     adir=$(dirs +$index)
#     [[ -z $adir ]] && return 1
#     the_new_dir=$adir
#   fi
#
#   #
#   # '~' has to be substituted by ${HOME}
#   [[ ${the_new_dir:0:1} == '~' ]] && the_new_dir="${HOME}${the_new_dir:1}"
#
#   #
#   # Now change to the new dir and add to the top of the stack
#   pushd "${the_new_dir}" > /dev/null
#   [[ $? -ne 0 ]] && return 1
#   the_new_dir=$(pwd)
#
#   #
#   # Trim down everything beyond 11th entry
#   popd -n +11 2>/dev/null 1>/dev/null
#
#   #
#   # Remove any other occurence of this dir, skipping the top of the stack
#   for ((cnt=1; cnt <= 10; cnt++)); do
#     x2=$(dirs +${cnt} 2>/dev/null)
#     [[ $? -ne 0 ]] && return 0
#     [[ ${x2:0:1} == '~' ]] && x2="${HOME}${x2:1}"
#     if [[ "${x2}" == "${the_new_dir}" ]]; then
#       popd -n +$cnt 2>/dev/null 1>/dev/null
#       cnt=cnt-1
#     fi
#   done
#
#   return 0
# }
# 
# alias cd=cd_func



# Some people use a different file for aliases
if [ -f "${HOME}/.bash_aliases" ]; then
  source "${HOME}/.bash_aliases"
fi

# Source global definitions
if [ -f /etc/bashrc ]; then
    .  /etc/bashrc
fi


# Load my config
source $HOME/.bash-env


# Setting prompt
source $HOME/.config/git/completion/git-prompt.sh
source $HOME/.config/git/completion/git-completion.bash
GIT_PS1_SHOWUNTRACKEDFILES=1    # %
GIT_PS1_SHOWDIRTYSTATE=1        # * / +
GIT_PS1_SHOWSTASHSTATE=1        # $
GIT_PS1_SHOWUPSTREAM=1          # < / > / = / <>


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

    export PS1=$PS1' \[\033[3;35m\]\w\[\033[00m\]\[\033[31m\]$(__git_ps1)\[\033[00m\]\n\[\033[38;5;213m\]\$\[\033[00m\] '
else
    PS1='\n\[\033[38;5;213m\]\D{%Y/%m/%d %H:%M:%S}\[\033[00m\] \[\033[36m\]\u@\h\[\033[00m\]'

    # Vim
    if [[ $VIMRUNTIME != "" ]] ; then
        PS1=$PS1' \[\033[5;1;32m\](vim)\[\033[00m\]'
    fi

    # Ranger
    if [[ $RANGER_LEVEL != "" ]] ; then
        PS1=$PS1' \[\033[5;38;5;228m\](ranger)\[\033[00m\]'
    fi

    export PS1=$PS1' \[\033[3;35m\]\w\[\033[00m\]\[\033[31m\]$(__git_ps1)\[\033[00m\]\n\[\033[33m\]\$\[\033[00m\] '
fi


stty stop undef
stty discard undef
export EDITOR=vim


complete -cf sudo

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"


export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="$HOME/.config/alacritty/alacritty.bash:$PATH"

if [[ $(uname) = "Darwin" ]]; then
    export PATH="$HOME/.nodebrew/current/bin:$PATH"
fi


if [ $BASH_ENV_USE_GOOGLE_IME_SKK -eq 1 ]; then
    if ps aux | grep google-ime-skk | grep -vqs grep ; then
        : nothing todo
    else
        google-ime-skk >/dev/null 2>&1 &
    fi
else
    pkill google-ime-skk
fi

which symfony-autocomplete > /dev/null 2>&1

if [ $? = 0 ]; then
    eval "$(symfony-autocomplete)"
fi

