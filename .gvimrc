" font config
if has('win32')
    " set guifont=Cica:h11
    " set guifontwide=Cica:h11
    set guifont=Osaka－等幅:h11
    set guifontwide=Osaka－等幅:h11
    set renderoptions=type:directx,gamma:2.2,level:5,renmode:5
else
    " set guifont=Cica\ 10
    " set guifontwide=Cica\ 10
    set guifont=Osaka－等幅\ 10
    set guifontwide=Osaka－等幅\ 10
endif


" config cursor color while IME is turned on
if has('multi_byte_ime') || has('xim')
  highlight CursorIM guibg=Purple guifg=NONE
endif


set mouse=a
set columns=140
set lines=40

set guioptions-=m
set guioptions-=M
set guioptions-=T
set guioptions-=e " apply showtabline config to GUI tabline
set guioptions+=c " use console dialog instead of popup dialog
set guioptions+=v " arrange dialog buttons vertically
set guioptions-=b
set guioptions-=r


" color
colorscheme gruvbox
set background=light

