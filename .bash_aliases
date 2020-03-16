shopt -s expand_aliases
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
alias grep='grep -P --color=auto'
alias egrep='egrep --color=auto'              # show differences in colour
alias fgrep='fgrep --color=auto'              # show differences in colour
alias g='grep . --color=always -r --include=*.php --exclude=_ide_helper.php --exclude-dir=.git --exclude-dir=storage'

# ls
alias ls='ls -hF --color=tty'
alias ll='ls -lA'
alias lla='ls -la'
alias lsl='ls -l'

alias l='less'

# find
alias f='find . -name'
alias ff='find . -type f -name'
alias fd='find . -type d -name'

# iconv
alias j2u='iconv -f cp932 -t utf-8'
alias u2j='iconv -t cp932 -f utf-8'

# cd
alias ..='cd ..'
alias ...='cd ../..'
alias -- -='cd -'

# pushd / popd
alias pd='pushd'
alias ppd='popd'

# Vim

alias v='vim'
alias vo='vim -O'
alias vs='vim -S Session.vim'
alias vu='vim -u NONE -N'
alias vq='vim -c :q'
alias v-='vim -'

alias gv='gvim &'
alias gvo='gvim -O &'
alias gvs='gvim -S Session.vim &'
alias gvu='gvim -u NONE -N &'
alias gvq='gvim -c :q &'

# tmux

alias t='tmux -2'
alias td='tmux -2 detach'
alias ta='tmux -2 a'
alias tl='tmux -2 ls'

# PHP

alias comp='composer'
alias art='php artisan'
alias tinker='php artisan tinker'
alias tink='php artisan tinker'
alias seed='php artisan db:seed'
alias seedc='seed --class'
alias migrate='php artisan migrate'
alias rollback='php artisan migrate:rollback'

# Git

# add
alias ga='git add'
alias gaa='git add -A'
# commit
alias gc='git commit'
alias gcv='gc -v'
alias gca='gc -a'
alias gcm='gc --amend'
alias gcmn='gc --amend --no-edit'
# config
alias gcg='git config --global'
alias gcgl='git config --global -l'
alias gcl='git config --local'
alias gcll='git config --local -l'
# diff
alias gd='git diff'
alias gdc='gd --cached'
alias gdw='gd --word-diff'
# log
alias gl='git log'
alias glo='git log --oneline'
alias glp='git log -p'
alias gls='git log --stat'
alias glw='git log --word-diff'
# stash
alias gss='git stash save'
alias gsp='git stash pop'
alias gsl='git stash list'
# grep
alias gg='git grep -P'
alias ggw='gg -w'
alias ggi='gg -i'
# others
alias gb='git branch'
alias gp='git pull'
alias gpf='git pull --ff'
alias gs='git status'
alias gmsf='git merge --squash --ff'
alias gcd='git checkout develop'
alias gc-='git checkout -'
alias gm-='git merge -'



# Ruby

alias re='rbenv exec'
alias reb='re bundle'
alias rebe='reb exec'
alias reber='rebe rails'


# Windows

if [ $(uname | grep -qe 'NT') ]; then
    # launch Explorer with pwd
    alias here='start .'
fi

# WSL

if [ $WSL_DISTRO_NAME ]; then
    # launch Explorer with pwd
    alias here='explorer.exe .'
fi

alias dcps='docker-compose ps'
alias dcud='docker-compose up -d'
alias dcudb='docker-compose up -d --build'
alias dcd='docker-compose down'
alias dcdr='docker-compose down --rmi all'

