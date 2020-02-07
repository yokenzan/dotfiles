" font config
set guifont=Migu\ 1M\ for\ Powerline\ 10
set guifontwide=Migu\ 1M\ for\ Powerline\ 10


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
colorscheme dream-light

set background=light
