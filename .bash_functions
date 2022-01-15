# vim: ft=sh


# colored less
function c() {
    pygmentize -O style=monokai -f console256 -g $1 | less -NRFXS
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

function mkcd() {
    DIRNAME=$1
    mkdir $DIRNAME && cd $DIRNAME
}


# function using fuzzy finder


export FUZZY_FINDER_COMMAND="fzy --line=30"

function f-cd() {
    DIR="$(find . -type d | grep -v .git | $FUZZY_FINDER_COMMAND)"

    if [ "x$DIR" != "x" ]; then
        cd "$DIR"
    else
        echo "operation was cancelled."
    fi
}


function f-vf() {
    FILE="$(find . -type f | grep -v .git | $FUZZY_FINDER_COMMAND)"

    if [ "x$FILE" != "x" ]; then
        vim "$FILE"
    else
        echo "operation was cancelled."
    fi
}


function f-gl() {
    git ls-files | $FUZZY_FINDER_COMMAND
}


function f-vgl() {
    FILE="$(f-gl)"

    if [ "x$FILE" != "x" ]; then
        vim "$FILE"
    else
        echo "operation was cancelled."
    fi
}


function f-gc() {
    BRANCH_LIST="$(git branch -a --format='%(refname:lstrip=2)' | sed -e 's/^origin\///g' | sort -u | $FUZZY_FINDER_COMMAND)"

    if [ "x$FILE" != "x" ]; then
        git checkout "$FILE"
    else
        echo "operation was cancelled."
    fi
}


function f-henry() {
    REPOSITORY="$(find ~/wk/projects/bw/ -maxdepth 1 -type d | $FUZZY_FINDER_COMMAND)"

    if [ "x$REPOSITORY" != "x" ]; then
        cd "$REPOSITORY"
    else
        echo "operation was cancelled."
    fi
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
    ls -hlA --color=always $* | less -RNSJFX
}

function llal() {
    ls -hla --color=always $* | less -RNSJFX
}

function sshinit() {
    pkill ssh-agent
    ps aux | grep ssh-agent | grep -v grep > /dev/null 2>&1
    if [ ! $? = 0 ]; then
        eval `ssh-agent`
    fi
    ssh-add ~/.ssh/id_rsa.ppk \
        && ssh -T git@github.com \
        && ssh -T git@bitbucket.org
}


function release_note() {
    RELEASE_NOTE_FILENAME=release_$(basename $(pwd))_$(date +%Y.%m.%d_%T).log

    git co master && git pull \
        && git co develop && git pull \
        && git log --oneline master..develop --merges > $RELEASE_NOTE_FILENAME \
        && vim $RELEASE_NOTE_FILENAME -c new -c GBrowse
}

function lsbinds() {
    bind -p                             \
        | grep -av '#'                  \
        | grep -av self-insert          \
        | grep -av do-lowercase-version \
        | grep -av '\[\S'               \
        | cut -d: -f1,2                 \
        | sed 's/[":]//g'               \
        | sed 's/\\e/M-/g'              \
        | xargs printf "%-10s  -  %s\n" \
        | less -NF
}
