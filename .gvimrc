" font config
"
set guifont=Iosevka\ TermLig\ Curly\ Slab\ 9
set guifontwide=Sarasa\ Mono\ T\ J\ 9

set mouse=a
set columns=150
set lines=45

set guioptions-=m
set guioptions-=M
set guioptions-=T
set guioptions-=e " apply showtabline config to GUI tabline
set guioptions+=c " use console dialog instead of popup dialog
set guioptions+=v " arrange dialog buttons vertically
set guioptions-=b
set guioptions-=r

imap <expr><M-v> pumvisible() ? "\<C-p>\<C-p>\<C-p>\<C-p>" : "\<C-[>v"

nnoremap <silent><M-h> <C-w>h
nnoremap <silent><M-j> <C-w>j
nnoremap <silent><M-k> <C-w>k
nnoremap <silent><M-l> <C-w>l
nnoremap <silent><M-c> <C-w>c
nnoremap <silent><M-r> <C-w>r

cnoremap <silent><M-b> <S-Left>
cnoremap <silent><M-f> <S-Right>

source $HOME/.gvimrc.colorscheme
