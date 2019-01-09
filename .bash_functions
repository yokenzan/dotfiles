
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
    sudo chmod -R 777 .

    ctags --recurse=yes --append=no --languages=PHP --exclude=*.css --exclude=_ide_helper.php
    gtags

    composer dump-autoload

    echo
    echo

    php artisan ide-helper:generate -H

    echo
    echo

    ./phpunit --color=always
}


if [ $(echo $OS | grep -e 'Windows') ]; then

    function wincmd() {
        CMD=$1
            shift
            $CMD $* 2>&1 | iconv -f CP932 -t UTF-8
    }


    function pu2svg() {
        cat $1 | iconv -f utf-8 -t cp932 | /c/ProgramData/Oracle/Java/javapath/java -jar /c/ProgramData/Chocolatey/lib/plantuml/tools/plantuml.jar -tsvg -p > $1.svg
    }

    function pu2png() {
        cat $1 | iconv -f utf-8 -t cp932 | /c/ProgramData/Oracle/Java/javapath/java -jar /c/ProgramData/Chocolatey/lib/plantuml/tools/plantuml.jar -tpng -p > $1.png
    }


    function viewpu() {
        pu2png $1
        img2sixel $1.png
    }


    function md2html() {
        /user/AppData/Local/Pandoc/pandoc -f markdown -t html5 --css /tools/pandoc/style.css --standalone -o $1.html $1
    }
fi

