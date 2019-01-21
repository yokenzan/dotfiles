set nocompatible


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
set cursorline
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

inoremap <C-b> <Left>
inoremap <C-f> <Right>

cmap <C-g> <Esc>
imap <C-g> <Esc>
nmap <C-g> <Esc>
omap <C-g> <Esc>
vmap <C-g> <Esc>


function! ToggleCursorLineAndColumn()
    if &cuc && &cul
        set nocul
        set nocuc
    else
        set cul
        set cuc
    endif
endfunction


nnoremap <Space>tl :<C-u>set cul!<CR>
nnoremap <Space>tc :<C-u>set cuc!<CR>
nnoremap <Space>tw :<C-u>set wrap!<CR>
nnoremap <Space>tb :<C-u>call ToggleCursorLineAndColumn()<CR>
nnoremap <Space>ms :<C-u>mks! Session.vim<CR>
nnoremap / /\v
nnoremap <Esc><Esc> :noh<CR><ESC>


command! -count=1 Glo :r! git log --oneline --no-merges -<count>


" 共有ファイルに選択範囲を出力
function! YankToSharedFile() range
    let l:filename = "path/to/shared_file"
    execute ":" . a:firstline . "," . a:lastline "w! " . l:filename
endfunction


" 共有ファイルの内容をカーソル位置に出力
function! PasteFromSharedFile()
    r path/to/shared_file
endfunction

nnoremap cy :call YankToSharedFile()<CR>
xnoremap cy :call YankToSharedFile()<CR>
nnoremap cp :<C-u>call PasteFromSharedFile()<CR>



" Setting ColorScheme

" colorscheme badwolf
" colorscheme cake
" colorscheme desert
" colorscheme koehler
" colorscheme molokai
" colorscheme monokai
" colorscheme phd
" colorscheme rupza
" colorscheme slate
" colorscheme gruvbox
colorscheme PaperColor
" colorscheme distinguished

" highlight PmenuSel guifg=white guibg=lightmagenta
" highlight SpellBad ctermbg=magenta guibg=magenta
" highlight Todo     cterm=reverse
set background=dark
" set background=light
" set notermguicolors


if executable('plantuml')
    autocmd! BufWritePost *.pu !plantuml %
endif

if executable('pandoc')
    autocmd! BufWritePost *.md !pandoc -f markdown -t html5 --css ~/.dotfiles/.github_style.css --standalone -o %:p.html %:p
endif


autocmd FileType php setlocal omnifunc=phpactor#Complete

let $BASH_ENV = "~/.bash_aliases"


if has('win32')
    set clipboard+=autoselect
endif

