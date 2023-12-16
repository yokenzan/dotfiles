if &compatible
    set nocompatible
endif

" when running without  TMUX, these key press arent same.
"
" - <CR>  and <C-m>
" - <Esc> and <C-[>

" Setting dein.vim

set runtimepath+=~/.vim
set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim
let s:dein_dir = has('win32') ? expand('~/.vim/dein/win32') : expand('~/.vim/dein')

if dein#load_state(s:dein_dir)
    call dein#begin(s:dein_dir)

    let s:toml_dir         = $HOME . '/' . '.vim/dein/.config/toml'
    let s:startup_toml     = s:toml_dir . '/' . 'dein_startup.toml'
    let s:syntax_toml      = s:toml_dir . '/' . 'dein_syntax.toml'
    let s:completion_toml  = s:toml_dir . '/' . 'dein_completion.toml'
    " let s:completion_toml  = s:toml_dir . '/' . 'dein_completion_vim-lsp.toml'
    let s:colorscheme_toml = s:toml_dir . '/' . 'dein_colorscheme.toml'
    let s:lazy_toml        = s:toml_dir . '/' . 'dein_lazy.toml'

    call dein#load_toml(s:startup_toml,     { 'lazy' : 0 })
    call dein#load_toml(s:syntax_toml,      { 'lazy' : 0 })
    call dein#load_toml(s:completion_toml,  { 'lazy' : 0 })
    call dein#load_toml(s:colorscheme_toml, { 'lazy' : 0 })
    call dein#load_toml(s:lazy_toml,        { 'lazy' : 1 })

    if v:version >= 900
        let s:denops_toml = s:toml_dir . '/' . 'dein_denops.toml'
        call dein#load_toml(s:denops_toml, { 'lazy' : 0 })
    endif

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
set showtabline=1
set number


" Setting Visibility of TAB RETURN EOL SPACE etc

set list
set listchars=tab:^-,trail:~,eol:↲,extends:»,precedes:«,nbsp:%
set showbreak=↪


" Setting TAB and Indent

filetype plugin indent on
set autoindent
set smartindent
set breakindent
set expandtab
set softtabstop=4
set shiftwidth=4
set tabstop=4


" Setting Behavior of Cursor

set whichwrap=h,l,<,>,b,[,]
set backspace=indent,eol,start


" Setting Search

set nowrapscan
set incsearch
set ignorecase
set smartcase
set hlsearch


" Setting Parens

set showmatch
set matchpairs+=（:）,「:」,『:』,｛:｝,＜:＞,【:】,〔:〕,“:”
set matchtime=1

source $VIMRUNTIME/macros/matchit.vim
runtime ftplugin/man.vim


" Disable Auto Indent When Paste Characters

" if &term =~ 'xterm' || &term =~ 'screen'
    let &t_SI .= "\e[?2004h"
    let &t_EI .= "\e[?2004l"
    let &pastetoggle = "\e[201~"

    function! XTermPasteBegin(ret)
        set paste
        return a:ret
    endfunction

    inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
" endif


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
set iminsert=2
set imsearch=-1
set display=lastline
set pumheight=30
set ttimeoutlen=30
set hidden              " allow buffers hide from screen without saving
set updatetime=100
set signcolumn=yes
set conceallevel=0


" Setting Sessions

set sessionoptions-=options
if has('win32')
    set sessionoptions+=slash
    set sessionoptions+=unix
endif



nnoremap Y y$


inoremap <C-b> <Left>
inoremap <C-f> <Right>

" https://zenn.dev/kato_k/articles/vim-tips-no002
inoremap <C-v>u <C-r>=nr2char(0x)<Left>


function! ToggleCursorLineAndColumn()
    if &cursorcolumn && &cursorline
        set nocursorline
        set nocursorcolumn
    else
        set cursorline
        set cursorcolumn
    endif
endfunction

function! ToggleBackground()
    if &background == 'dark'
        set background=light
    else
        set background=dark
    endif
endfunction

function! ToggleConcealLevel()
    if &conceallevel == 0
        set conceallevel=2
    else
        set conceallevel=0
    endif
endfunction

nnoremap <silent><Space>tl :<C-u>set cul!<CR>
nnoremap <silent><Space>tc :<C-u>set cuc!<CR>
nnoremap <silent><Space>tw :<C-u>set wrap!<CR>
nnoremap <silent><Space>tb :<C-u>call ToggleCursorLineAndColumn()<CR>
nnoremap <silent><Space>tB :<C-u>call ToggleBackground()<CR>
nnoremap <silent><Space>tS :<C-u>set spell!<CR>
nnoremap <silent><Space>tp :<C-u>set paste!<CR>
nnoremap <silent><Space>tC :<C-u>call ToggleConcealLevel()<CR>
nnoremap <Space>ms :<C-u>mks! Session.vim<CR>
nnoremap /  /\v
nnoremap // /\V
nnoremap ?  ?\v
nnoremap ?/ ?\V
" nnoremap <silent><C-[><C-[> :<C-u>noh<CR><Esc>


" 手動のクリップボード連携
if !has('clipboard')
    function! YankToSharedFile() range
        if executable('xsel')
            silent '<,'>w !xsel --clipboard --input
        else
            let l:filename = "path/to/shared_file"
            execute ":" . a:firstline . "," . a:lastline "w! " . l:filename
        endif
    endfunction


    function! PasteFromSharedFile()
        if executable('xsel')
            r !xsel -bo
        else
            r path/to/shared_file
        endif
    endfunction


    nnoremap <silent>cy :call YankToSharedFile()<CR>
    xnoremap <silent>cy :call YankToSharedFile()<CR>
    nnoremap <silent>cp :<C-u>call PasteFromSharedFile()<CR>
endif



" if executable('plantuml')
"     augroup PlantUMLAutoCommand
"         autocmd!
"         autocmd! BufWritePost *.pu Dispatch java -jar /usr/share/plantuml/plantuml.jar -tsvg %
"     augroup END
" endif

" if executable('pandoc')
"     augroup PandocAutoCommand
"         autocmd!
"         autocmd! BufWritePost *.md !pandoc -f markdown -t html5 --css ~/.dotfiles/github.css --standalone -o %:r.html %:p
"     augroup END
" endif

set dictionary=/usr/share/dict/words,spell
set thesaurus=~/.vim/thesaurus.txt
set spelllang=en,cjk,medical

" for phpactor

autocmd FileType php setlocal omnifunc=phpactor#Complete
" autocmd FileType php setlocal iskeyword+=$

set completeopt=noinsert,menuone,noselect
set shortmess+=a
set shortmess-=w
set shortmess-=c



nnoremap <Space><Space>s  :<C-u>source Session.vim<CR>

" search motions with digraphs
nnoremap <silent><Space><Space>f f<C-k>
nnoremap <silent><Space><Space>t t<C-k>
nnoremap <silent><Space><Space>F F<C-k>
nnoremap <silent><Space><Space>T T<C-k>
onoremap <silent><Space><Space>f f<C-k>
onoremap <silent><Space><Space>t t<C-k>
onoremap <silent><Space><Space>F F<C-k>
onoremap <silent><Space><Space>T T<C-k>
vnoremap <silent><Space><Space>f f<C-k>
vnoremap <silent><Space><Space>t t<C-k>
vnoremap <silent><Space><Space>F F<C-k>
vnoremap <silent><Space><Space>T T<C-k>


" keep region selecting after indent

vnoremap < <gv
vnoremap > >gv


let $BASH_ENV = '~/.bash_aliases'


" Line/Column Highlight Setting

autocmd BufEnter,WinEnter * setlocal cursorline
autocmd BufLeave,WinLeave * setlocal nocursorline
autocmd BufLeave,WinLeave * setlocal nocursorcolumn


imap <expr><C-v>  pumvisible() ? "\<C-n>\<C-n>\<C-n>\<C-n>" : "\<C-v>"
imap <expr><C-[>v pumvisible() ? "\<C-p>\<C-p>\<C-p>\<C-p>" : "\<C-[>v"

nnoremap <silent><C-[>h <C-w>h
nnoremap <silent><C-[>j <C-w>j
nnoremap <silent><C-[>k <C-w>k
nnoremap <silent><C-[>l <C-w>l
nnoremap <silent><C-[>c <C-w>c
nnoremap <silent><C-[>r <C-w>r

nnoremap <silent><Esc>h <C-w>h
nnoremap <silent><Esc>j <C-w>j
nnoremap <silent><Esc>k <C-w>k
nnoremap <silent><Esc>l <C-w>l
nnoremap <silent><Esc>c <C-w>c
nnoremap <silent><Esc>r <C-w>r

nnoremap Q   4
nnoremap QQ  8
nnoremap QQQ 16
onoremap Q   4
onoremap QQ  8
onoremap QQQ 16
xnoremap Q   4
xnoremap QQ  8
xnoremap QQQ 16

nnoremap <silent><C-n> :<C-u>bn<CR>
nnoremap <silent><C-p> :<C-u>bN<CR>

nnoremap ]q :<C-u>cn<CR>
nnoremap [q :<C-u>cN<CR>

cnoremap <silent><C-[>b <S-Left>
cnoremap <silent><C-[>f <S-Right>

nnoremap <silent><C-s>s :<C-u>terminal ++rows=20<CR>
nnoremap <silent><C-s>v :<C-u>vertical terminal<CR>
nnoremap <silent><C-s>p :<C-u>call popup_create(term_start([&shell], #{ hidden: 1, term_finish: 'close'}), #{ border: [], minwidth: &columns/2, minheight: &lines/2 })<CR>

snoremap <silent><C-b> <S-Left>
snoremap <silent><C-f> <S-Right>

nnoremap [j F<C-k>_.
nnoremap ]j f<C-k>_.
nnoremap [J F<C-k>_,
nnoremap ]J f<C-k>_,
onoremap [j F<C-k>_.
onoremap ]j f<C-k>_.
onoremap [J F<C-k>_,
onoremap ]J f<C-k>_,
vnoremap [j F<C-k>_.
vnoremap ]j f<C-k>_.
vnoremap [J F<C-k>_,
vnoremap ]J f<C-k>_,


" set gdefault
" set colorcolumn=100
" needed for showing ^X mode in completion
set showmode
set lazyredraw

set splitbelow
set splitright
set autoread

set diffopt=internal,filler,algorithm:histogram,indent-heuristic


" Load Color Config
if !has('gui_running')
    source $HOME/.vimrc.colorscheme
endif

nnoremap <Leader>R <Nop>
nnoremap <Leader>C :<C-u>Copen<CR>

if filereadable('./.vimrc.project')
    source ./.vimrc.project
endif
if filereadable('./.vim/.vimrc')
    source ./.vim/.vimrc
endif


function! UkeGetPreviewedText(uke_text) abort
    return system('receiptisan --preview', a:uke_text)
endfunction

function! UkePopupPreview(start, end) abort
    let l:uke_text = getline(a:start, a:end)

    if empty(l:uke_text)
        call echomsg('text is empty')
        return
    endif

    let l:previewed_text = UkeGetPreviewedText(l:uke_text)

    call popup_atcursor(split(l:previewed_text, "\n"), {})
endfunction

augroup MyCmdGroup
    " camel -> snake
    command! -range Camel2Snake :<line1>,<line2>s/\%V\(_\|\<\)\([a-zA-Z0-9]\)\([a-zA-Z0-9]\+\)\?/\u\2\L\3\E/g

    command! -count=1 Glo :r! git log --oneline --no-merges -<count>

    command! -range WhiteSpaceToTab :<line1>,<line2>s/    /\t/g

    command! -range UkePreview call UkePopupPreview(<line1>, <line2>)

    command! -range RemoveExtraCR :<line1>,<line2>s///g
augroup END


au BufNewFile,BufRead *.uke setf uke
au BufNewFile,BufRead *.UKE setf uke
au BufNewFile,BufRead *.hen setf hen
au BufNewFile,BufRead *.HEN setf hen


" manage IME states
" https://www.regentechlog.com/2022/06/30/control-ime-by-vim/#%E8%A7%A3%E6%B1%BA%E7%AD%96
if exists('$TMUX')
    " when start insert mode
    let &t_SI.="Ptmux;[<r\\"
    " when leave from insert mode
    let &t_EI.="Ptmux;[<s[<0t\\"
    " when quit Vim
    let &t_te.="Ptmux;[<0t[<s\\"
else
    let &t_SI.="[<r"
    let &t_EI.="[<s[<0t"
    let &t_te.="[<0t[<s"
end

function! RetrySpellCompletion()
    if complete_info(['mode']).mode == 'spell' && !&spell
        set spell
        echo 'spell checking is enabled'
    endif
endfunction

au CompleteDonePre * call RetrySpellCompletion()
