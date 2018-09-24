" フォント設定
if has('win32')
    " set guifont=Cica:h11
    " set guifontwide=Cica:h11
    set guifont=Osaka－等幅:h11
    set guifontwide=Osaka－等幅:h11
    set renderoptions=type:directx,gamma:2.2,level:5,renmode:5
else
    " set guifont=Cica\ 11
    " set guifontwide=Cica\ 11
    set guifont=Osaka－等幅\ 11
    set guifontwide=Osaka－等幅\ 11
endif


" IME ON時のカーソルの色を設定
if has('multi_byte_ime') || has('xim')
  highlight CursorIM guibg=Purple guifg=NONE
endif


set mouse=a
set columns=145
set lines=45

set guioptions-=m
set guioptions-=T

autocmd GUIEnter    * set transparency=255
autocmd FocusGained * set transparency=255
autocmd FocusLost   * set transparency=200


colorscheme rupza
