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
    cd "$(find -type d | fzy --lines=20)"
}


function fv() {
    vim "$(find -type f | fzy --lines=20)"
}
