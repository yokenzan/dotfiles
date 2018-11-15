if &compatible
    set nocompatible
endif


" Setting dein.vim

set runtimepath+=~/.vim
set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim
let s:dein_dir = has('win32') ? expand('~/.vim/dein/win32') : expand('~/.vim/dein')

if dein#load_state(s:dein_dir)
    call dein#begin(s:dein_dir)

    let s:toml_dir     = $HOME . '/' . '.vim/dein/.config/toml'
    let s:startup_toml = s:toml_dir . '/' . 'dein_startup.toml'
    let s:lazy_toml    = s:toml_dir . '/' . 'dein_lazy.toml'

    call dein#load_toml(s:startup_toml, { 'lazy' : 0 })
    call dein#load_toml(s:lazy_toml,    { 'lazy' : 1 })

    call dein#end()
    call dein#save_state()
endif


" Setting Dir

set undodir=~/.vim/undo
set backupdir=~/.vim/backup
set directory=~/.vim/swap


" Setting Encodings and Formats

set encoding=utf-8
scriptencoding utf-8
set fileencoding=utf-8
set fileencodings=utf-8,cp932,euc-jp
set fileformats=unix,dos,mac
set ambiwidth=double
set formatoptions+=mMj


" Setting Title and CommandLine

set showcmd
set title
set ruler
set cmdheight=2
set laststatus=2
set showtabline=2


" Setting Visibility of Line Number or Current Line and Column

set number
set nocursorline
set nocursorcolumn


" Setting Color

syntax on
set t_Co=256
set termguicolors
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"


" Setting Visibility of TAB RETURN EOL SPACE etc

set list
set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%
set showbreak=↪


" Setting TAB and Indent

filetype plugin indent on
set autoindent
set smartindent
set expandtab
set softtabstop=4
set shiftwidth=4
set tabstop=4


" Setting Behavior of Cursor

set whichwrap=h,l,<,>,b
set backspace=indent,eol,start


" Setting Search

set wrapscan
set incsearch
set ignorecase
set smartcase
set hlsearch


" Setting Parens

set showmatch
set matchpairs+=（:）,「:」,『:』,｛:｝
set matchtime=1

source $VIMRUNTIME/macros/matchit.vim


" Disable Auto Indent When Paste Characters

if &term =~ "xterm" || &term =~ "screen"
    let &t_SI .= "\e[?2004h"
    let &t_EI .= "\e[?2004l"
    let &pastetoggle = "\e[201~"

    function! XTermPasteBegin(ret)
        set paste
        return a:ret
    endfunction

    inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
endif


" Setting Mouse Control

if has('mouse')
    set mouse=a
    if has('mouse_sgr')
        set ttymouse=sgr
    elseif v:version > 703 || v:version is 703 && has('patch632')
        set ttymouse=sgr
    else
        set ttymouse=xterm2
    endif
endif


" Other Settings

set wildmenu
set wildmode=list:longest,full
set scrolloff=4
set iminsert=0
set display=lastline
set pumheight=30
set ttimeoutlen=30
set hidden


" Setting Sessions

set sessionoptions-=options
if has('win32')
    set sessionoptions+=slash
    set sessionoptions+=unix
endif


" Setting Additional Keybinds

nnoremap Y y$

inoremap <expr> <Tab>   pumvisible() ? "\<Tab>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<S-Tab>" : "\<S-Tab>"

inoremap <C-k> <Up>
inoremap <C-b> <Left>
inoremap <C-f> <Right>

cmap <C-g> <Esc>
imap <C-g> <Esc>
nmap <C-g> <Esc>
omap <C-g> <Esc>
vmap <C-g> <Esc>


function! ToggleCursorLine()
    if &cul
        set nocul
    else
        set cul
    endif
endfunction

function! ToggleCursorColumn()
    if &cuc
        set nocuc
    else
        set cuc
    endif
endfunction

function! ToggleCursorLineAndColumn()
    if &cuc && &cul
        set nocul
        set nocuc
    else
        set cul
        set cuc
    endif
endfunction

function! ToggleLineWrapping()
    if &wrap
        set nowrap
    else
        set wrap
    endif
endfunction


nnoremap <silent> <Space>tl :<C-u>call ToggleCursorLine()<CR>
nnoremap <silent> <Space>tc :<C-u>call ToggleCursorColumn()<CR>
nnoremap <silent> <Space>tb :<C-u>call ToggleCursorLineAndColumn()<CR>
nnoremap <silent> <Space>tw :<C-u>call ToggleLineWrapping()<CR>
nnoremap <silent> <Space>ms :<C-u>mks! Session.vim<CR>




" Setting ColorScheme

" colorscheme apprentice
" colorscheme adventurous
colorscheme badwolf
" colorscheme cake
" colorscheme desert
" colorscheme kalisi
" colorscheme koehler
" colorscheme molokai
" colorscheme moneyforward
" colorscheme monokai
" colorscheme phd
" colorscheme rupza
" colorscheme slate
" colorscheme southernlights
" colorscheme strawberry-light
" colorscheme summerfruit256
" colorscheme seoul256
" colorscheme seoul256-light
" colorscheme gruvbox
colorscheme PaperColor
" colorscheme distinguished
" colorscheme hemisu

" highlight PmenuSel guifg=white guibg=lightmagenta
" highlight SpellBad ctermbg=magenta guibg=magenta
" highlight Todo     cterm=reverse
set background=dark
" set background=light
" set notermguicolors

if has('win32')
    autocmd BufWritePost *.md !/user/AppData/Local/Pandoc/pandoc -f markdown -t html5 --css /tools/pandoc/style.css --standalone -o %:p.html %:p
endif


autocmd FileType php setlocal omnifunc=phpactor#Complete

let $BASH_ENV = "~/.bash_aliases"


if has('win32')
    set clipboard+=autoselect
endif

