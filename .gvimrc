"if has('kaoriya')
set t_Co=256
colorscheme zenburn "カラースキーマを設定
set antialias
set showtabline=2 "常にタブ表示
"透明度の変更
if has('win32') || has('win64')
  gui "おまじない
  set transparency=245
elseif has('gui_macvim')
  set transparency=10
endif
"endif

""起動時全画面化
"if has('gui_running')
"  set fuoptions=maxvert,maxhorz
"  au GUIEnter * set fullscreen
"endif
