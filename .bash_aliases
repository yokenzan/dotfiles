# Aliases
#
#
# Some example alias instructions
# If these are enabled they will be used instead of any instructions
# they may mask.  For example, alias rm='rm -i' will mask the rm
# application.  To override the alias instruction use a \ before, ie
# \rm will call the real rm not the alias.
#
# Interactive operation...
# alias rm='rm -i'
# alias cp='cp -i'
# alias mv='mv -i'
#
# Default to human readable figures
# alias df='df -h'
# alias du='du -h'
#
# Misc :)
# alias less='less -r'                        # raw control characters
# alias whence='type -a'                      # where, of a sort
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'              # show differences in colour
alias fgrep='fgrep --color=auto'              # show differences in colour

# Some shortcuts for different directory listings
alias ls='ls -hF --color=tty'                 # classify files in colour
alias dir='ls --color=auto --format=vertical'
alias vdir='ls --color=auto --format=long'
alias ll='ls -l'                              # long list
alias la='ls -A'                              # all but . and ..
alias lla='ll -A'                              # all but . and ..
alias l='ls -CF'                              #
alias j2u='iconv -f cp932 -t utf-8'
alias v='vim'
alias tmux='tmux -2'
alias ..='cd ..'
alias ...='cd ../..'
alias -- -='cd -'


alias g='git'
alias gb='git branch'
alias gbb='git branch -b'
alias gs='git status'
alias ga='git add'
alias gaa='git add -A'
alias gc='git commit'
alias gca='git commit -a'
alias gcm='git commit --amend'
alias gcmn='git commit --amend --no-edit'
alias gd='git diff'
alias gdc='git diff --cached'
alias glp='git log -p'
alias glo='git log --oneline'
alias gp='git pull'
alias gpr='git pull --rebase'

