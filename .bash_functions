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


export FUZZY_FINDER_COMMAND="fzy --show-scores --line=30"
export FUZZY_FINDER_COMMAND_WITH_QUERY="fzy --show-scores --line=30 --query="


# make user choise one from candidate list and return it
function __fuzzy() {
    CANDIDATE_FILEPATH="$1"
    QUERY="$2"
    COMMAND_WITH_QUERY="$FUZZY_FINDER_COMMAND_WITH_QUERY"$QUERY""

    COMMAND=

    if [ "x$QUERY" == "x" ]; then
        COMMAND="$FUZZY_FINDER_COMMAND"
    else
        COMMAND="$COMMAND_WITH_QUERY"
    fi

    RESULT="$(cat $CANDIDATE_FILEPATH | $COMMAND)"

    if [ "x$RESULT" != "x" -a  "x$RESULT" != "xcat $CANDIDATE_FILEPATH | $COMMAND" ]; then
        echo $RESULT
    fi
}


function f-cd() {
    QUERY="$1"
    TEMPFILE=$(mktemp)

    # create candidate list and write it into tempfile
    find . -type d | grep -v .git | grep -v cache > $TEMPFILE

    # item chosen by user
    CHOSEN="$(__fuzzy "$TEMPFILE" "$QUERY")"

    if [ "x$CHOSEN" != "x" ]; then
        cd "$CHOSEN"
    else
        echo "operation was cancelled."
    fi

    trap 'rm -f $TEMPFILE; echo aaaa' EXIT PIPE TERM INT
}


function f-vf() {
    QUERY="$1"
    TEMPFILE=$(mktemp)

    # create candidate list and write it into tempfile
    find . -type f | grep -v .git | grep -v cache > $TEMPFILE

    # item chosen by user
    CHOSEN="$(__fuzzy "$TEMPFILE" "$QUERY")"

    if [ "x$CHOSEN" != "x" ]; then
        $EDITOR "$CHOSEN"
    else
        echo "operation was cancelled."
    fi

    trap 'rm -f $TEMPFILE; echo aaaa' EXIT PIPE TERM INT
}


function f-gl() {
    git ls-files | $FUZZY_FINDER_COMMAND
}


function f-vgl() {
    FILE="$(f-gl)"

    if [ "x$FILE" != "x" ]; then
        $EDITOR "$FILE"
    else
        echo "operation was cancelled."
    fi
}


function f-gc() {
    BRANCH_LIST="$(git branch -a --format='%(refname:lstrip=2)' | sed -e 's/^origin\///g' | sort -u | $FUZZY_FINDER_COMMAND)"

    if [ "x$BRANCH_LIST" != "x" ]; then
        git checkout "$BRANCH_LIST"
    else
        echo "operation was cancelled."
    fi
}


function f-h() {
    QUERY="$1"
    TEMPFILE=$(mktemp)

    # create candidate list and write it into tempfile
    find ~/wk/projects/bw/ -maxdepth 1 -type d > $TEMPFILE

    # item chosen by user
    CHOSEN="$(__fuzzy "$TEMPFILE" "$QUERY")"

    if [ "x$CHOSEN" != "x" ]; then
        cd "$CHOSEN"
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
