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


if [ $(uname | grep -qe 'NT') ]; then

    function wincmd() {
        CMD=$1
            shift
            $CMD $* 2>&1 | j2u
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
    git checkout $(git branch -a --format='%(refname:lstrip=2)' | sed -e 's/^origin\///g' | sort -u | fzy --lines=30)
}


function ee() {
    w3m http://googledictionary.freecollocation.com/meaning?word=${1// /+}
}


function kv() {
    ps aux          \
        | grep vim  \
        | head -3   \
        | sed -e 's/^\w\+\s\+\(\w\+\).*/\1/g'   \
        | xargs -rp kill -s 9 
}


function mine() {
    chown $(whoami):$(whoami) $*
}


function gongkai() {
    chmod 777 $*
}


# ls with less

function lll() {
    ls -lA --color=always $* | less -RNSJFX
}

function llal() {
    ls -la --color=always $* | less -RNSJFX
}
