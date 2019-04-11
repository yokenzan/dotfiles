# vim: ft=sh


# colored less
function c() {
    pygmentize -O style=monokai -f console256 -g $1 | less -NR
}


# Ex) grepr before after dir1/ dir2/
function grepr() {
    BEFORE=$1
    AFTER=$2
    shift
    shift
    grep $* -rle "${BEFORE}" | xargs sed -i -e "s/${BEFORE}/${AFTER}/g"
}


# for PHP Laravel
function laravel_update() {
    echo ">>> chmod..."

    sudo chmod -R 777 .

    echo ">>> generating tag files..."

    ctags --recurse=yes --append=no --languages=PHP --exclude=*.css --exclude=_ide_helper.php

    echo ">>> generating gtag files..."

    gtags

    echo ">>> executing composer..."

    composer dump-autoload

    echo ">>> done!"
}


if [ $(uname | grep -qe 'NT') ]; then

    function wincmd() {
        CMD=$1
            shift
            $CMD $* 2>&1 | j2u
    }


    function pu2svg() {
        plantuml $1
    }


    function md2html() {
        pandoc -f markdown -t html5 --css ~/.dotfiles/github.css --standalone -o $1.html $1
    }
fi


function r() {
    if [ -z "$RANGER_LEVEL" ]; then
        ranger $@
    else
        exit
    fi
}



function fcd() {
    cd "$(find -H -type d | grep -v .git | fzy --lines=30)"
}


function fv() {
    vim "$(find -type f | grep -v .git | fzy --lines=30)"
}


function fgl() {
    git ls-files | fzy --lines=30
}


function vfg() {
    vim "$(git ls-files | fzy --lines=30)"
}


function fgc() {
    git checkout $(git branch --format='%(refname:lstrip=2)' | fzy --lines=30)
}


function ee() {
    w3m http://googledictionary.freecollocation.com/meaning?word=${1// /+}
}

